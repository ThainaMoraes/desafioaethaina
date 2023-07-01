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

, sales_reason as (
	select * 
	from {{ ref('stg_sales_reason') }}	
)

, credit_card as (
	select * 
	from {{ ref('stg_sales_creditcard') }}	
)

, union_reason as ( 
	select
		sales_order_id
		, sales_reason.*
		from order_header_reason
		left join sales_reason
			on sales_reason.sales_reason_id = order_header_reason.sales_reason_id
)

, union_header_reason as (
	select 
		order_header.*
		, sales_reason_id
		, name_reason
		, reason_type
		, card_type
	from order_header 
	left join union_reason
		on union_reason.sales_order_id =  order_header.sales_order_id
	left join credit_card
		on credit_card.credit_card_id = order_header.credit_card_id
)

, union_header_detail as (
	select 
		union_header_reason.*
		, sales_order_detail_id
		, carrier_tracking_number
		, product_id
		, order_qty
		, unit_price
		, unit_price_discount
	from order_detail 
	left join union_header_reason
		on union_header_reason.sales_order_id =  order_detail.sales_order_id
)

select * 
from union_header_detail
