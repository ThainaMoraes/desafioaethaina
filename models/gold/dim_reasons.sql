with int_sales as (
    select *
    from {{ ref('int_reason') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by reason_type order by reason_type) as dedup_index
    from int_sales
)

, reason_with_sk  as (
    select
        {{ dbt_utils.generate_surrogate_key(['reason_type']) }} as reason_type_sk
        , reason_type
      from deduplication_data
    where dedup_index = 1
)

select *
from reason_with_sk