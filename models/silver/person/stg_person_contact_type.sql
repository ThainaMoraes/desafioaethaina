with source_data as (
  select 
    contacttypeid as contact_type_id
    , name as contact_type_name 
  from  {{source('source_dw','contacttype')}}
)

select *
from source_data