with o as (
  select * from {{ ref('stg_orders') }}
), oi as (
  select order_id, sum(quantity*unit_price*(1-discount_pct)) as items_amount,
         sum(quantity) as total_qty
  from {{ ref('stg_order_items') }}
  group by order_id
)
select
  o.order_id,
  {{ sk_from(["cast(o.order_id as string)"]) }} as order_sk,
  o.customer_id,
  o.order_date,
  oi.items_amount,
  o.shipping_cost,
  coalesce(oi.items_amount,0) + coalesce(o.shipping_cost,0) as gross_revenue,
  o.status,
  o.coupon_code,
  o.payment_method,
  oi.total_qty
from o
left join oi using (order_id)
