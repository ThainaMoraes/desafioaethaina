with address as (
	select * 
    from {{ ref('stg_person_address') }}
)

, address_type as (
	select * 
    from {{ ref('stg_person_address_type') }}
)

, business_entity_address as (
	select * 
    from {{ ref('stg_person_business_entity_address') }}
)

, business_entity_contact as (
	select * 
    from {{ ref('stg_person_business_entity_contact') }}
)

, contact_type_worker as (
	select  * 
    from  {{ ref('stg_person_contact_type') }} 
)

, union_person_addres as (
    select
        business_entity_address.address_id
        , business_entity_id
        , business_entity_address.address_type_id
        , concat(address_line1, ' ', ifnull('',address_line2), ' ', postal_code) as address
        , city
        , state_province_id
        , address_type_name
    from business_entity_address
    left join address
    on address.address_id = business_entity_address.address_id
   	left join address_type
   	on address_type.address_type_id = business_entity_address.address_type_id
)

, union_contact_type as (
	select 
		union_person_addres.*
		, person_id as worker_id
		, contact_type_worker.contact_type_id 
		, contact_type_name as contact_type_name_worker
	from union_person_addres
	left join business_entity_contact
	on business_entity_contact.business_entity_id = union_person_addres.business_entity_id 
	left join contact_type_worker
	on contact_type_worker.contact_type_id = business_entity_contact.contact_type_id
)

select * 
from union_contact_type