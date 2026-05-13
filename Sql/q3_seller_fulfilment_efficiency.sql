/*
====================================================
QUESTION 3: SELLER FULFILMENT EFFICIENCY
====================================================

Business Objective:
Calculate the average delivery fulfilment time for
each seller and identify the top 20 fastest-performing
sellers among those with at least 20 completed orders.

Business Focus:
- Seller operational efficiency
- Delivery performance analysis
- Customer satisfaction indicators
*/

SELECT 
    s.seller_id,
    s.seller_name,
    
    COUNT(DISTINCT o.order_id) AS total_completed_orders,
    
    ROUND(
    AVG(EXTRACT(EPOCH FROM (o.delivery_date::timestamp - o.order_date::timestamp)
	) / 3600)::numeric
, 
    2
) AS avg_fulfilment_hours,

    
    ROUND(AVG(r.rating)::numeric, 2) AS avg_rating

FROM orders o

JOIN sellers s 
    ON o.seller_id = s.seller_id

LEFT JOIN reviews r 
    ON o.order_id = r.order_id

WHERE o.delivery_date IS NOT NULL

GROUP BY s.seller_id, s.seller_name

HAVING COUNT(DISTINCT o.order_id) >= 20

ORDER BY avg_fulfilment_hours ASC

LIMIT 20; 


