with int_person as (
    select * 
    from {{ ref('int_person') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by business_entity_id order by business_entity_id) as dedup_index
    from int_person
)

, customer_with_sk  as (
    select
        MD5(cast(business_entity_id as string)) as customer_sk
        , full_name 
		, territory_id 
        , person_type
		, courtesy_title
        , email_promotion
    from deduplication_data
    where dedup_index = 1
)

select *
from customer_with_sk