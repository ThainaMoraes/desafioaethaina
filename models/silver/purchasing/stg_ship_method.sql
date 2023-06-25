with source_data as (
  select 
    shipmethodid as ship_method_id
    , name as shipping_company_name
    , shipbase as ship_base
    , shiprate as ship_rate
  from  {{source('source_dw','shipmethod')}}
)

select *
from source_data
