
{{ config(materialized='table') }}

select
	to_date(e.data, 'DD/MM') as data_parsed,
	extract(month from to_date(e.data, 'DD/MM')) as data_month,

	2 as deluxe_capacity,
	e.deluxe_double_rooms as deluxe_available,
	(2 - e.deluxe_double_rooms) as deluxe_sold,
	
	2 as superior_capacity,
	e.superior_double_rooms as superior_available,
	(2 - e.superior_double_rooms) as superior_sold,
	
	1 as suite_capacity,
	e.junior_suites as suite_available,
	(1 - e.junior_suites) as suite_sold,

	1 as single_capacity,
	e.single_rooms as single_available,
	(1 - e.single_rooms) as single_sold,
	
	e.deluxe_double_rooms + e.superior_double_rooms + e.junior_suites + e.single_rooms as total_availability,
	
	round((6 - (e.deluxe_double_rooms + e.superior_double_rooms + e.junior_suites + e.single_rooms))/6::numeric, 2) as daily_occupancy 
		
from {{ source('octorate_prenotazioni', 'octorate_occupancy_sheet_1') }} as e

