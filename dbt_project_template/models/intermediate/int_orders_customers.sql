-- Example of an intermediate model that joins orders and customers

{{
    "materialized": "incremental",
    "unique_key": "order_id",
    "tags": []
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
{{ if is_incremental() }}
    WHERE updated_at >= (SELECT MAX(updated_at) FROM {{ this }})
{{ endif }}

),

customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
)

SELECT
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    o.shipping_amount,
    o.tax_amount,
    o.discount_amount,
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    c.state,
    c.country,
    o.created_at,
    o.updated_at
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
