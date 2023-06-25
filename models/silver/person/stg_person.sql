with source_data as (
  select 
    businessentityid as business_entity_id
    , persontype as person_type
    , namestyle as name_style
    , title as courtesy_title
    , firstname as first_name
    , middlename as middle_name
    , lastname as last_name
    , suffix
    , emailpromotion as email_promotion 
  from  {{source('source_dw','person')}}
)

select *
from source_data