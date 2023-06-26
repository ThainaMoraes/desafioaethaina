with source_data as (
  select 
    productid as product_id
    , locationid as location_id
    , shelf
    , bin
    , quantity as quantity_inventory
    , rowguid
  from  {{source('source_dw','productinventory')}}
)

select *
from source_data