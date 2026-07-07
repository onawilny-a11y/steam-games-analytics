with source_games as (
    select * from {{ source('raw_steam', 'games') }}
)

select
    -- Identifiers
    cast(title as string) as game_title,
    cast(game_id as string) as game_id,

    
    -- Categorization & Core Attributes
    cast(genre as string) as genre,
    cast(year as int64) as release_year,
    cast(esrb_rating as string) as esrb_rating,
    
    -- Platform Details
    cast(platform as string) as platform_name,
    cast(platform_type as string) as platform_type,
    cast(platform_maker as string) as platform_maker,
    cast(platform_generation as int64) as platform_generation,
    
    -- Entities / Company Information
    cast(publisher as string) as publisher_name,
    cast(developer as string) as developer_name,
    cast(publisher_region as string) as publisher_region,
    cast(publisher_tier as string) as publisher_tier,
    
    -- Review Scores
    cast(metacritic_score as int64) as metacritic_score,
    cast(user_score as float64) as user_score,
    cast(critic_review_count as int64) as critic_review_count,
    cast(user_review_count as int64) as user_review_count,
    
    -- Gameplay Metrics (How Long To Beat)
    cast(how_long_to_beat_main_hrs as float64) as hltb_main_hours,
    cast(how_long_to_beat_completionist_hrs as float64) as hltb_completionist_hours,
    
    -- Financials
    cast(launch_price_usd as float64) as launch_price_usd,
    
    -- Analytical Feature Flags (1 = Yes, 0 = No)
    cast(is_sequel as int64) as is_sequel,
    cast(online_multiplayer as int64) as has_online_multiplayer,
    cast(dlc_released as int64) as has_dlc_released,
    cast(microtransactions as int64) as has_microtransactions,
    cast(loot_boxes as int64) as has_loot_boxes,
    cast(game_pass_available as int64) as is_game_pass_available,
    cast(vr_support as int64) as has_vr_support,
    cast(goty_nominated as int64) as is_goty_nominated,
    cast(goty_won as int64) as is_goty_won,
    
    -- Audit Metadata
    cast(ingested_at as timestamp) as ingested_at

from source_games