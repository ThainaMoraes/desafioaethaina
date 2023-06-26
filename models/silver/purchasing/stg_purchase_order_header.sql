with source_data as (
  select
    purchaseorderid as purchase_order_id
    , revisionnumber as revision_number
    , status as status_order
    , employeeid as employee_id
    , vendorid as vendor_id
    , shipmethodid as ship_method_id
    , shipdate as ship_date
    , subtotal as sub_total
    , taxamt as tax_amount
    , freight  
    /* Total due to vendor. Computed as Subtotal + TaxAmt + Freight.
Computed: isnull(([SubTotal]+[TaxAmt])+[Freight],(0))  */
  from
    {{ source('source_dw', 'purchaseorderheader') }}
)

select * 
  from source_data