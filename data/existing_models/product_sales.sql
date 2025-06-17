-- Esta view tem problemas de desempenho devido a múltiplos joins e falta documentação adequada
-- Também mistura diferentes níveis de granularidade em um único modelo e usa filtros inconsistentes

CREATE OR REPLACE VIEW product_sales AS
SELECT 
    p.product_id, 
    p.product_name, 
    p.price as product_price,  -- nomenclatura inconsistente
    pc.category_name,
    b.brand_name,
    -- Inconsistência nos filtros para status de pedido
    SUM(CASE WHEN o.order_status = 'completed' THEN oi.quantity ELSE 0 END) as total_sold,
    SUM(CASE WHEN o.order_status = 'completed' THEN oi.total_price ELSE 0 END) as revenue,
    COUNT(DISTINCT o.customer_id) as unique_customers,
    COUNT(DISTINCT o.order_id) as order_count,
    -- Cálculos que poderiam ser feitos em modelos intermediários
    SUM(CASE WHEN o.order_status = 'completed' THEN oi.total_price ELSE 0 END) / 
        NULLIF(SUM(CASE WHEN o.order_status = 'completed' THEN oi.quantity ELSE 0 END), 0) as avg_selling_price,
    -- Dados agregados por tempo que deveriam estar em outra view
    SUM(CASE WHEN o.order_date >= CURRENT_DATE - INTERVAL '30 days' AND o.order_status = 'completed' 
        THEN oi.quantity ELSE 0 END) as units_sold_last_30_days,
    -- Métricas calculadas incorretamente
    (SUM(CASE WHEN o.order_status = 'completed' THEN oi.total_price ELSE 0 END) - 
     SUM(CASE WHEN o.order_status = 'completed' THEN oi.quantity * p.price ELSE 0 END)) as total_discount,
    -- Subconsultas ineficientes
    (SELECT MAX(o2.order_date) 
     FROM orders o2 
     JOIN order_items oi2 ON o2.order_id = oi2.order_id 
     WHERE oi2.product_id = p.product_id AND o2.order_status = 'completed') as last_sold_date
FROM 
    products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    LEFT JOIN orders o ON oi.order_id = o.order_id
    LEFT JOIN product_categories pc ON p.category_id = pc.category_id
    LEFT JOIN brands b ON p.brand_id = b.brand_id
    -- Join desnecessário
    LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE 
    p.is_active = true  -- filtro insuficiente
GROUP BY 
    p.product_id, 
    p.product_name, 
    p.price,
    pc.category_name,
    b.brand_name
ORDER BY 
    revenue DESC;
