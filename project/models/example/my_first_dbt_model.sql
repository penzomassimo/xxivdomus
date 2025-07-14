
{{ config(materialized='table') }}

with source_data as (

    select 1 as id
    union all
    select null as id

)

select *
from source_data



WITH active_users AS (
  SELECT *
  FROM users
  WHERE is_active = true
)

SELECT
  u.id,
  u.name
FROM active_users u
WHERE u.signup_date > '2024-01-01';





