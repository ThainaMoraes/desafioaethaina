with
  source_data as (
    select
      currencyrateid as currency_rate_id
      , currencyratedate as currency_rate_date
      , fromcurrencycode as from_currency_code
      , tocurrencycode as to_currency_code
      , averagerate as avg_rate
      , endofdayrate as end_of_day_rate
    from {{ source('source_dw', 'currencyrate') }}
  )
select  *
from source_data