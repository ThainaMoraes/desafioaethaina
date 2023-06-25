with source_data as (
  select 
    businessentityid as business_entity_id
    , productid as product_id
    , standardprice as standard_price
    , minorderqty as min_order_qty
    , maxorderqty as max_order_qty
    , onorderqty as on_order_qty
    , unitmeasurecode as unit_measure_code
  from  {{source('source_dw','productvendor')}}
)

select *
from source_data
