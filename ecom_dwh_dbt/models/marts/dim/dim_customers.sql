with c as (
  select * from {{ ref('stg_customers') }}
), o as (
  select customer_id, min(order_date) as first_order_date, max(order_date) as last_order_date,
         count(*) as order_count
  from {{ ref('stg_orders') }}
  group by customer_id
)
select
  c.customer_id,
  {{ sk_from(["cast(c.customer_id as string)"]) }} as customer_sk,
  c.first_name,
  c.last_name,
  c.email,
  c.signup_date,
  c.country,
  c.state,
  c.is_prime,
  o.first_order_date,
  o.last_order_date,
  o.order_count
from c
left join o using (customer_id)
