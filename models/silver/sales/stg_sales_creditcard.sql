with source_data as (
  select 
    creditcardid as credit_card_id
    , cardtype as card_type
  from  {{source('source_dw','creditcard')}}
)
select *
from source_data 