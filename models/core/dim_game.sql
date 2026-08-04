with games as (
    select * from {{ ref('stg_games') }}
)

select
    game_id,
    game_title,
    genre,
    developer_name,
    release_year,
    esrb_rating,
    launch_price_usd,
    metacritic_score,
    user_score,
    critic_review_count,
    user_review_count,
    hltb_main_hours,
    hltb_completionist_hours,
    cast(is_sequel as bool)               as is_sequel,
    cast(has_online_multiplayer as bool)  as has_online_multiplayer,
    cast(has_dlc_released as bool)        as has_dlc_released,
    cast(has_microtransactions as bool)   as has_microtransactions,
    cast(has_loot_boxes as bool)          as has_loot_boxes,
    cast(is_game_pass_available as bool)  as is_game_pass_available,
    cast(has_vr_support as bool)          as has_vr_support,
    cast(is_goty_nominated as bool)       as is_goty_nominated,
    cast(is_goty_won as bool)             as is_goty_won

from games
