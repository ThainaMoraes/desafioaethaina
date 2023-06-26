with source_data as (
  select 
    stateprovinceid as state_province_id
    , stateprovincecode as state_province_code
    , countryregioncode as country_region_code
    , name as name_province_description
    , isonlystateprovinceflag as only_state_province_flag
    , name as state_province_name
    , territoryid as territory_id
    , rowguid as rowguide_province
  from  {{source('source_dw','stateprovince')}}
)

select *
from source_data