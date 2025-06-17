-- Example of a staging model for orders
-- You can use this template to create your staging models

WITH source AS (
    SELECT * FROM {{ source('raw', 'orders') }}
)

SELECT
    order_id,
    customer_id,
    order_date,
    order_status,
    payment_method,
    total_amount,
    shipping_amount,
    tax_amount,
    discount_amount,
    currency,
    brand_id,
    created_at,
    updated_at
FROM source
