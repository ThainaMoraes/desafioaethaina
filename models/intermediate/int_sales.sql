{{ 
  config( 
	 materialized='table'
  )
}}

with order_header as (
	select * 
	from {{ ref('stg_sales_order_header') }}	
)

, order_header_reason as (
	select * 
	from {{ ref('stg_sales_order_header_reason') }}	
)

, order_detail as (
	select * 
	from {{ ref('stg_sales_order_detail') }}	
)

, credit_card as (
	select * 
	from {{ ref('stg_sales_creditcard') }}	
)

, ship_method as (
	select * 
	from {{ ref('stg_purchasing_ship_method') }}
)

, union_header_reason as (
	select 
		order_header.*
		, card_type
	from order_header 
	left join credit_card
		on credit_card.credit_card_id = order_header.credit_card_id
)

, union_header_detail as (
	select 
		union_header_reason.*
		, shipping_company_name
		, sales_order_detail_id
		, carrier_tracking_number
		, product_id
		, order_qty
		, unit_price
		, unit_price_discount
	from order_detail 
	left join union_header_reason
		on union_header_reason.sales_order_id =  order_detail.sales_order_id
	left join ship_method
		on ship_method.ship_method_id = union_header_reason.ship_method_id
)

select * 
from union_header_detail
