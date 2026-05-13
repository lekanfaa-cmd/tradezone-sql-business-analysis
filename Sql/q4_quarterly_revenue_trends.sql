/*
====================================================
QUESTION 4: QUARTERLY REVENUE TRENDS
====================================================

Business Objective:
Compare quarterly revenue performance across 2023
and 2024 by evaluating total revenue, average order
value, and total order volume.

Business Focus:
- Revenue growth trends
- Seasonal business performance
- Quarterly performance comparison
*/

WITH quarterly_data AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(QUARTER FROM order_date) AS quarter,
        SUM(total_amount) AS total_revenue,
        AVG(total_amount) AS avg_order_value,
        COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY year, quarter
)

-- Q4: Quarterly Revenue Trends

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(QUARTER FROM order_date) AS quarter,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value,
    COUNT(order_id) AS total_orders
FROM orders
WHERE EXTRACT(YEAR FROM order_date) IN (2023, 2024)
GROUP BY year, quarter
ORDER BY year, quarter;
