with
  source_data as (
    select
      salesreasonid as sales_reason_id
      , name as name_reason
      , reasontype as reason_type
    from {{ source('source_dw', 'salesreason') }}
  )

select  *
from source_data