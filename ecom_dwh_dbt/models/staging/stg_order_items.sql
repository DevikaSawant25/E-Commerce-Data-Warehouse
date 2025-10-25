with src as (
  select * from {{ source('raw','order_items') }}
)
select
  cast(order_item_id as int)    as order_item_id,
  cast(order_id as int)         as order_id,
  cast(product_id as int)       as product_id,
  cast(quantity as int)         as quantity,
  cast(unit_price as numeric)   as unit_price,
  cast(discount_pct as numeric) as discount_pct
from src
