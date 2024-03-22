# pleo_assessment

## Part 1 (Project Structure)

For my model structure, I built  3 folders:

- staging: This houses all the source data. I also create a sub-folder "billing_data" to group my sources appropriately. In this case, data from billing will go on billing_data. If I had data from marketing tools like google analytics, this will go under a new sub-folder like "marketing"

- Intermediate: This houses all my transformations. In this instance, I have created a model "int_invoice_amount_converted_to_eur" that converts the amout field from the invoice_item model into euros

- Marts: marts is where all business conformed data models go to


This folder can be scaled to a production environment. Just like in this simple structure, we have layers to stage source data, another layer for transformations (intermediate), and a final marts layer to host business conformed models


## Part 3 (Data Quality)

To ensure data quality across freshness, logic and consistency I have used the following tests

- freshness: On the staging layer for the invoice_item source data, I have implemented a source freshness test to *warn* me if new data has not been loaded in 24 hours 

- not_null: On the staging layer, I have implemented a not_null test on the id, invoice_id and customer_id fields from both data sources

- unique: On the staging layer, I also implemented a unique test on the id filed of the invoice_item source data, and the invoice_id of the invoice source data 

- accepted_values: On the staging layer, I implemented a accepted values test on the invoice_item.type field and invoice_item.currency field to only allow for values as I have specified
