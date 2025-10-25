select
  date_day,
  {{ sk_from(["cast(date_day as string)"]) }} as date_sk,
  year,
  quarter,
  month,
  day,
  day_of_week,
  week_of_year,
  is_weekend
from {{ ref('stg_calendar') }}
