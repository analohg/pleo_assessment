With mrr_reporting_data as (
    select *
    from {{ref('mrr_reporting_data')}}
)

select
    extract(year from date(period_start)) as year,
    extract(month from date(period_start)) as month_of_year,
    sum(amount_in_eur) / sum(case when days_between_invoice_start_and_invoice_end_date = 0 then 0.01 else days_between_invoice_start_and_invoice_end_date end) as mrr_per_month
from mrr_reporting_data
group by 1,2
order by 1,2