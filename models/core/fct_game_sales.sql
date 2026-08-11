

with transactions as (
    select * from {{ ref('stg_transactions') }}
    {% if is_incremental() %}
    where sale_date >= (select max(sale_date) from {{ this}})
    {% endif %}
),

eu_conv_rate as (
    select * from {{ ref('Conversion_rate') }} WHERE currency = 'EU'
),

games as (
    select * from {{ ref('stg_games') }}
)

select
    -- Keys
    {{ dbt_utils.generate_surrogate_key(['t.transaction_id']) }} as transaction_key,
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
    {{ calc_net_revenue('t.unit_price_usd', 't.discount_percentage') }} as net_revenue_usd,
    {{ calc_net_revenue('t.unit_price_usd', 't.discount_percentage') }}*ecr.conversion_rate as net_revenue_eur


from transactions t
left join games g on t.game_id = g.game_id

JOIN eu_conv_rate ecr on true