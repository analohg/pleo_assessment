WITH invoice as (
    SELECT 
        *
    FROM {{ref('int_invoice_amount_converted_to_eur')}}
)

SELECT 
    *
FROM invoice