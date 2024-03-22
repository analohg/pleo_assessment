WITH invoice as (
    SELECT 
        string_field_0,
        string_field_1
    FROM {{source('billing_data', 'invoice')}}
),

-- the header columns in the invoice table are named string_field_0 and string_field_1
-- while the first rows bear the actual names of the columns (id and customer_id)
-- I'll filter out the first rows from the table, and rename the header columns appropriately

remove_id_and_customer_id_row as (
    SELECT
        *
    FROM invoice
    WHERE string_field_0  <> 'id'
)

SELECT 
    -- ids
    
    string_field_0 as invoice_id,
    string_field_1 as customer_id
FROM remove_id_and_customer_id_row





