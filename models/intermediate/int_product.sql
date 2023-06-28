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

, union_product_subcategory as (
    select 
       product.*
       , category_id
       , subcategory_name
    from subcategory
    left join product
    on product.product_subcategory_id = subcategory.subcategory_id
)

, union_product_category as (
	select 
		union_product_subcategory.*
		, category_name
	from category
	left join union_product_subcategory
    on union_product_subcategory.category_id = category.category_id
)

, union_product_model as (
	select 
		union_product_category.*
		, model_name
	from model
	left join union_product_category
    on union_product_category.product_model_id = model.model_id
)

, union_product_inventory as (
    select 
        union_product_model.*
        , quantity_inventory
        , shelf
        , bin
    from inventory
    left join union_product_model
    on union_product_model.product_id = inventory.product_id
)

select * 
from union_product_inventory
