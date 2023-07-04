with customer as (
	select * 
    from {{ ref('stg_sales_customer') }}
)

, person as (
	select * 
    from {{ ref('stg_person_person') }}
)

, union_customer_person as (
	select
		customer.*
		, person.*
	from person
	left join customer
	on person.business_entity_id = customer.person_id 
)

, transformed as (
	select
		business_entity_id
		, customer_id
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
			else null
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

select * 
from transformed

