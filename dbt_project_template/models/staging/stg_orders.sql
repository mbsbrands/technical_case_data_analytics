-- Example of a staging model for orders

{{
    "materialized": "table",
    "tags": []
}}

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
