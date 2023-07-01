with customer as (
	select * 
    from {{ ref('stg_sales_customer') }}
)

, sales_territory as (
	select * 
    from {{ ref('stg_sales_territory') }}
)

, person_person as (
	select * 
    from {{ ref('stg_person_person') }}
)

, person_country as (
	select * 
    from {{ ref('stg_person_country_region') }}
)

, state_province as (
	select * 
    from {{ ref('stg_person_state_province') }}
)

, union_customer_person as (
	select
		customer.*
		, person_person.*
	from person_person
	left join customer
	on customer.customer_id = person_person.business_entity_id 
)

, transformed as (
	select
		customer_id
		, case
			when person_type = 'SC' 
				then 'Store Contact'
			when person_type = 'IN' 
				then 'Individual Customer'
			when person_type = 'SP' 
				then 'Sales person'
			when person_type = 'EM' 
				then 'Employee'  
			when person_type = 'VC' 
				then 'Vendor'
			when person_type = 'GC'
				then 'General contact'
		end as person_type
		, name_style
		, courtesy_title
		, case 
			when middle_name is not null
				then concat(first_name, ' ', middle_name, ' ',last_name)
			else concat(first_name, ' ',last_name)
		end as full_name
		, suffix
		, email_promotion
		, person_id
		, store_id
		, territory_id 
	from union_customer_person

)

, union_customer_territory as (
	select
		transformed.*
		, name_territory_description
        , country_region_code
        , sales_territory_year
		from sales_territory
		left join transformed
		on transformed.territory_id =  sales_territory.territory_id
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
		, state_province_name
		from state_province
		left join union_customer_country
		on state_province.country_region_code =  union_customer_country.country_region_code 
)

, change_columns_name as (
	select
		customer_id as fixed_person_id
		, person_id as fixed_customer_id
		, person_type
		, full_name
		, suffix
		, courtesy_title	
		, email_promotion
		, store_id
		, territory_id 
		, name_territory_description
		, country_region_code
		, sales_territory_year
		, country_region_name
		, state_province_id
		, state_province_code
		, state_province_name
	from union_customer_state_province
	where customer_id is not null

)

select * 
from change_columns_name

