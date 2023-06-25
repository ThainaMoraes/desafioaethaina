with source_data as (
  select 
    stateprovinceid as state_province_id
    , stateprovincecode as state_province_code
    , countryreguincode as country_region_code
    , name as name_province_description
    , terretoryid as territory_id
  from  {{source('source_dw','stateprovince')}}
)

select *
from source_data