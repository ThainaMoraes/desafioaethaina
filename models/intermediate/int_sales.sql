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

, reason as (
	select 
		DISTINCT  
		sales_order_id
		, reason_type 
	from {{ ref('int_reason') }}
)

, union_credit_card as (
	select 
		order_header.*
		, card_type
	from order_header 
	left join credit_card
		on credit_card.credit_card_id = order_header.credit_card_id
)


, union_header_detail as (
	select 
		union_credit_card.*
		, shipping_company_name
		, sales_order_detail_id
		, carrier_tracking_number
		, product_id
		, order_qty
		, unit_price
		, case 
			when unit_price_discount != 0
				then unit_price_discount
			else null
		end as unit_price_discount
		, ((1 - COALESCE(unit_price_discount,0)) * unit_price * order_qty) as sub_total_fixed
	from order_detail 
	left join union_credit_card
		on union_credit_card.sales_order_id =  order_detail.sales_order_id
	left join ship_method
		on ship_method.ship_method_id = union_credit_card.ship_method_id
)

, count_orders as (
	select 
		sales_order_id
		, count(sales_order_id) as count_orders_rows
		from union_header_detail
		group by sales_order_id
)

,  join_fixing_columns as (
	select
		union_header_detail.*
		, count_orders_rows
 		, freight / count_orders_rows as freight_fixed
		, tax_amount / count_orders_rows as tax_fixed
		from union_header_detail
		left join count_orders
			on count_orders.sales_order_id  = union_header_detail.sales_order_id
)

, fixed_table as (
	select 
		sales_order_id
		, sales_order_detail_id
		, customer_id
		, order_date
		, due_date
		, ship_date
		, case 
			when purchase_order_number is not null
				then "No"
			else "Yes"
		end as online_order
		, sales_person_id
		, territory_id
		, bill_to_address_id
		, ship_to_address_id
		, ship_method_id
		, credit_card_id
		, case 
			when credit_card_approval_code is not null
				then "No"
			else "Yes"
		end as paid_with_credit_card
		, card_type
		, status
		, carrier_tracking_number
		, product_id
		, order_qty
		, unit_price
		, unit_price_discount
		, sub_total_fixed
		, freight_fixed
		, tax_fixed
		, sub_total_fixed + freight_fixed + tax_fixed as total_due_fixed
	from join_fixing_columns
)

, union_reason as (
	select
		fixed_table.*
		, reason_type
		from fixed_table
		left join reason
			on reason.sales_order_id = fixed_table.sales_order_id
)

select * 
from union_reason

