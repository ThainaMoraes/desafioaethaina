with source_data as (
  select 
    salesorderid as sales_order_id
    , salesorderdetailid as sales_order_detail_id
    -- Shipment tracking number supplied by the shipper.
    , carriertrackingnumber as carrier_tracking_number
    , orderqty as order_qty
    , productid as product_id
    -- Promotional code. Foreign key to SpecialOffer.SpecialOfferID.
    , specialofferid as special_offer_id
    , unitprice as unit_price
    , unitpricediscount as unit_price_discount
    /* Per product subtotal. Computed as UnitPrice * (1 - UnitPriceDiscount) * OrderQty.
      Computed: isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0))* era o linetotal*/ 
  from  {{source('source_dw','salesorderdetail')}}
)

select *
from source_data