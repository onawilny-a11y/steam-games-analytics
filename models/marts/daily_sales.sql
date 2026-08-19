with fct_game_sales as (
    select * from {{ ref('fct_game_sales') }}
    {% if is_incremental() %}
    where sale_date >= (select date_sub(max(sale_date), interval 3 day) from {{ this}})
    {% endif %}
),
dim_publisher as (
    select * from {{ ref('dim_publisher') }}
),
dim_game as (
    select * from {{ ref('dim_game') }}
),
joined_data as (
    select
        fgs.transaction_key,
        fgs.transaction_id,
        fgs.game_id,
        fgs.customer_id,
        fgs.sale_date,
        fgs.region_code,
        fgs.payment_method,
        fgs.unit_price_usd,
        fgs.discount_percentage,
        fgs.net_revenue_usd,
        fgs.net_revenue_eur,
        dp.publisher_name,
        dg.game_title
    from fct_game_sales fgs
    left join dim_publisher dp on fgs.game_id = dp.game_id
    left join dim_game dg on fgs.game_id = dg.game_id
),
grouped_data as (
    select
        sale_date,
        publisher_name,
        game_title,
        sum(net_revenue_usd) as total_net_revenue_usd,
        sum(net_revenue_eur) as total_net_revenue_eur,
        count(distinct transaction_id) as total_transactions
    from joined_data
    group by sale_date, publisher_name, game_title
),
add_unique_key as (
    select
        {{ generate_surrogate_key_sha256(['sale_date', 'publisher_name', 'game_title']) }} as daily_sales_key,
       *
    from grouped_data
)
select * from add_unique_key
