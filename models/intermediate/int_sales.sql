with only_products as (
    select *
    from `dev_thaina_intermediate.int_product`
)

, currency as (
    select * 
    from `dev_thaina_silver.stg_currency`
)

, currency_rate as (
	select * 
    from `dev_thaina_silver.stg_currency_rate`
)

, customer as (
	select * 
    from `dev_thaina_silver.stg_customer`
)

, order_detail as (
	select * 
    from `dev_thaina_silver.stg_sales_order_detail`
)

, order_header as (
	select * 
    from `dev_thaina_silver.stg_sales_order_header`
)

, order_reason as (
	select * 
    from `dev_thaina_silver.stg_sales_order_header_reason`
)

, union_all as (
	select 
	product_id
	, order_header.sales_order_id
	, sales_order_detail_id
	, carrier_tracking_number
	, order_qty
	, product_id
	, special_offer_id
	, unit_price
	, unit_price_discount
	, sales_reason_id
	--, customer_id
	--, person_id
	--, store_id
	--, territory_id
	, carrier_tracking_number
	, order_qty
	, special_offer_id
	, unit_price
	, unit_price_discount
	--, currency_code
	--, currency_name
	--, currency_rate_id
	--, currency_rate_date
	--, from_currency_code
	--, to_currency_code
	--, avg_rate
	--, end_of_day_rate
	from order_header
	left join order_reason
	on order_header.sales_order_id = order_reason.sales_order_id
	left join order_detail
	on order_header.sales_order_id = order_detail.sales_order_id
)

select * 
from union_all
