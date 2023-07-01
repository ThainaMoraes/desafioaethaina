with int_address as (
    select *
    from {{ ref('int_address') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by 
            business_entity_id
            , address_type_name 
        order by business_entity_id) as dedup_index
    from int_address
)

, prodcut_with_sk  as (
    select
        row_number() over (order by business_entity_id) as address_sk
        , address_id
        , address_type_id
        , contact_type_id
        , person_id
        , address_type_name
        , address
        , city
        , state_province_id
      from deduplication_data
    where dedup_index = 1
)

select *
from prodcut_with_sk