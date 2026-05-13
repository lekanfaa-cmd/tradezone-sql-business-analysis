-- Q5: Customer Spend Segmentation

WITH customer_spend AS (
    SELECT 
        c.customer_id,
        COALESCE(SUM(o.total_amount), 0) AS total_spend
    FROM customers c
    LEFT JOIN orders o 
        ON c.customer_id = o.customer_id
       AND EXTRACT(YEAR FROM o.order_date) = 2024
    GROUP BY c.customer_id
),

customer_segments AS (
    SELECT 
        customer_id,
        total_spend,
        CASE 
            WHEN total_spend >= 100000 THEN 'High Spenders'
            WHEN total_spend >= 50000 AND total_spend < 100000 THEN 'Medium Spenders'
            ELSE 'Low Spenders'
        END AS segment
    FROM customer_spend
)

SELECT 
    segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_spend), 2) AS avg_spend_per_customer,
    SUM(total_spend) AS total_revenue
FROM customer_segments
GROUP BY segment
ORDER BY total_revenue DESC;