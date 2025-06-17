-- Este view consulta diretamente os dados brutos para relatórios
-- Ele tem cálculos desnecessariamente complexos e falta uma organização clara
-- Múltiplos JOINs ineficientes causando problemas de desempenho

CREATE OR REPLACE VIEW brand_performance AS
SELECT 
    b.brand_id, 
    b.brand_name,
    b.website,
    COUNT(DISTINCT p.product_id) as product_count,
    COUNT(DISTINCT c.customer_id) as customer_count,
    COUNT(DISTINCT o.order_id) as order_count,
    SUM(o.total_amount) as total_sales,
    SUM(o.total_amount) / COUNT(DISTINCT o.order_id) as avg_order_value,
    SUM(o.total_amount - o.shipping_amount - o.tax_amount) as net_sales,
    SUM(oi.discount_amount) as total_discounts,
    (SUM(oi.discount_amount) / SUM(o.total_amount)) * 100 as discount_percentage,
    -- Cálculos redundantes e potencialmente ineficientes
    (SELECT COUNT(DISTINCT o2.order_id) 
     FROM orders o2 
     WHERE o2.brand_id = b.brand_id AND o2.order_date >= CURRENT_DATE - INTERVAL '30 days') as orders_last_30_days,
    (SELECT SUM(o3.total_amount) 
     FROM orders o3 
     WHERE o3.brand_id = b.brand_id AND o3.order_date >= CURRENT_DATE - INTERVAL '30 days') as sales_last_30_days
FROM 
    brands b
    LEFT JOIN products p ON b.brand_id = p.brand_id
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    LEFT JOIN orders o ON oi.order_id = o.order_id
    LEFT JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 
    b.brand_id, 
    b.brand_name,
    b.website
ORDER BY 
    total_sales DESC;
