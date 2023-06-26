with
  source_data as (
    select
      businessentityid as business_entity_id
      , terrictoryid as territory_id
      , salesquota as sales_quota
      , bonus
      , commissionpct as commission_pct
      , salesytd as sales_total
      , saleslastyear as sales_last_year
    from {{ source('source_dw', 'salesperson') }}
  )

select  *
from source_data