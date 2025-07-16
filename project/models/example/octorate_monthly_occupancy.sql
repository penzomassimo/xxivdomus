
{{ config(materialized='table') }}
select 
	sum(o.superior_available) as superior_not_sold,
	sum(o.suite_available) as suite_not_sold,
	sum(o.deluxe_available) as delux_not_sold,
	sum(o.single_available) as single_not_sold,
	sum(o.superior_available) + sum(o.suite_available) + sum(o.deluxe_available) + sum(o.single_available) as total_nights_not_sold,
	count(o.data_month) * 6 as total_nights_in_month,
	(count(o.data_month) * 6) - (sum(o.superior_available) + sum(o.suite_available) + sum(o.deluxe_available) + sum(o.single_available)) as total_nights_sold,
	count(o.data_month) as days_in_month,
	((count(o.data_month) * 6::numeric) - (sum(o.superior_available) + sum(o.suite_available) + sum(o.deluxe_available) + sum(o.single_available))) / (count(o.data_month) * 6) as occupancy_month,
	o.data_month as data_month
	
from {{ ref('octorate_occupancy') }} o
group by o.data_month
order by o.data_month
