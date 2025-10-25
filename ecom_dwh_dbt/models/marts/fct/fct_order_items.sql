select
  oi.order_item_id,
  {{ sk_from(["cast(oi.order_item_id as string)"]) }} as order_item_sk,
  oi.order_id,
  oi.product_id,
  o.customer_id,
  o.order_date,
  oi.quantity,
  oi.unit_price,
  oi.discount_pct,
  (oi.quantity * oi.unit_price * (1 - oi.discount_pct)) as line_revenue
from {{ ref('stg_order_items') }} oi
left join {{ ref('stg_orders') }} o using (order_id)
