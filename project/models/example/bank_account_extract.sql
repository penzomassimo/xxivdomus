
{{ config(materialized='table') }}

select
	to_date(b.data_operazione, 'MM/DD/YY') as data_operazione_parsed,
	extract(month from to_date(b.data_operazione, 'MM/DD/YY')) as data_operazione_month,
	extract(year from to_date(b.data_operazione, 'MM/DD/YY')) as data_operazione_year,
	
	to_date(b.data_valuta, 'MM/DD/YY') as data_valuta_parsed,
	extract(month from to_date(b.data_valuta, 'MM/DD/YY')) as data_valuta_month,
	extract(year from to_date(b.data_valuta, 'MM/DD/YY')) as data_valuta_year,
	
	CASE
  		WHEN b.eur LIKE '(%' THEN
    	-- Negative value in parentheses
    	-1 * CAST(REPLACE(REPLACE(TRIM(BOTH '()' FROM b.eur), '.', ''), ',', '.') AS NUMERIC)
  		ELSE
    	-- Positive value
    	CAST(REPLACE(REPLACE(b.eur, '.', ''), ',', '.') AS NUMERIC)
	END AS trx_amount
		
from {{ source('octorate_prenotazioni', 'bank_account_sheet_1') }} as b
order by to_date(b.data_operazione, 'MM/DD/YY')