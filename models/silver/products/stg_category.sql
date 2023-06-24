with source_data as (
  select 
    productcategoryid as category_id
    , name as category_name
  from  {{source('source_dw','productcategory')}}
)

select *
from source_data