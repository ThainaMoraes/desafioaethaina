with source_data as (
  select 
    productid as product_id
    , productmodelid as product_model_id
    , productsubcategoryid as product_subcategory_id
    , name as product_name
    , productnumber as product_number
    , makeflag
    , finishedgoodsflag as finished_goods_flag
    , color
    , safetystocklevel as safety_stock_level
    , standardcost as stand_cost
    , listprice as list_price
    , size as size_product
    , style as style_product
    , weight as weight_product 
  from  {{ source('source_dw','product') }}
)

select * from source_data 
