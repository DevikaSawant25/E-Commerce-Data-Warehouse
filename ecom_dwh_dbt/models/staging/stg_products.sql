with src as (
  select * from {{ source('raw','products') }}
)
select
  cast(product_id as int)       as product_id,
  sku,
  name                          as product_name,
  category,
  cast(price as numeric)        as price,
  cast(active as int)           as active
from src
