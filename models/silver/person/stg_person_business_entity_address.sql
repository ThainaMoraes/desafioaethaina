with source_data as (
  select 
    businessentityid as business_entity_id
    , addressid as address_id
    , addresstypeid as address_type_id
    , rowguid
  from  {{source('source_dw','businessentityaddress')}}
)

select *
from source_data