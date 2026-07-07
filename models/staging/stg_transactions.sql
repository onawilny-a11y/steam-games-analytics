with source_transactions as (
    select * from {{ source('raw_steam', 'transactions') }}
)

select
    -- Identifiers
    cast(transaction_id as int64) as transaction_id,
    cast(game_id as string) as game_id,              
    cast(customer_id as string) as customer_id,
    
    -- Transaction Details & Metrics
    cast(sale_date as date) as sale_date,
    cast(unit_price_usd as float64) as unit_price_usd,
    cast(discount_pct as int64) as discount_percentage,
    cast(payment_method as string) as payment_method,
    
    -- Dimensional Slice Attributes
    cast(region as string) as region_code,
    cast(platform as string) as platform_name,
    cast(genre as string) as genre,
    cast(publisher as string) as publisher_name,
    cast(esrb_rating as string) as esrb_rating,
    
    -- Audit Metadata
    cast(ingested_at as timestamp) as ingested_at

from source_transactions