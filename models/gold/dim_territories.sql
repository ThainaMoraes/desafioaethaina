with int_address as (
    select *
    from {{ ref('int_address') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by territory_id order by territory_id) as dedup_index
    from int_address
)

, territory_with_sk  as (
    select
        {{ dbt_utils.generate_surrogate_key(['territory_id']) }} as territory_sk
        , name_territory_description
      from deduplication_data
    where dedup_index = 1
)

select *
from territory_with_sk