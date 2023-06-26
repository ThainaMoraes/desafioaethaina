with only_products as (
    select *
    from `dev_thaina_intermediate.int_sales`
)

, sales_person as (
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

-- , sales_tax_rate as (
-- 	select * 
--     from `dev_thaina_silver.stg_sales_tax_rate`
-- )

, sales_territory as (
	select * 
    from `dev_thaina_silver.stg_sales_territory`
)

, sales_territory_history as (
	select * 
    from `dev_thaina_silver.stg_sales_territory_history`
)

, store as (
	select * 
    from `dev_thaina_silver.stg_store`
)


, union_all as (
	select 
		sales_person.*
		, business_entity_id
		, sales_quota 
		, bonus
		, commission_pct
		, sales_total
		, sales_last_year
	from sales_person
	left join sales_territory
	on sales_territory.business_entity_id = sales_person.business_entity_id
	left join sales_territory_history
	on sales_territory_history.territory_id = sales_territory.territory_id
	left join store
	on store.business_entity_id = person.business_entity_id
	left join country_region_currency
	on country_region_currency.country_region_code = sales_territory.country_region_code
	left join currency
	on currency.currency_code = country_region_currency.currency_code
	left join sales_territory
	on sales_territory.country_region_code = country_region_currency.country_region_code
 )
 
select * 
from union_all
