with source_data as (
    select
      countryregioncode as country_region_code
      , currencycode as currency_code
    from {{ source('source_dw', 'countryregioncurrency') }}
  )
select  *
from source_data