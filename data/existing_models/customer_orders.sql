-- Este é um modelo ineficiente que combina dados de clientes com informações de pedidos
-- Tem inconsistências de nomenclatura e não separa as preocupações adequadamente
-- Mistura diferentes níveis de granularidade

CREATE OR REPLACE VIEW customer_orders AS
SELECT 
    c.customer_id,
    c.first_name || ' ' || c.last_name as customer_name,
    c.email,
    c.city,
    c.state,
    c.country,
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount as total,  -- inconsistência de nome
    o.shipping_amount as shipping,  -- inconsistência de nome
    o.tax_amount as tax,  -- inconsistência de nome
    o.discount_amount as discount,  -- inconsistência de nome
    b.brand_name,
    COUNT(oi.order_item_id) as items_count,
    SUM(oi.total_price) as items_total,
    -- Mistura análises que deveriam estar em outro modelo
    (SELECT COUNT(*) FROM orders o2 WHERE o2.customer_id = c.customer_id) as total_orders_by_customer,
    -- Cálculos ineficientes misturados no mesmo modelo
    CASE 
        WHEN o.order_date >= CURRENT_DATE - INTERVAL '30 days' THEN 'Recente'
        WHEN o.order_date >= CURRENT_DATE - INTERVAL '90 days' THEN 'Últimos 90 dias'
        ELSE 'Antigo'
    END as recency_segment
FROM 
    customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    LEFT JOIN brands b ON o.brand_id = b.brand_id
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    -- Join desnecessário que causa problemas de desempenho
    LEFT JOIN products p ON oi.product_id = p.product_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    c.state,
    c.country,
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount,
    o.shipping_amount,
    o.tax_amount,
    o.discount_amount,
    b.brand_name
ORDER BY 
    o.order_date DESC;
