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

, model as (
    select * 
    from {{ ref('stg_product_model') }}
)

, union_product_subcategory as (
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
        , weight_product 
        , case 
            when style_product = 'W'
                then 'Feminino'
            when style_product = 'M'
                then 'Masculino'
            when style_product = 'U'
                then 'Unisex'
            else 'Não definido'
        end as style_product
       , category_id
       , subcategory_name
    from product
    left join subcategory
    on product.product_subcategory_id = subcategory.subcategory_id
)

, union_product_category as (
	select 
		union_product_subcategory.*
		, category_name
	from union_product_subcategory
	left join category
    on union_product_subcategory.category_id = category.category_id
)

, union_product_model as (
	select 
		union_product_category.*
		, model_name
	from union_product_category
	left join model
    on union_product_category.product_model_id = model.model_id
)


select * 
from union_product_model
