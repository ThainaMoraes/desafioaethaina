with int_person as (
    select * 
    from {{ ref('int_person') }}
    where person_type = 'Individual Customer'
)with order

, deduplication_data as (
    select
        *
        , row_number() over (partition by fixed_customer_id order by fixed_customer_id) as dedup_index
    from int_person
)

, customer_with_sk  as (
    select
        row_number() over (order by fixed_customer_id) as customer_sk
        , full_name
		, territory_id 
        , person_type
		, courtesy_title
        , email_promotionwith orderwith order
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
from customer_with_sk