{{
    config(materialized='table')
}}

with customer as (
	select * 
    from `dev_thaina_silver.stg_sales_customer`
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

, union_customer_territory as (
	select
		union_customer_person.*
		, name_territory_description
        , country_region_code
        , group_geo
        , sales_territory_year
        , bussiness_cost_in_territory
		from sales_territory
		left join union_customer_person
		on union_customer_person.territory_id =  sales_territory.territory_id
)

, union_customer_country as (
 select 
 	union_customer_territory.*
 	, country_region_name
 	from union_customer_territory
 	left join person_country
	on union_customer_territory.country_region_code = person_country.country_region_code
)

, union_customer_state_province as (
	select	
		union_customer_country.*
		, state_province_id
		, state_province_code
		, name_province_description
		, only_state_province_flag
		, state_province_name
		from state_province
		left join union_customer_country
		on state_province.country_region_code =  union_customer_country.country_region_code 
)

select * 
from union_customer_country

