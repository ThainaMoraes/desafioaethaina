with source_data as (
  select 
    businessentityid as business_entity_id
    , accountnumber as account_number
    , name as company_name
    -- 1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below
    , creditrating as credit_rate
    , activeflag as active_flag
  from  {{source('source_dw','vendor')}}
)

select *
from source_data