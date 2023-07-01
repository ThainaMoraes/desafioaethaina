with order_header_reason as (
	select * 
	from {{ ref('stg_sales_order_header_reason') }}	
)

, sales_reason as (
	select * 
	from {{ ref('stg_sales_reason') }}	
)

, union_reason as ( 
	select
		sales_order_id
		, sales_reason.*
		from order_header_reason
		left join sales_reason
			on sales_reason.sales_reason_id = order_header_reason.sales_reason_id
)

select *
from union_reason