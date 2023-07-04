{{
    config(
        severety = 'error'
    )
}}

with sales as (
    select 
        sum(sub_total_fixed) as total_sales
    from {{ ref('fact_sales') }} 
    where order_date between '2011-01-01' and '2011-12-31'
)

select 
    total_sales
from sales
where total_sales not between 12646000.00 and 12647000.00