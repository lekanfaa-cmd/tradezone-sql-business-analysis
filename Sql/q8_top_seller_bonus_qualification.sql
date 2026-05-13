--Top Sellers 

WITH order_revenue AS (
    SELECT 
        order_id,
        SUM(quantity * unit_price) AS total_revenue
    FROM order_items
    GROUP BY order_id
),

orders_2024 AS (
    SELECT 
        o.order_id,
        o.seller_id
    FROM orders o
    WHERE EXTRACT(YEAR FROM o.order_date) = 2024
),

seller_performance AS (
    SELECT 
        s.seller_id,
        s.seller_name,

        COUNT(DISTINCT o.order_id) AS total_orders,

        SUM(orv.total_revenue) AS total_revenue,

        AVG(r.rating) AS avg_rating

    FROM orders_2024 o

    JOIN order_revenue orv 
        ON o.order_id = orv.order_id

    JOIN sellers s 
        ON o.seller_id = s.seller_id

    LEFT JOIN reviews r 
        ON o.order_id = r.order_id

    GROUP BY s.seller_id, s.seller_name
)

SELECT *
FROM seller_performance
WHERE total_orders >= 10
  AND avg_rating >= 4.0
ORDER BY total_revenue DESC
LIMIT 10;