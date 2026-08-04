with games as (
    select * from {{ ref('stg_games') }}
),

platforms as (
    select distinct
        platform_name,
        platform_type,
        platform_maker,
        platform_generation
    from games
    where platform_name is not null
)

select * from platforms
