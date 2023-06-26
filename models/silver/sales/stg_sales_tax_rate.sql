with
  source_data as (
    select
      salestaxrateid as sales_tax_rate_id
      , stateprovinceid as state_province_id
      , taxtype as tax_type
      , taxrate as tax_rate
      , name as name_tax_rate_desciption
    from {{ source('source_dw', 'salestaxrate') }}
  )

select  *
from source_data