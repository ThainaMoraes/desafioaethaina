with int_product as (
    select *
    from {{ ref('int_product') }}
    where product_id is not null
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by product_id order by product_id) as dedup_index
    from int_product
 
)

, prodcut_with_sk  as (
    select
        MD5(cast(product_id as string)) as product_sk
        , category_name
        , subcategory_name
        , product_name
        , product_number
        , makeflag
        , finished_goods_flag
        , color
        , safety_stock_level
        , stand_cost
        , size_product
        , style_product
        , weight_product
        , shelf
        , bin
        , quantity_inventory
        , model_name
      from deduplication_data
    where dedup_index = 1  
)

-- , select_not_null as (
--     select *
--     from prodcut_with_sk
--     where product_sk is not null
-- )

select *
from prodcut_with_sk 
