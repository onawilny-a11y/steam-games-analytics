

with transactions as (
    select * from {{ ref('stg_transactions') }}
    {% if is_incremental() %}
    where sale_date >= (select max(sale_date) from {{ this}})
    {% endif %}
),

games as (
    select * from {{ ref('stg_games') }}
)

select
    -- Keys
    t.transaction_id,
    t.game_id,
    t.customer_id,
    t.sale_date,

    -- Degenerate dims
    t.region_code,
    t.payment_method,

    -- Measures
    t.unit_price_usd,
    t.discount_percentage,
    round(t.unit_price_usd * (1 - t.discount_percentage / 100.0), 2) as net_revenue_usd

from transactions t
left join games g on t.game_id = g.game_id
