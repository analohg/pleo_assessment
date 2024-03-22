with mrr_reporting_data as (
    select *
    from {{ref('int_invoice_amount_converted_to_eur')}}
)


SELECT 
   *
FROM mrr_reporting_data
WHERE type = 'subscription'

