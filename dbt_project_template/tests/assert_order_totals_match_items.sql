-- Example of a custom dbt test
-- This test verifies that the total amount in orders matches the sum of the order items

SELECT
    orders.order_id,
    orders.total_amount as order_total,
    SUM(items.total_price) as items_sum,
    ABS(orders.total_amount - SUM(items.total_price)) as difference
FROM {{ ref('stg_orders') }} as orders
JOIN {{ ref('stg_order_items') }} as items
    ON orders.order_id = items.order_id
GROUP BY
    orders.order_id,
    orders.total_amount
HAVING ABS(orders.total_amount - SUM(items.total_price)) > 0.01
