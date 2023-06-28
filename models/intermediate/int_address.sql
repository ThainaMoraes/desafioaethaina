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

, union_address_business_contact as (
    select
        business_entity_address.business_entity_id
        , address_id
        , address_type_id
        , contact_type_id
    from business_entity_contact
    left join  business_entity_address
    on business_entity_address.business_entity_id = business_entity_contact.business_entity_id
)


, union_address_type as (
    select
        union_address_business_contact.*
        , address_type.address_type_id
        , contact_type_id
    from address_type
    left join union_address_business_contact
    on address_type.address_type_id = union_address_business_contact.address_type_id
)

, union_address_business_address as (
    select
    	union_address_type.*
        , concat(address_line1, ' ', address_line2, ' ', postal_code) as address
        , city
        , state_province_id
        , business_entity_id
    from union_address_type
    left join address 
    on address.address_id = union_address_type.address_id
   
)

select * 
from union_address_business_address