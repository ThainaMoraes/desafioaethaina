with source_data as (
  select
    salesorderid as sales_order_id
    , salesreasonid as sales_reason_id
  from
    {{ source('source_dw', 'salesorderheadersalesreason') }}
)
select  *
from  source_data