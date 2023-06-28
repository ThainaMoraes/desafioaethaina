with int_product as (
    select *
    from {{ ref('int_product') }}
)

, deduplication_data as (
    select
        *
        , row_number() over (partition by product_id order by product_id) as dedup_index
    from int_product
)

, prodcut_with_sk  as (
    select
        row_number() over (order by product_id) as product_sk
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

select *
from prodcut_with_sk