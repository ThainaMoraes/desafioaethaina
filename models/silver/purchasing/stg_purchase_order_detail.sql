with source_data as (
  select 
    purchaseorderid as purchase_order_id
    , purchaseorderdetailid as purchase_order_detail_id
    , cast(duedate as timestamp) as due_date
    , orderqty as order_qty
    , productid as product_id
    , unitprice as unit_price
    , receivedqty as received_qty
    , rejectedqty as rejected_qty
  from  {{source('source_dw','purchaseorderdetail')}}
)

select *
from source_data