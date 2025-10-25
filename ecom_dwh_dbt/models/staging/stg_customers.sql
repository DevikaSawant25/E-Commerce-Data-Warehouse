with src as (
  select * from {{ source('raw','customers') }}
)
select
  cast(customer_id as int)      as customer_id,
  first_name,
  last_name,
  email,
  cast(signup_date as date)     as signup_date,
  country,
  state,
  cast(is_prime as int)         as is_prime
from src
