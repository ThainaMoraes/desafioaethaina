{{
    config(materialized='table')
}}

with address as (
	select * 
    from `dev_thaina_silver.stg_person_address`
)

, address_type as (
	select * 
    from `dev_thaina_silver.stg_person_address_type`
)

, business_entity_address as (
	select * 
    from `dev_thaina_silver.stg_person_business_entity_address`
)

, business_entity_contact as (
	select * 
    from `dev_thaina_silver.stg_person_business_entity_contact`
)

, union_address_business_address as (
    select
        address.address_id
        , concat(address_line1, ' ', address_line2, ' ', postal_code) as address
        , city
        , state_province_id
        , business_entity_id
        , address_type_id
    from address 
    left join business_entity_address  
    on address.address_id = business_entity_address.address_id
   
)

, union_address_business_contact as (
    select
        union_address_business_address.*
        , address_type_name
        , contact_type_id
    from business_entity_contact
    left join  union_address_business_address
    on union_address_business_address.business_entity_id = business_entity_contact.business_entity_id
    left join address_type 
    on address_type.address_type_id = union_address_business_address.address_type_id
)

select * 
from union_address_business_contact
