/* ============================================================================
   04 · IDLE SPEND + DAILY ANOMALY DETECTION
   ----------------------------------------------------------------------------
   (a) Flags warehouses burning credits with near-zero query activity
       (auto-suspend misconfigured, or abandoned).
   (b) Flags days where account credit spend deviates > 2 std-dev from the
       trailing 30-day baseline — early warning on runaway jobs.
   ============================================================================ */

USE ROLE COST_GOVERNANCE_RO;
USE WAREHOUSE WH_GOVERNANCE;

-- (a) Idle-but-billing warehouses -------------------------------------------
CREATE OR REPLACE VIEW GOVERNANCE.COST.V_IDLE_WAREHOUSES AS
WITH wh AS (
    SELECT warehouse_name, SUM(credits_used) AS credits_7d
    FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
    WHERE start_time >= DATEADD('day', -7, CURRENT_TIMESTAMP())
    GROUP BY 1
),
q AS (
    SELECT warehouse_name, COUNT(*) AS queries_7d
    FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
    WHERE start_time >= DATEADD('day', -7, CURRENT_TIMESTAMP())
      AND warehouse_name IS NOT NULL
    GROUP BY 1
)
SELECT
    wh.warehouse_name,
    ROUND(wh.credits_7d, 1)                 AS credits_7d,
    COALESCE(q.queries_7d, 0)               AS queries_7d,
    ROUND(wh.credits_7d
          / NULLIF(COALESCE(q.queries_7d, 0), 0), 2) AS credits_per_query
FROM wh LEFT JOIN q ON q.warehouse_name = wh.warehouse_name
WHERE wh.credits_7d > 1
  AND COALESCE(q.queries_7d, 0) < 50        -- billing but barely used
ORDER BY credits_7d DESC;

-- (b) Daily spend anomaly (z-score) -----------------------------------------
CREATE OR REPLACE VIEW GOVERNANCE.COST.V_SPEND_ANOMALIES AS
WITH daily AS (
    SELECT DATE_TRUNC('day', start_time) AS d, SUM(credits_used) AS credits
    FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
    WHERE start_time >= DATEADD('day', -30, CURRENT_TIMESTAMP())
    GROUP BY 1
),
stats AS (SELECT AVG(credits) mu, STDDEV(credits) sd FROM daily)
SELECT d                                        AS usage_date,
       ROUND(credits, 1)                        AS credits,
       ROUND((credits - mu) / NULLIF(sd, 0), 2) AS z_score,
       IFF((credits - mu) / NULLIF(sd, 0) > 2, '🚨 SPIKE', '') AS flag
FROM daily, stats
ORDER BY usage_date DESC;

SELECT * FROM GOVERNANCE.COST.V_IDLE_WAREHOUSES;
SELECT * FROM GOVERNANCE.COST.V_SPEND_ANOMALIES WHERE flag = '🚨 SPIKE';
