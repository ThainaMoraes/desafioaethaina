with int_sales as (
    select * 
    from {{ ref('int_sales') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by sales_order_detail_id order by sales_order_id) as dedup_index
    from int_sales
)

, sales_with_sk  as (
    select
        row_number() over (order by sales_order_id, sales_order_detail_id) as sale_identifier_sk
        , MD5(cast(sales_order_detail_id as string)) as sales_order_detail_sk 
        , MD5(cast(sales_order_id as string)) as sales_order_sk
        , MD5(cast(product_id as string)) as product_fk
        , order_qty
        , unit_price
        , unit_price_discount
    from deduplication_data
    where dedup_index = 1
)

select *
from sales_with_sk