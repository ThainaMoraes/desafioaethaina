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
       {{ dbt_utils.generate_surrogate_key(['sales_order_id', 'sales_order_detail_id']) }}  as sale_identifier_sk
        , {{ dbt_utils.generate_surrogate_key(['sales_order_id']) }} as sales_order_fk
        , {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_fk
        , {{ dbt_utils.generate_surrogate_key(['territory_id']) }} as territory_fk
        , {{ dbt_utils.generate_surrogate_key(['bill_to_address_id']) }} as bill_to_address_fk
        , {{ dbt_utils.generate_surrogate_key(['ship_to_address_id']) }} as ship_to_address_fk
        , {{ dbt_utils.generate_surrogate_key(['ship_method_id']) }} as ship_method_fk
        , {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_fk
        , {{ dbt_utils.generate_surrogate_key(['card_type']) }} as credit_card_fk
        , {{ dbt_utils.generate_surrogate_key(['reason_type']) }} as reason_type_fk
        , order_date
        , due_date
        , ship_date
        , online_order
        , carrier_tracking_number
        , paid_with_credit_card
        , status
        , order_qty
        , unit_price
        , unit_price_discount
        , sub_total_fixed
        , total_gross
		, freight_fixed
		, tax_fixed
        , total_due_fixed
    from deduplication_data
    where dedup_index = 1
)

select *
from sales_with_sk