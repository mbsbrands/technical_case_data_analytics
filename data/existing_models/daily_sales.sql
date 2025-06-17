-- Esta consulta tenta analisar vendas por data, mas tem problemas lógicos e falta de estrutura adequada
-- Algumas métricas estão calculadas incorretamente e há problemas de filtro

CREATE OR REPLACE VIEW daily_sales AS
SELECT 
    DATE(o.order_date) as date,
    b.brand_id,
    b.brand_name,
    COUNT(o.order_id) as orders,
    SUM(o.total_amount) as revenue,
    SUM(o.total_amount) / COUNT(o.order_id) as aov,  -- nomenclatura inconsistente
    COUNT(DISTINCT o.customer_id) as customers,
    SUM(o.total_amount) / COUNT(DISTINCT o.customer_id) as revenue_per_customer,
    SUM(oi.quantity) as units_sold,
    -- Lógica incorreta para novos clientes (considera apenas os criados e que compraram no mesmo dia)
    SUM(CASE WHEN c.created_at::date = DATE(o.order_date) THEN 1 ELSE 0 END) as new_customer_orders,
    -- Cálculos redundantes
    SUM(o.shipping_amount) as shipping_revenue,
    SUM(o.tax_amount) as tax_revenue,
    -- Dados de taxas/impostos que deveriam estar em outra view
    SUM(o.tax_amount) / SUM(o.total_amount) * 100 as tax_percentage,
    -- Mistura dados de diferentes níveis de granularidade
    (SELECT p.product_name FROM products p 
     JOIN order_items oi2 ON p.product_id = oi2.product_id
     JOIN orders o2 ON oi2.order_id = o2.order_id
     WHERE DATE(o2.order_date) = DATE(o.order_date) AND o2.brand_id = b.brand_id
     GROUP BY p.product_id, p.product_name
     ORDER BY SUM(oi2.quantity) DESC
     LIMIT 1) as top_product_by_date_brand
FROM 
    orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN brands b ON o.brand_id = b.brand_id
    -- Join desnecessário causando multiplicação cartesiana
    JOIN product_categories pc ON 1=1
WHERE 
    -- Filtro insuficiente (apenas exclui pedidos cancelados)
    o.order_status != 'cancelled'
GROUP BY 
    DATE(o.order_date),
    b.brand_id,
    b.brand_name
ORDER BY 
    date DESC;
