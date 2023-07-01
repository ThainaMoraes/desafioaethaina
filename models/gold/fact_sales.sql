with int_sales as (
    select * 
    from {{ ref('int_sales') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by sales_order_id, sales_order_detail_id order by sales_order_id) as dedup_index
    from int_sales
)

, sales_with_sk  as (
    select
        row_number() over (order by sales_order_id, sales_order_detail_id) as sale_identifier_sk
        , sales_order_id 
        , sales_order_detail_id
        , order_date
        , MD5(cast(customer_id as string)) as customer_fk
        , MD5(cast(sales_person_id as string)) as sales_person_fk
        , MD5(cast(bill_to_address_id as string)) as bill_to_address_fk
        , MD5(cast(ship_to_address_id as string)) as ship_to_address_fk
        , MD5(cast(ship_method_id as string)) as ship_method_fk
        , MD5(cast(product_id as string)) as product_fk
        , sub_total
        , tax_amount
        , freight
        , total_due
        , order_qty
        , unit_price
        , unit_price_discount
    from deduplication_data
    where dedup_index = 1
)

select *
from sales_with_sk