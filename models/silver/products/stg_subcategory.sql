with source_data as (
  select 
    productsubcategoryid as subcategory_id
    , productcategoryid as category_id
    , name as subcategory_name
  from  {{source('source_dw','productsubcategory')}}
)

select *
from source_data