<div align="center">

# ❄️ Snowflake Cost-Governance Toolkit

**Attribute, right-size, and cap Snowflake spend — the framework behind 20–35% cloud-cost reductions across 9 delivery PODs.**

![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-39ff14?style=for-the-badge)

</div>

---

## Why this exists

A Snowflake bill tells you *how much* you spent, never *who* or *why*. This
toolkit closes that gap: it attributes credits down to the **user** and
**delivery POD**, flags oversized and idle warehouses, alerts on spend
anomalies, and puts **hard guardrails** in place so no single team can blow the
budget. Reporting shows the waste; resource monitors stop it.

> Built from patterns proven in production on enterprise Snowflake platforms
> (100s of TB, 9 PODs) — see the [architecture notes](docs/architecture.md).

## What's inside

| Layer | File | What it does |
|---|---|---|
| 🏗️ Foundation | [`sql/01_setup_monitoring_schema.sql`](sql/01_setup_monitoring_schema.sql) | Least-privilege `COST_GOVERNANCE_RO` role + curated schema + XS reporting WH |
| 👤 Attribution | [`sql/02_warehouse_cost_by_user.sql`](sql/02_warehouse_cost_by_user.sql) | Allocates warehouse credits to individual **users** |
| 📏 Right-sizing | [`sql/03_warehouse_utilization.sql`](sql/03_warehouse_utilization.sql) | Flags **oversized / undersized** warehouses |
| 💸 Waste + alerts | [`sql/04_idle_and_anomaly_detection.sql`](sql/04_idle_and_anomaly_detection.sql) | Idle-but-billing WHs + **z-score** spend anomalies |
| 🚧 Guardrails | [`sql/05_resource_monitors_guardrails.sql`](sql/05_resource_monitors_guardrails.sql) | Resource monitors: notify → suspend |
| 🔁 Modeled | [`dbt/models/cost_monitoring/`](dbt/models/cost_monitoring/) | dbt staging + **incremental** `fct_cost_by_pod` |
| 📧 Digest | [`python/cost_report.py`](python/cost_report.py) | Weekly plain-text cost digest for email/Slack |

## Quick start

```sql
-- 1. Lay the foundation (run as ACCOUNTADMIN)
!source sql/01_setup_monitoring_schema.sql

-- 2. Build the curated cost views
!source sql/02_warehouse_cost_by_user.sql
!source sql/03_warehouse_utilization.sql
!source sql/04_idle_and_anomaly_detection.sql

-- 3. Put guardrails in place (tune the quotas first!)
!source sql/05_resource_monitors_guardrails.sql
```

```bash
# 4. Weekly digest (key-pair / SSO auth — no secrets in code)
export SNOWFLAKE_ACCOUNT=... SNOWFLAKE_USER=...
python python/cost_report.py
```

## Sample output

```
### Right-sizing recommendations
   WAREHOUSE_NAME     | CREDITS_30D | RECOMMENDATION
   WH_ANALYTICS_PROD  | 812.4       | 💸 OVERSIZED — mostly idle, downsize / consolidate
   WH_INGEST_PROD     | 640.1       | ⚠️ UNDERSIZED — persistent queueing
```

## Roadmap

- [ ] Streamlit dashboard on the curated views
- [ ] Terraform module for resource monitors (peer-reviewed quota changes)
- [ ] Snowflake Cortex summary of the weekly digest in natural language

## License

MIT © Rohan Sasanka Battu — see [LICENSE](LICENSE).

<div align="center">
<sub>Part of my data & cloud architecture work · <a href="https://linkedin.com/in/rohan-sasanka-542704215">LinkedIn</a></sub>
</div>
