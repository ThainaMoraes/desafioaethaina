/*
{{
    config(materialized='table')
}}

with sales_person as (
	select * 
    from `dev_thaina_silver.stg_sales_person`
)

, currency as (
	select * 
    from `dev_thaina_silver.stg_currency`
)

, country_region_currency as (
	select * 
    from `dev_thaina_silver.stg_country_region_currency`
)

, sales_territory as (
	select * 
    from `dev_thaina_silver.stg_sales_territory`
)

, store as (
	select * 
    from `dev_thaina_silver.stg_store`
)

, union_all as (
	select 
		sales_person.*
		, sales_person_id
		, country_region_currency.*
		, currency_name
		, name_store
		, name_territory_description
		, group_geo
		, sales_territory_year
		, sales_territory.sales_last_year as territory_sales_last_year
		, bussiness_cost_in_territory
		, bussiness_cost_in_territory_last_year
	from sales_person
	left join sales_territory
	on sales_territory.territory_id = sales_person.territory_id
	-- left join sales_territory_history
	-- on sales_territory_history.territory_id = sales_territory.territory_id
	left join store
	on store.business_entity_id = sales_person.business_entity_id
	left join country_region_currency
	on country_region_currency.country_region_code = sales_territory.country_region_code
	left join currency
	on currency.currency_code = country_region_currency.currency_code
	
 )
 
select * 
from union_all
*/