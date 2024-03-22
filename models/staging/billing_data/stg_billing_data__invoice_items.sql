WITH invoice_item as (
    SELECT 
        *
    FROM {{source('billing_data', 'invoice_item')}}
)

SELECT 
    -- ids

    id,
    invoice_id,

    -- strings
    type,
    currency,

    -- dates
    period_end,
    period_start,
    _synced,

    -- numerics
    amount,
FROM invoice_item
