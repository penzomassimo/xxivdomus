
{{ config(materialized='table') }}
select 

	r.punteggio_recensione  as rating_globale,
	r.servizi as rating_servizi,
	r.staff as rating_staff,
	r.comfort as rating_comfort,
	r.pulizia as rating_pulizia,
	r.rapporto_qualita_prezzo as rating_qualita_prezzo,
	r.posizione as rating_posizione,
	r.data_della_recensione::timestamp::date as data_recensione,
	extract(year from r.data_della_recensione::timestamp) as data_recensione_year,
	extract(month from r.data_della_recensione::timestamp) as data_recensione_month


from {{ source('octorate_prenotazioni', 'reviews_booking_sheet_1') }} as r
-- group by b.data_operazione_month, b.data_operazione_year
-- order by b.data_operazione_month
