/* ============================================================================
   03 · WAREHOUSE UTILIZATION & RIGHT-SIZING SIGNAL
   ----------------------------------------------------------------------------
   Surfaces warehouses that are oversized (low queued load, high idle) or
   undersized (persistent queueing / spilling). Right-sizing here is the
   single highest-ROI cost lever in most Snowflake accounts.
   ============================================================================ */

USE ROLE COST_GOVERNANCE_RO;
USE WAREHOUSE WH_GOVERNANCE;

CREATE OR REPLACE VIEW GOVERNANCE.COST.V_WH_UTILIZATION AS
WITH load AS (
    SELECT
        warehouse_name,
        DATE_TRUNC('day', start_time)              AS usage_date,
        AVG(avg_running)                           AS avg_running,
        AVG(avg_queued_load)                       AS avg_queued_load,
        AVG(avg_blocked)                           AS avg_blocked
    FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_LOAD_HISTORY
    WHERE start_time >= DATEADD('day', -30, CURRENT_TIMESTAMP())
    GROUP BY 1, 2
),
spend AS (
    SELECT
        warehouse_name,
        DATE_TRUNC('day', start_time)              AS usage_date,
        SUM(credits_used)                          AS credits_used
    FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
    WHERE start_time >= DATEADD('day', -30, CURRENT_TIMESTAMP())
    GROUP BY 1, 2
)
SELECT
    l.warehouse_name,
    ROUND(SUM(s.credits_used), 1)                  AS credits_30d,
    ROUND(AVG(l.avg_running), 2)                   AS avg_running,
    ROUND(AVG(l.avg_queued_load), 2)               AS avg_queued_load,
    CASE
        WHEN AVG(l.avg_queued_load) > 1        THEN '⚠️ UNDERSIZED — persistent queueing'
        WHEN AVG(l.avg_running)     < 0.15     THEN '💸 OVERSIZED — mostly idle, downsize / consolidate'
        ELSE '✅ HEALTHY'
    END                                            AS recommendation
FROM load l
JOIN spend s ON s.warehouse_name = l.warehouse_name
            AND s.usage_date     = l.usage_date
GROUP BY l.warehouse_name
ORDER BY credits_30d DESC;

SELECT * FROM GOVERNANCE.COST.V_WH_UTILIZATION;
