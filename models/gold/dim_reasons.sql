with int_sales as (
    select *
    from {{ ref('int_sales') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by sales_reason_id order by sales_reason_id) as dedup_index
    from int_sales
)

, reason_with_sk  as (
    select
        row_number() over (order by sales_reason_id) as reason_sk
        , name_reason
        , reason_type
      from deduplication_data
    where dedup_index = 1
)

select *
from reason_with_sk