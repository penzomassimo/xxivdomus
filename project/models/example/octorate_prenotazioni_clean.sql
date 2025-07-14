
{{ config(materialized='table') }}

select
	u.data_creazione,
	to_date(u.data_creazione, 'DD/MM/YYYY') as data_creazione_parsed,
	extract(dow from to_date(u.data_creazione, 'DD/MM/YYYY')) as data_creazione_dow,
	extract(month from to_date(u.data_creazione, 'DD/MM/YYYY')) as data_creazione_month
		
from {{ source('xxiv_source', 'octorate_prenotazioni_confermate_sheet_1') }} as u


