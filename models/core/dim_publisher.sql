with games as (
    select * from {{ ref('stg_games') }}
),

publishers as (
    select distinct
        publisher_name,
        publisher_region,
        publisher_tier
    from games
    where publisher_name is not null
)

select * from publishers
