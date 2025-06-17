-- Example of an intermediate model that joins orders and customers
-- This represents a pattern you might consider for your solution

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
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
    c.country
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
