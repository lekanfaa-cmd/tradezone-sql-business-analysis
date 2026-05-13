-- Q7: Review Ratings and Sales Performance

WITH product_ratings AS (
    SELECT 
        product_id,
        AVG(rating) AS avg_rating
    FROM reviews
    GROUP BY product_id
),

product_revenue AS (
    SELECT 
        product_id,
        SUM(quantity * unit_price) AS total_revenue
    FROM order_items
    GROUP BY product_id
),

product_summary AS (
    SELECT 
        p.product_id,
        p.unit_price,

        COALESCE(pr.avg_rating, 0) AS avg_rating,
        COALESCE(prv.total_revenue, 0) AS total_revenue,

        CASE 
            WHEN COALESCE(pr.avg_rating, 0) >= 4 THEN 'High Rated'
            WHEN COALESCE(pr.avg_rating, 0) >= 3 THEN 'Mid Rated'
            ELSE 'Low Rated'
        END AS rating_category

    FROM products p

    LEFT JOIN product_ratings pr
        ON p.product_id = pr.product_id

    LEFT JOIN product_revenue prv
        ON p.product_id = prv.product_id
)

SELECT 
    rating_category,
    COUNT(product_id) AS product_count,
    SUM(total_revenue) AS total_revenue,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM product_summary
GROUP BY rating_category
ORDER BY total_revenue DESC;