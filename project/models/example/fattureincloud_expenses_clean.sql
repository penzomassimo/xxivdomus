
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
	f.num_acquisto,
	replace(replace(replace(f.imponibile, 'EUR ', ''), '.', ''), ',', '.')::numeric as imponibile,
	replace(replace(replace(f.iva, 'EUR ', ''), '.', ''), ',', '.')::numeric as iva,
	case
		when f.num_acquisto like '%AUT%' then replace(replace(replace(f.imponibile, 'EUR ', ''), '.', ''), ',', '.')::numeric
		else replace(replace(replace(f.imponibile, 'EUR ', ''), '.', ''), ',', '.')::numeric + replace(replace(replace(f.iva, 'EUR ', ''), '.', ''), ',', '.')::numeric
	end as totale,
	replace(replace(replace(f.rit_acconto, 'EUR ', ''), '.', ''), ',', '.')::numeric as rit_acconto
		
from {{ source('octorate_prenotazioni', 'fattureincloud_invoices_expenses_sheet_1') }} as f


