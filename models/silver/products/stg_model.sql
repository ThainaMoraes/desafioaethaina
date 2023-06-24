with source_data as (
  select 
    productmodelid as model_id
    , name as model_name
  from  {{source('source_dw','productmodel')}}
)

select *
from source_data