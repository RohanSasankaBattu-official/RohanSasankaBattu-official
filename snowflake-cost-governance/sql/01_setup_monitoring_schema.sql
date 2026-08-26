/* ============================================================================
   01 · GOVERNANCE MONITORING FOUNDATION
   ----------------------------------------------------------------------------
   Creates a dedicated, least-privilege monitoring layer that reads from
   SNOWFLAKE.ACCOUNT_USAGE without granting broad ACCOUNTADMIN access.
   Run once as ACCOUNTADMIN (or a role with the required grants).
   ============================================================================ */

-- ---- Dedicated role for cost/observability, decoupled from ACCOUNTADMIN -----
USE ROLE ACCOUNTADMIN;

CREATE ROLE IF NOT EXISTS COST_GOVERNANCE_RO
    COMMENT = 'Read-only role for cost governance & warehouse observability';

-- Least-privilege: only the ACCOUNT_USAGE views the toolkit actually reads.
GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE COST_GOVERNANCE_RO;

-- ---- Governance database + schema to hold curated cost data products -------
CREATE DATABASE IF NOT EXISTS GOVERNANCE
    COMMENT = 'Curated cost, usage & security data products';
CREATE SCHEMA IF NOT EXISTS GOVERNANCE.COST
    COMMENT = 'Warehouse spend, utilization & optimization models';

GRANT USAGE ON DATABASE GOVERNANCE TO ROLE COST_GOVERNANCE_RO;
GRANT USAGE ON SCHEMA GOVERNANCE.COST TO ROLE COST_GOVERNANCE_RO;
GRANT SELECT ON ALL VIEWS IN SCHEMA GOVERNANCE.COST TO ROLE COST_GOVERNANCE_RO;
GRANT SELECT ON FUTURE VIEWS IN SCHEMA GOVERNANCE.COST TO ROLE COST_GOVERNANCE_RO;

-- ---- A small XS warehouse just for governance queries (never oversize) -----
CREATE WAREHOUSE IF NOT EXISTS WH_GOVERNANCE
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND   = 60          -- suspend fast; this WH should cost pennies
    AUTO_RESUME    = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Dedicated XS warehouse for cost-governance reporting only';

GRANT USAGE ON WAREHOUSE WH_GOVERNANCE TO ROLE COST_GOVERNANCE_RO;

/* Note: ACCOUNT_USAGE views have latency (up to ~45 min for metering,
   up to ~3 h for some views). Design dashboards around T-1 completeness. */
