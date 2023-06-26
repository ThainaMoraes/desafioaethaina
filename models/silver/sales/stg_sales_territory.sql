with source_data as (
    select
        territoryid as territory_id
        , name as name_territory_description
        , countryregioncode as country_region_code
        , 'group' as group_geo
        , salesytd as sales_territory_year
        , saleslastyear as sales_last_year
        , costytd as bussiness_cost_in_territory
        , costlastyear as bussiness_cost_in_territory_last_year
        , rowguid  rowguid_sales_territory
    from {{ source('source_dw', 'salesterritory') }}
  )

select  *
from source_data