with int_person as (
    select * 
    from {{ ref('int_person') }}
    where customer_id is not null
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by customer_id order by customer_id) as dedup_index
    from int_person
)

, customer_with_sk  as (
    select
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk
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