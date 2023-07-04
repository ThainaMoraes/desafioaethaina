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
		order by reason_type DESC
)

, aggregate_columns as (
	select
		sales_order_id
		, string_agg(reason_type, ', ') agg_reason_type
		, string_agg(name_reason , ', ') as agg_name_reason
	from union_reason
	group by sales_order_id
)

, replace_aggregate as (
	select 
		sales_order_id
		, replace(replace(agg_reason_type,'Other, Other', 'Other'), 'Promotion, Other', 'Other, Promotion') as reason_type
		, replace(agg_name_reason,'Other, Other', 'Other') as name_reason
	from aggregate_columns
	union all
	select
		null as sales_order_id
		, null as reason_type
		, null as name_reason
)
select *
from replace_aggregate
