with source_data as (
  select
    salesorderid as sales_order_id
    , customerid as customer_id
    , cast(cast(orderdate as timestamp) as date) as order_date
    , cast(cast(duedate as timestamp) as date) as due_date
    , cast(cast(shipdate as timestamp) as date) as ship_date
    , status
    , onlineorderflag as online_order_flag
    , purchaseordernumber as purchase_order_number
    , accountnumber as account_number
    , salespersonid as sales_person_id
    , territoryid as territory_id
    , billtoaddressid as bill_to_address_id
    , shiptoaddressid as ship_to_address_id
    , shipmethodid as ship_method_id
    , creditcardid as credit_card_id
    , creditcardapprovalcode as credit_card_approval_code 
    , currencyrateid as currency_rate_id
    , subtotal as sub_total
    , taxamt as tax_amount
    , freight
    /*Total due from customer. Computed as Subtotal + TaxAmt + Freight.
      Computed: isnull(([SubTotal]+[TaxAmt])+[Freight],(0)) */
    , totaldue as total_due
    , rowguid
  from
    {{ source('source_dw', 'salesorderheader') }}
)

select * 
  from source_data