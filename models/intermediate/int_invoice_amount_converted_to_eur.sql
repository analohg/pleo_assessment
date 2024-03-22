{{
    config(materialized = 'incremental')
    
    }}

with invoice_item as (
    select 
        *
    from {{ref('stg_billing_data__invoice_items')}}
),

invoice as (
    select *
    from {{ref('stg_billing_data__invoice')}}
),


 -- convert amount column to eur
convert_amount_to_eur as (
    select 
        -- ids
        ii.id,
        ii.invoice_id,
        i.customer_id,

        -- strings
        ii.type,
        ii.currency,

        -- date and time
        ii.period_end,
        ii.period_start,
        date_diff(ii.period_end, ii.period_start, day) as days_between_invoice_start_and_invoice_end_date,
        ii._synced,
        
        -- numeric
        ii.amount,
        case when ii.currency = 'dkk' then amount / 7.45
             when ii.currency = 'sek' then amount / 11.22
             when ii.currency = 'gbp' then amount / 0.87
             else ii.amount 
        end as amount_in_eur
    from invoice_item ii
    join invoice i ON i.invoice_id = ii.invoice_id
)

select 
    *
from convert_amount_to_eur
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  where _synced >= (select max(_synced) from {{ this }})

{% endif %}