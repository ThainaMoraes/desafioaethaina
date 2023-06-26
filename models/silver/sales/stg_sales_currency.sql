with source_data as (
  select 
    currencycode as currency_code
    , name as currency_name
  from  {{source('source_dw','currency')}}
)

select *
from source_data