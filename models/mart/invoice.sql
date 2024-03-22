{{
    config(materialized = 'incremental')
    
    }}


with invoice as (
    select *
    from {{ref('stg_billing_data__invoice')}}
),

invoice_item as (
    select *
    from {{ref('int_invoice_amount_converted_to_eur')}}
)

select
    -- ids
    ii.id,
    ii.invoice_id,
    i.customer_id,

    -- strings
    type,
    currency,

    -- date and time
    period_end,
    period_start,
    days_between_invoice_start_and_invoice_end_date,
    _synced,

    -- numeric
    amount,
    amount_in_eur
from invoice_item ii 
join invoice i on ii.invoice_id = i.invoice_id

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses >= to include records whose timestamp occurred since the last run of this model)
  where _synced >= (select max(_synced) from {{ this }})

{% endif %}