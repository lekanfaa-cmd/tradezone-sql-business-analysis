/*
====================================================
QUESTION 2: PRODUCT PERFORMANCE
====================================================

Business Objective:
Identify the top 10 products by total revenue generated
in 2024, including product category, total revenue,
and total number of orders.

Business Focus:
- Revenue-driving products
- Product category performance
- Sales concentration analysis
*/
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
