with int_address as (
    select *
    from {{ ref('int_address') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by address_id order by address_id) as dedup_index
    from int_address
)

, address_with_sk  as (
    select
        MD5(cast(address_id as string)) address_sk
        , business_entity_id
        , address_type_id
        , address_type_name
        , worker_id
        , contact_type_id
        , contact_type_name_worker
        , address
        , city
        , state_province_id
      from deduplication_data
    where dedup_index = 1
)

select *
from address_with_sk
