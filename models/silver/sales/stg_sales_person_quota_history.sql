with
  source_data as (
    select
      businessentityid as business_entity_id
      , quotadate as quota_date
      , salesquota as sales_quota
      , rowguid
    from {{ source('source_dw', 'salespersonquotahistory') }}
  )

select  *
from source_data