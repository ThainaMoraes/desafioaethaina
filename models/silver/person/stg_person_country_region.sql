with source_data as (
  select 
    countryregioncode as country_region_code
    , name as country_region_name 
  from  {{source('source_dw','countryregion')}}
)
select *
from source_data