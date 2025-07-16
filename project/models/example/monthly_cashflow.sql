
{{ config(materialized='table') }}
select 
b.data_operazione_month,
	SUM(CASE WHEN b.trx_amount > 0 THEN b.trx_amount ELSE 0 END) AS cash_inflows,
	SUM(CASE WHEN b.trx_amount < 0 THEN b.trx_amount ELSE 0 END) AS cash_outflows,
	sum(b.trx_amount) as net_cashflow,
	sum(CASE WHEN b.trx_amount > 0 THEN 1 ELSE 0 END) AS count_cash_inflows,
	sum(CASE WHEN b.trx_amount < 0 THEN 1 ELSE 0 END) AS count_cash_outflows	
from {{ ref('bank_account_extract') }} b
group by b.data_operazione_month
order by b.data_operazione_month
