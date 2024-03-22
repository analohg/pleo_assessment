with invoice_item as (
    select 
        *
    from {{ref('stg_billing_data__invoice_items')}}
),

 -- convert amount column to eur
convert_amount_to_eur as (
    select 
        -- ids
        id,
        invoice_id,

        -- strings
        type,
        currency,

        -- date and time
        period_end,
        period_start,
        date_diff(period_end, period_start, day) as days_between_invoice_start_and_invoice_end_date,
        _synced,
        
        -- numeric
        amount,
        case when currency = 'dkk' then amount / 7.45
             when currency = 'sek' then amount / 11.22
             when currency = 'gbp' then amount / 0.87
             else amount 
        end as amount_in_eur
    from invoice_item
)

select 
    *
from convert_amount_to_eur