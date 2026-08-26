-- ============================================================================
-- staging model · normalizes raw ACCOUNT_USAGE metering into a clean grain
-- materialized as a view; incremental fct model builds on top of it
-- ============================================================================
{{ config(materialized='view', schema='cost') }}

with source as (

    select
        warehouse_id,
        warehouse_name,
        start_time,
        end_time,
        credits_used,
        credits_used_compute,
        credits_used_cloud_services
    from {{ source('account_usage', 'warehouse_metering_history') }}
    where start_time >= dateadd('day', -{{ var('cost_lookback_days', 90) }}, current_timestamp())

)

select
    warehouse_id,
    warehouse_name,
    start_time,
    end_time,
    date_trunc('day', start_time)                        as usage_date,
    credits_used,
    credits_used_compute,
    credits_used_cloud_services,
    -- contract rate lets us report in currency, not just credits
    round(credits_used * {{ var('credit_rate_usd', 3.00) }}, 2) as est_cost_usd
from source
