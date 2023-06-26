{{
    config(materialized='table')
}}

with customer as (
	select * 
    from `dev_thaina_silver.int_sales_customer`
)

, sales_territory as (
	select * 
    from `dev_thaina_silver.stg_sales_territory`
)

, person_person as (
	select * 
    from `dev_thaina_silver.stg_person_person`
)

, person_country as (
	select * 
    from `dev_thaina_silver.stg_person_country_region`
)

, state_province as (
	select * 
    from `dev_thaina_silver.stg_person_state_province`
)

, union_customer_person as (
	select
		customer.*
		, person_person.*
	from person_person
	left join customer
	on customer.customer_id = person_person.business_entity_id 
)


select * 
from union_customer_country

