
{{ config(materialized='table') }}

select
	to_date(f.data_fattura, 'DD/MM/YY') as data_fattura_parsed,
	extract(month from to_date(f.data_fattura, 'DD/MM/YY')) as data_fattura_month,
	extract(year from to_date(f.data_fattura, 'DD/MM/YY')) as data_fattura_year,
	f.ft_elettronica,
	to_date(f.data_ricezione_fe, 'DD/MM/YY') as data_ricezione_fe_parsed,
	extract(month from to_date(f.data_ricezione_fe, 'DD/MM/YY')) as data_ricezione_fe_month,
	extract(year from to_date(f.data_ricezione_fe, 'DD/MM/YY')) as data_ricezione_fe_year,
	f.centro_costo,
	f.categoria,
	f.fornitore,
	CAST(REPLACE(SUBSTRING(f.imponibile FROM '\d+,\d+'), ',', '.') AS NUMERIC) AS imponibile,
	CAST(REPLACE(SUBSTRING(f.iva FROM '\d+,\d+'), ',', '.') AS NUMERIC) AS iva,
	CAST(REPLACE(SUBSTRING(f.rit_acconto FROM '\d+,\d+'), ',', '.') AS NUMERIC) as rit_acconto
		
from {{ source('octorate_prenotazioni', 'fattureincloud_invoices_expenses_sheet_1') }} as f


