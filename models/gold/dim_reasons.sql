with int_sales as (
    select *
    from {{ ref('int_reason') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by sales_reason_id order by sales_reason_id) as dedup_index
    from int_sales
)

, reason_with_sk  as (
    select
        MD5(cast(sales_reason_id as string)) as sales_reason_fk
        , sales_order_id
        , name_reason
        , reason_type
      from deduplication_data
    where dedup_index = 1
)

select *
from reason_with_sk