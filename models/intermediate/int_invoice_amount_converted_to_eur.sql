WITH invoice_item as (
    SELECT 
        *
    FROM {{ref('stg_billing_data__invoice_items')}}
),

invoice as (
    SELECT
        *
    FROM {{ref("stg_billing_data__invoice")}}
),


invoice_amount_converted_to_eur as (
    SELECT 
        id,
        invoice_id,
        type,
        currency,
        period_end,
        period_start,
        -- calculate the difference in days between the invoice start date and invoice end date
        date_diff(period_end, period_start, day) as days_between_invoice_start_and_invoice_end_date,
        _synced,
        amount,

        -- convert amount in local currency to euros 
        case when currency = 'dkk' then amount / 7.45
             when currency = 'sek' then amount / 11.22
             when currency = 'gbp' then amount / 0.87
             else amount
        end as amount_in_eur
FROM invoice_item
)

SELECT 
    invoice_amount_converted_to_eur.*,
    invoice.customer_id
FROM invoice_amount_converted_to_eur 
JOIN invoice ON invoice_amount_converted_to_eur.invoice_id = invoice.invoice_id

