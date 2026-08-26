-- ============================================================================
-- fact model · daily credit + USD spend rolled up to delivery POD
-- POD is derived from a warehouse-naming convention (WH_<POD>_<ENV>);
-- swap in a seed/mapping table if your naming differs.
-- incremental so it only processes new days on each run.
-- ============================================================================
{{ config(
    materialized='incremental',
    unique_key=['usage_date', 'pod'],
    schema='cost'
) }}

with metering as (
    select * from {{ ref('stg_warehouse_metering') }}
    {% if is_incremental() %}
      where usage_date > (select coalesce(max(usage_date), '1900-01-01') from {{ this }})
    {% endif %}
)

select
    usage_date,
    -- WH_FINANCE_PROD -> FINANCE ; adjust regex to your standard
    coalesce(split_part(warehouse_name, '_', 2), 'UNMAPPED') as pod,
    count(distinct warehouse_name)          as warehouse_count,
    round(sum(credits_used), 2)             as credits_used,
    round(sum(est_cost_usd), 2)             as est_cost_usd
from metering
group by 1, 2
