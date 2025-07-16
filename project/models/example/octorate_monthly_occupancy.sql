
{{ config(materialized='table') }}
select 
	sum(o.superior_available),
	sum(o.suite_available),
	sum(o.deluxe_available),
	sum(o.single_available),
	sum(o.superior_available) + sum(o.suite_available) + sum(o.deluxe_available) + sum(o.single_available) as total_nights_not_sold,
	count(o.data_month) * 6 as total_nights_in_month,
	(count(o.data_month) * 6) - (sum(o.superior_available) + sum(o.suite_available) + sum(o.deluxe_available) + sum(o.single_available)) as total_nights_sold,
	count(o.data_month) as days_in_month,
	((count(o.data_month) * 6::numeric) - (sum(o.superior_available) + sum(o.suite_available) + sum(o.deluxe_available) + sum(o.single_available))) / (count(o.data_month) * 6) as occupancy_month
	
from {{ ref('octorate_occupancy') }} o
group by o.data_month
order by o.data_month
