/*
====================================================
QUESTION 6: PAYMENT METHOD PREFERENCES BY STATE
====================================================

Business Objective:
Analyze customer payment preferences across states by
measuring transaction count and transaction value for
each payment method.

Business Focus:
- Regional payment behavior
- Transaction channel analysis
- Customer payment preferences
*/

WITH payment_summary AS (
    SELECT 
        c.state,
        p.payment_method,
        COUNT(p.order_id) AS transaction_count,
        SUM(p.amount) AS total_amount
    FROM payments p
    JOIN orders o 
        ON p.order_id = o.order_id
    JOIN customers c 
        ON o.customer_id = c.customer_id
    GROUP BY c.state, p.payment_method
),

ranked_methods AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY state 
               ORDER BY transaction_count DESC
           ) AS rank
    FROM payment_summary
)

SELECT 
    state,
    payment_method,
    transaction_count,
    total_amount,
    CASE 
        WHEN rank = 1 THEN 'Most Popular'
        ELSE ''
    END AS popularity_flag
FROM ranked_methods
ORDER BY state, transaction_count DESC;
