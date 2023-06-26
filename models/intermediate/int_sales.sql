{{
    config(materialized='table')
}}

with order_header as (
	select * 
	from `dev_thaina_silver.stg_sales_order_header`	
)

, order_header_reason as (
	select * 
	from `dev_thaina_silver.stg_sales_order_header_reason`	
)

, order_detail as (
	select * 
	from `dev_thaina_silver.stg_sales_order_detail`	
)

, union_header_reason as (
	select 
		order_header.*
		, sales_reason_id
		, sales_order_detail_id
		, carrier_tracking_number
		, order_qty
		, product_id
		, unit_price
		, unit_price_discount
	from order_header
	left join order_header_reason
	on order_header_reason.sales_order_id = order_header.sales_order_id
	left join order_detail 
	on order_detail.sales_order_id =  order_header.sales_order_id
)

select * from union_header_reason