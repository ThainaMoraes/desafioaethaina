with source_data as (
  select 
    addresstypeid as address_type_id
    , name as address_type_name 
  from  {{source('source_dw','addresstype')}}
)

select *
from source_data