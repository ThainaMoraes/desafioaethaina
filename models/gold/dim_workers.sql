with int_person as (
    select * 
    from {{ ref('int_person') }}
    where person_id is not null
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by person_id order by person_id) as dedup_index
    from int_person
)

, worker_with_sk  as (
    select
        MD5(cast(person_id as string)) as worker_sk
        , courtesy_title
        , full_name
		, territory_id 
        , person_type
        , suffix
        , store_id
        , email_promotion
    from deduplication_data
    where dedup_index = 1
)

select *
from worker_with_sk