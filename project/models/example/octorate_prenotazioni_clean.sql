
{{ config(materialized='table') }}

select
	u.data_creazione,
	to_date(u.data_creazione, 'DD/MM/YYYY') as data_creazione_parsed,
	extract(dow from to_date(u.data_creazione, 'DD/MM/YYYY')) as data_creazione_dow,
	extract(month from to_date(u.data_creazione, 'DD/MM/YYYY')) as data_creazione_month,
	extract(year from to_date(u.data_creazione, 'DD/MM/YYYY')) as data_creazione_year,
	
	u.data_arrivo,
	to_date(u.data_arrivo, 'DD/MM/YYYY') as data_arrivo_parsed,
	extract(dow from to_date(u.data_arrivo, 'DD/MM/YYYY')) as data_arrivo_dow,
	extract(month from to_date(u.data_arrivo, 'DD/MM/YYYY')) as data_arrivo_month,
	extract(year from to_date(u.data_arrivo, 'DD/MM/YYYY')) as data_arrivo_year,

	u.data_partenza,
	to_date(u.data_partenza, 'DD/MM/YYYY') as data_partenza_parsed,
	extract(dow from to_date(u.data_partenza, 'DD/MM/YYYY')) as data_partenza_dow,
	extract(month from to_date(u.data_partenza, 'DD/MM/YYYY')) as data_partenza_month,
	extract(year from to_date(u.data_partenza, 'DD/MM/YYYY')) as data_partenza_year,
	
	to_date(u.data_arrivo, 'DD/MM/YYYY') - to_date(u.data_creazione, 'DD/MM/YYYY') as booking_window,
	u.cliente,
	u.codice,
	u.sorgente,
	u.pax,
	u.notti,
	u.camera as piano_tariffario,

	REPLACE(REPLACE(u.totale, '.', ''), ',', '.')::numeric as totale,
	REPLACE(REPLACE(u.prezzo_netto_commissioni, '.', ''), ',', '.')::numeric as prezzo_netto_commissioni,
	REPLACE(REPLACE(u.importo_incassato, '.', ''), ',', '.')::numeric as importo_incassato,
	REPLACE(REPLACE(u.totale, '.', ''), ',', '.')::numeric / u.notti as adr,
	u.tassa_di_soggiorno,
	REPLACE(REPLACE(u.commissione, '.', ''), ',', '.')::numeric as commissione,
	case
		when REPLACE(REPLACE(u.commissione, '.', ''), ',', '.')::numeric > 0 
			then (REPLACE(REPLACE(u.commissione, '.', ''), ',', '.')::numeric)/(REPLACE(REPLACE(u.totale, '.', ''), ',', '.')::numeric)
		else null
	end as ratio_commissione,
	u.nazione,
	REPLACE(REPLACE(u.importo_iva, '.', ''), ',', '.')::numeric as importo_iva,
	u.pms,
	
	REPLACE(REPLACE(u.totale_da_incassare, '.', ''), ',', '.')::numeric as totale_da_incassare,
	u.adulti,
	u.bambini,
	u.neonati
		
from {{ source('octorate_prenotazioni', 'octorate_prenotazioni_confermate_sheet_1') }} as u


