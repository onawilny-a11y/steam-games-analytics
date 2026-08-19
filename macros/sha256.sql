{% macro generate_surrogate_key_sha256(field_list) %}

    {# Define a default string to replace NULLs, preventing concatenation errors #}
    {%- set default_null_value = '_dbt_utils_surrogate_key_null_' -%}
    
    {# Initialize an empty list to hold our formatted column strings #}
    {%- set fields = [] -%}

    {# Loop through every column provided in the field_list #}
    {%- for field in field_list -%}
        
        {# Cast the column to a string and handle NULLs #}
        {%- set _ = fields.append(
            "coalesce(cast(" ~ field ~ " as " ~ dbt.type_string() ~ "), '" ~ default_null_value ~ "')"
        ) -%}
        
        {# Add a hyphen separator between columns, but not after the last column #}
        {%- if not loop.last %}
            {%- set _ = fields.append("'-'") -%}
        {%- endif -%}

    {%- endfor -%}

    {# Concatenate all the pieces together #}
    {%- set concat_string = dbt.concat(fields) -%}

    {# BigQuery specific: sha256 returns BYTES, so we use to_hex to make it a STRING #}
    to_hex(sha256({{ concat_string }}))

{% endmacro %}