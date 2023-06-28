with int_customer as (
    select * 
    from {{ ref('int_customer') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by customer_id order by customer_id) as dedup_index
    from int_customer
)

, customer_with_sk  as (
    select
        row_number() over (order by customer_id) as customer_sk
        , full_name
		, suffix
		, store_id
		, territory_id 
        , person_type
		, name_style
		, courtesy_title
    from deduplication_data
    where dedup_index = 1
)

select *
from customer_with_sk