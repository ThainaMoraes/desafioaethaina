with source_data as (
  select 
    businessentityid as business_entity_id
    , name as name_store
    , salespersonid as sales_person_id
  from  {{source('source_dw','store')}}
)

select *
from source_data