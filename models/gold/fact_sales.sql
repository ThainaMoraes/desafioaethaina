with int_sales as (
    select * 
    from {{ ref('int_sales') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by order by sales_order_id) as dedup_index
    from int_sales
)

, sales_with_sk  as (
    select
        row_number() over (order by fixed_person_id) as worker_sk
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
from sales_with_sk