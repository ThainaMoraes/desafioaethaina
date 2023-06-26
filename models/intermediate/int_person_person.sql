/*
{{
    config(materialized='table')
}}

with person_person as (
	select * 
    from `dev_thaina_silver.stg_person`
)

, sales_tax_rate as (
	select * 
    from `dev_thaina_silver.stg_sales_tax_rate`
)

, business_entity_address as (
	select * 
    from `dev_thaina_silver.stg_business_entity_address`
)

, business_entity_contact as (
	select * 
    from `dev_thaina_silver.stg_business_entity_contact`
)

, contact_type as (
	select * 
    from `dev_thaina_silver.stg_contact_type`
)


, union_all as (
	select 
		person_person.*
		from person_person
		left join business_entity_contact
		on business_entity_contact.business_entity_id = person_person.business_entity_id
		left join business_entity_address
		on business_entity_address.business_entity_id = person_person.business_entity_id
		left join contact_type
		on contact_type.contact_type = business_entity_contact.contact_type
		-- left join person_state_province
		-- on person_state_province.
		-- left join 'address'
		-- on 'address'.
 )
 
select * 
from union_all
*/