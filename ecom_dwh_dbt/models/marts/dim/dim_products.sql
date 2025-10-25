with p as (
  select * from {{ ref('stg_products') }}
), oi as (
  select product_id, count(*) as sold_count, sum(quantity) as units_sold, sum(quantity*unit_price*(1-discount_pct)) as revenue
  from {{ ref('stg_order_items') }}
  group by product_id
)
select
  p.product_id,
  {{ sk_from(["cast(p.product_id as string)"]) }} as product_sk,
  p.sku,
  p.product_name,
  p.category,
  p.price,
  p.active,
  oi.sold_count,
  oi.units_sold,
  oi.revenue
from p
left join oi using (product_id)
