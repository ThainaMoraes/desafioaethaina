{{
    config(materialized='table')
}}

with product as (
    select * 
    from {{ ref('stg_product') }} 
)

, subcategory as (
    select * 
    from {{ ref('stg_product_subcategory') }}
)

, category as (
    select * 
    from {{ ref('stg_product_category') }}
)

, inventory as (
    select * 
    from {{ ref('stg_product_inventory') }}
)

, location as (
    select * 
    from {{ ref('stg_product_location') }}
)

, model as (
    select * 
    from {{ ref('stg_product_model') }}
)

, union_all as (
    select 
        product.product_id
        , product_model_id
        , subcategory_id
        , category.category_id
        , location.location_id
        , category_name
        , subcategory_name
        , product_name
        , product_number
        , makeflag
        , finished_goods_flag
        , color
        , safety_stock_level
        , stand_cost
        , list_price
        , size_product
        , style_product
        , weight_product
        , location_name
        , cost_rate
        , availability
        , shelf
        , bin
        , quantity_inventory
        , model_name
    from product
    left join subcategory
    on product.product_subcategory_id = subcategory.subcategory_id
    left join category
    on subcategory.category_id = category.category_id
    left join inventory 
    on inventory.product_id = product.product_id
  	left join location
  	on location.location_id = inventory.location_id
    left join model
    on product.product_model_id = model.model_id
)

select * 
from union_all
