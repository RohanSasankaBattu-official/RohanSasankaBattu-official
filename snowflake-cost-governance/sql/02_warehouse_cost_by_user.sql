/* ============================================================================
   02 · USER-LEVEL COST ATTRIBUTION
   ----------------------------------------------------------------------------
   Attributes warehouse credit spend down to the individual user by joining
   metering history to query attribution. This is the view that turns an
   opaque monthly bill into "who is spending what" — the lever behind
   real cost accountability.
   ============================================================================ */

USE ROLE COST_GOVERNANCE_RO;
USE WAREHOUSE WH_GOVERNANCE;

CREATE OR REPLACE VIEW GOVERNANCE.COST.V_CREDITS_BY_USER AS
WITH query_credits AS (
    -- Approximate per-query credit share from execution time on each WH
    SELECT
        qh.user_name,
        qh.warehouse_name,
        DATE_TRUNC('day', qh.start_time)                         AS usage_date,
        SUM(qh.execution_time) / 1000 / 3600                     AS exec_hours,
        COUNT(*)                                                 AS query_count
    FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY qh
    WHERE qh.warehouse_name IS NOT NULL
      AND qh.start_time >= DATEADD('day', -90, CURRENT_TIMESTAMP())
    GROUP BY 1, 2, 3
),
wh_credits AS (
    -- Actual credits consumed per warehouse per day (source of truth)
    SELECT
        warehouse_name,
        DATE_TRUNC('day', start_time)                           AS usage_date,
        SUM(credits_used)                                       AS credits_used
    FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
    WHERE start_time >= DATEADD('day', -90, CURRENT_TIMESTAMP())
    GROUP BY 1, 2
),
wh_daily_hours AS (
    SELECT warehouse_name, usage_date, SUM(exec_hours) AS total_exec_hours
    FROM query_credits GROUP BY 1, 2
)
SELECT
    qc.user_name,
    qc.warehouse_name,
    qc.usage_date,
    qc.query_count,
    ROUND(qc.exec_hours, 2)                                     AS user_exec_hours,
    -- Allocate day's WH credits proportionally to each user's exec time
    ROUND(
        wc.credits_used
        * IFF(dh.total_exec_hours = 0, 0, qc.exec_hours / dh.total_exec_hours)
    , 3)                                                       AS attributed_credits
FROM query_credits    qc
JOIN wh_credits       wc ON wc.warehouse_name = qc.warehouse_name
                        AND wc.usage_date     = qc.usage_date
JOIN wh_daily_hours   dh ON dh.warehouse_name = qc.warehouse_name
                        AND dh.usage_date     = qc.usage_date;

-- Top spenders, last 30 days
SELECT user_name,
       ROUND(SUM(attributed_credits), 1)          AS credits_30d,
       SUM(query_count)                           AS queries_30d
FROM GOVERNANCE.COST.V_CREDITS_BY_USER
WHERE usage_date >= DATEADD('day', -30, CURRENT_DATE())
GROUP BY user_name
ORDER BY credits_30d DESC
LIMIT 25;
