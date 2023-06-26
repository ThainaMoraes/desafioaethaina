{{
    config(materialized='table')
}}

with customer as (
	select * 
	from `dev_thaina_intermediate.int_sales_customer`	
)

, sales as (
	select * 
	from `dev_thaina_intermediate.int_sales`	
)

, union_header_reason as (
	select 
		sales.*
		, person_id
		, store_id
		, customer.territory_id as c_territory_id
		, business_entity_id
		, person_type
		, name_style
		, courtesy_title
		, first_name
		, middle_name
		, last_name
		, suffix
		, email_promotion
		, name_territory_description
		, country_region_code
		, group_geo
		, sales_territory_year
		, bussiness_cost_in_territory
		, country_region_name
	from customer
	left join sales
	on sales.customer_id = customer.customer_id
)

select * from union_header_reason
