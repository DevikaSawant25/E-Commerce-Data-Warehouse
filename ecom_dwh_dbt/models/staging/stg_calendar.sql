with src as (
  select * from {{ source('raw','calendar') }}
)
select
  cast(date_day as date)        as date_day,
  cast(year as int)             as year,
  cast(quarter as int)          as quarter,
  cast(month as int)            as month,
  cast(day as int)              as day,
  cast(day_of_week as int)      as day_of_week,
  cast(week_of_year as int)     as week_of_year,
  cast(is_weekend as int)       as is_weekend
from src
