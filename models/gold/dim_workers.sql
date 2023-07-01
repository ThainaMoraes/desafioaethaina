with int_person as (
    select * 
    from {{ ref('int_person') }}
    where person_type != 'Individual Customer'
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by fixed_person_id order by fixed_person_id) as dedup_index
    from int_person
)

, worker_with_sk  as (
    select
        MD5(cast(fixed_person_id as string)) as worker_sk
        , courtesy_title
        , full_name
		, territory_id 
        , person_type
        , suffix
        , store_id
        , email_promotion
        , name_territory_description
        , country_region_code
        , country_region_name
        , state_province_id
        , state_province_code
        , state_province_name
    from deduplication_data
    where dedup_index = 1
)

select *
from worker_with_sk