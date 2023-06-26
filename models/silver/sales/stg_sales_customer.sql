with source_data as (
  select 
    customerid as customer_id
    , personid as person_id
    , storeid as store_id
    , territoryid as territory_id
    , rowguid
  from  {{source('source_dw','customer')}}
)

select *
from source_data