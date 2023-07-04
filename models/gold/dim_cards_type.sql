with int_sales as (
	select * 
    from {{ ref('int_sales') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by card_type order by card_type) as dedup_index
    from int_sales
)

, credit_card_with_sk  as (
    select
        {{ dbt_utils.generate_surrogate_key(['card_type']) }} as credit_card_sk
        , card_type
      from deduplication_data
    where dedup_index = 1
)
 
select *
from credit_card_with_sk 
