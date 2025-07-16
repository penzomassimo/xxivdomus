{{ config(materialized='table') }}

SELECT DISTINCT ON (DATE_TRUNC('month', w.data_operazione_parsed))
  extract(month from w.data_operazione_parsed) as data_operazione_month,
  extract(year from w.data_operazione_parsed) as data_operazione_year,
  w.data_operazione_parsed,
  w.running_balance,
  w.row_number
from {{ ref('bank_account_extract') }} w
ORDER BY DATE_TRUNC('month', w.data_operazione_parsed), w.row_number DESC