with product as (
    select * 
    from {{ ref('stg_product') }}
)

, subcategory as (
    select * 
    from {{ ref('stg_subcategory') }}
)

, category as (
    select * 
    from {{ ref('stg_category') }}
)

, description as (
    select * 
    from {{ ref('stg_description') }}
)

, location as (
    select * 
    from {{ ref('stg_location') }}
)

, model as (
    select * 
    from {{ ref('stg_model') }}
)

, inventory as (
    select * 
)

, union_all as (
    select 
    product_id
    , product_model_id
    , product_subcategory_id
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
    from product
    left join subcategory
    on product.product_subcategory_id = subcategory.subcategory_id
    left join category
    on subcategory.category_id = category.category_id
    left join model
    on product.product_model_id = model.model_id
)

select * 
from union_all