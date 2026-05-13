-- Q2: Top 10 Products by Revenue in 2024

SELECT 
    p.product_id,
    p.product_name,
    p.category,

    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue,

    COUNT(DISTINCT o.order_id) AS total_orders

FROM products p

LEFT JOIN order_items oi 
    ON p.product_id = oi.product_id

LEFT JOIN orders o 
    ON oi.order_id = o.order_id
   AND EXTRACT(YEAR FROM o.order_date) = 2024

GROUP BY p.product_id, p.product_name, p.category

ORDER BY total_revenue DESC

LIMIT 10;