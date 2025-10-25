with src as (
  select * from {{ source('raw','orders') }}
)
select
  cast(order_id as int)         as order_id,
  cast(customer_id as int)      as customer_id,
  cast(order_date as date)      as order_date,
  status,
  cast(shipping_cost as numeric) as shipping_cost,
  nullif(coupon_code,'')        as coupon_code,
  payment_method
from src
