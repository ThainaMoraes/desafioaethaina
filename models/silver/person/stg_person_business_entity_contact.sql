with source_data as (
  select 
    businessentityid as business_entity_id
    , personid as person_id
    , contacttypeid as contact_type_id
    , rowguid
  from  {{source('source_dw','businessentitycontact')}}
)

select *
from source_data