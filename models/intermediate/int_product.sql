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

, location as (
    select * 
    from {{ ref('stg_product_location') }}
)

, model as (
    select * 
    from {{ ref('stg_product_model') }}
)

, union_product_subcategory as (
    select 
       product.*
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
