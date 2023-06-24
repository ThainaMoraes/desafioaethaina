with source_data as (
  select 
    productdescriptionid as product_description_id
    , description as product_description
  from  {{source('source_dw','productdescription')}}
)

select *
from source_data