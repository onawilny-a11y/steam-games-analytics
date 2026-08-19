with distinct_dates as (
select DISTINCT sales_date from {{ ref('daily_sales') }}
)
select sales_date from distinct_dates
   where not REGEXP_CONTAINS(sales_date, r'^\d{4}-\d{2}-\d{2}$')