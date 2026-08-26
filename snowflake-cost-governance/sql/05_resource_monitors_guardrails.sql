/* ============================================================================
   05 · RESOURCE MONITORS — HARD GUARDRAILS
   ----------------------------------------------------------------------------
   Prevention beats reporting. Resource monitors cap credit burn per POD /
   environment and notify (or suspend) before spend runs away. Adjust the
   quotas to your contract.  Run as ACCOUNTADMIN.
   ============================================================================ */

USE ROLE ACCOUNTADMIN;

-- Monthly quota per delivery POD, notify early, suspend at the ceiling -------
CREATE OR REPLACE RESOURCE MONITOR RM_POD_ANALYTICS
    WITH CREDIT_QUOTA        = 500          -- monthly credits for this POD
         FREQUENCY           = MONTHLY
         START_TIMESTAMP     = IMMEDIATELY
    TRIGGERS
        ON 60  PERCENT DO NOTIFY                 -- early heads-up
        ON 85  PERCENT DO NOTIFY                 -- owner check-in
        ON 100 PERCENT DO SUSPEND                -- let running queries finish
        ON 110 PERCENT DO SUSPEND_IMMEDIATE;     -- hard stop

-- Attach the monitor to the warehouses that POD uses -------------------------
ALTER WAREHOUSE WH_ANALYTICS_POD  SET RESOURCE_MONITOR = RM_POD_ANALYTICS;

-- Account-wide backstop so no single WH can ever blow the whole budget -------
CREATE OR REPLACE RESOURCE MONITOR RM_ACCOUNT_BACKSTOP
    WITH CREDIT_QUOTA = 5000
         FREQUENCY    = MONTHLY
         START_TIMESTAMP = IMMEDIATELY
    TRIGGERS
        ON 90  PERCENT DO NOTIFY
        ON 100 PERCENT DO SUSPEND;

ALTER ACCOUNT SET RESOURCE_MONITOR = RM_ACCOUNT_BACKSTOP;

/* Governance tip: version these monitors in Terraform (see /docs) so quota
   changes are peer-reviewed and promoted Dev → QA → Prod, never hand-edited. */
