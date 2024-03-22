With mrr_reporting_data as (
    select *
    from {{ref('mrr_reporting_data')}}
)

select
    date(period_start) as date,
    customer_id,
    invoice_id,
    sum(amount_in_eur) / sum(case when days_between_invoice_start_and_invoice_end_date = 0 then 0.01 else days_between_invoice_start_and_invoice_end_date end) as mrr
from mrr_reporting_data
group by 1,2,3
order by 1