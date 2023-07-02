with int_sales as (
	select * 
    from {{ ref('int_sales') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by credit_card_id order by credit_card_id) as dedup_index
    from int_sales
)

, credit_card_with_sk  as (
    select
        MD5(cast(credit_card_id as string)) credit_card_sk
        , card_type
      from deduplication_data
    where dedup_index = 1
)

select *
from credit_card_with_sk 
