-- Q1: Customer Acquisition & 30-Day Conversion

WITH new_customers AS (
    SELECT customer_id, state, signup_date
    FROM customers
    WHERE EXTRACT(YEAR FROM signup_date) = 2024
),

first_orders AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
),

customer_conversion AS (
    SELECT 
        nc.state,
        nc.customer_id,
        CASE 
            WHEN fo.first_order_date IS NOT NULL
                 AND fo.first_order_date <= nc.signup_date + INTERVAL '30 days'
            THEN 1
            ELSE 0
        END AS converted
    FROM new_customers nc
    LEFT JOIN first_orders fo
        ON nc.customer_id = fo.customer_id
)

SELECT 
    state,
    COUNT(*) AS total_customers,
    SUM(converted) AS converted_customers,
    ROUND(100.0 * SUM(converted) / COUNT(*), 2) AS conversion_rate
FROM customer_conversion
GROUP BY state
ORDER BY total_customers DESC
LIMIT 5;