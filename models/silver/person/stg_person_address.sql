with source_data as (
  select 
    addressid as address_id
    , addressline1 as address_line1
    , addressline2 as address_line2
    , city
    , stateprovinceid as state_province_id
    , postalcode as postal_code
    , rowguid
  from  {{source('source_dw','address')}}
)

select *
from source_data