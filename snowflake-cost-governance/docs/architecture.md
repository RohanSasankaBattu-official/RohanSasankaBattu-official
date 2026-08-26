# Architecture

A layered, least-privilege approach to Snowflake cost governance.

```
                    ┌─────────────────────────────────────────┐
                    │        SNOWFLAKE.ACCOUNT_USAGE            │
                    │  metering · query · load · storage        │
                    └───────────────────┬───────────────────────┘
                                        │  (read-only, IMPORTED PRIVILEGES)
                    ┌───────────────────▼───────────────────────┐
                    │   GOVERNANCE.COST  (curated views)         │
                    │  • V_CREDITS_BY_USER   attribution         │
                    │  • V_WH_UTILIZATION    right-sizing        │
                    │  • V_IDLE_WAREHOUSES   waste detection     │
                    │  • V_SPEND_ANOMALIES   z-score alerting    │
                    └───────────┬───────────────────┬────────────┘
                                │                   │
              ┌─────────────────▼──┐        ┌───────▼─────────────┐
              │  dbt fct_cost_by_pod│        │  cost_report.py     │
              │  (incremental)      │        │  weekly digest      │
              └─────────────────────┘        └─────────────────────┘
                                │
                    ┌───────────▼───────────┐
                    │  RESOURCE MONITORS     │  ← hard guardrails
                    │  notify → suspend      │
                    └────────────────────────┘
```

## Design principles

1. **Least privilege.** A dedicated `COST_GOVERNANCE_RO` role reads only what it
   needs. No dashboards run as `ACCOUNTADMIN`.
2. **Report *and* prevent.** Views expose spend; resource monitors cap it. You
   need both — reporting alone never stops a runaway job.
3. **Attribution is the lever.** Once spend is visible per user and per POD,
   accountability follows. This is what drove **20–35% cost reductions** in
   production across 9 delivery PODs.
4. **Everything as code.** Views, dbt models, and monitors are version-controlled
   and promoted Dev → QA → Prod via CI/CD — never hand-edited in the UI.

## ACCOUNT_USAGE latency

| View | Typical latency |
|---|---|
| `WAREHOUSE_METERING_HISTORY` | up to ~45 min |
| `QUERY_HISTORY` | up to ~45 min |
| `WAREHOUSE_LOAD_HISTORY` | ~3 h |

Design daily digests around **T-1** completeness.
