with only_products as (
    select *
    from `dev_thaina_intermediate.int_product`
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

, sales_reason as (
	select * 
    from `dev_thaina_silver.stg_sales_reason`
)

, sales_territory as (
	select * 
    from `dev_thaina_silver.stg_sales_territory`
)



, union_all as (
	select 
		only_products.*
		, order_header.*
		, sales_reason.name_reason
		, sales_reason.reason_type
		, order_detail.sales_order_detail_id
		, person_id
		, store_id
		, carrier_tracking_number
		, order_qty
		, special_offer_id
		, unit_price
		, unit_price_discount
		, currency_rate_date
		, from_currency_code
		, to_currency_code
		, avg_rate
		, end_of_day_rate
		
	from order_header
	left join order_reason
	on order_header.sales_order_id = order_reason.sales_order_id
	left join order_detail
	on order_header.sales_order_id = order_detail.sales_order_id
	left join only_products
	on only_products.product_id = order_detail.product_id
	left join sales_reason
	on sales_reason.sales_reason_id = order_reason.sales_reason_id
	left join customer
	on customer.customer_id = order_header.customer_id
	left join currency_rate
	on currency_rate.currency_rate_id = order_header.currency_rate_id
	
 )

select * 
from union_all
