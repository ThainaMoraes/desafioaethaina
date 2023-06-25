with source_data as (
    select
        territoryid as territory_id
        , businessentityid as business_entity_id
        , startdate as start_date
        , enddate as end_date
    from {{ source('source_dw', 'salesterritoryhistory') }}
  )

select  *
from source_data