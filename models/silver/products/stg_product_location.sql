with source_data as (
  select 
    locationid as location_id
    , name as location_name
    -- Standard hourly cost of the manufacturing location.
    , costrate as cost_rate
    -- Work capacity (in hours) of the manufacturing location.
    , availability 
  from  {{source('source_dw','location')}}
)

select *
from source_data