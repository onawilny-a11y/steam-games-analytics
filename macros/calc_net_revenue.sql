{%- macro calc_net_revenue(unit_price_usd, discount_percentage=0) -%}
    round({{ unit_price_usd }} * (1 - {{ discount_percentage }} / 100.0), 2)
{%- endmacro -%}