-- ============================
-- DATA CLEANING SECTION
-- ============================


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'customers';


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'orders';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'order_items';


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'payments';


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'products';


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'reviews';


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'sellers';


-- Check missing signup dates
SELECT *
FROM customers
WHERE signup_date IS NULL;

-- Check missing order dates
SELECT *
FROM orders
WHERE order_date IS NULL
   OR total_amount IS NULL;
-- Orders with NULL delivery_date are assumed to be pending deliveries
-- These records were retained but excluded from fulfilment time analysis

-- Finding missing total amount 
SELECT *
FROM orders
WHERE total_amount IS NULL;
-- Identified missing total_amount values in orders table
-- These values are critical for revenue analysis and must be reconstructed


-- Recalculate missing total_amount using order_items
UPDATE orders o
SET total_amount = sub.calculated_total
FROM (
    SELECT order_id,
           SUM(quantity * unit_price) AS calculated_total
    FROM order_items
    GROUP BY order_id
) sub
WHERE o.order_id = sub.order_id
AND o.total_amount IS NULL;
-- Detected inconsistencies in line_total
-- Recalculated total_amount using quantity * price for accuracy


SELECT COUNT(*)
FROM order_items
WHERE ABS(line_total - (quantity * unit_price)) > 1;


--- checking for duplicates 

SELECT email, COUNT(*)
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;


SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;


-- Checking for emails linked to orders
SELECT c.customer_id, c.email, o.order_id
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;


-- Remove duplicate customers that are NOT linked to any orders
DELETE FROM customers c
WHERE c.customer_id IN (
    SELECT c1.customer_id
    FROM customers c1
    JOIN customers c2
      ON c1.email = c2.email
     AND c1.customer_id <> c2.customer_id
    LEFT JOIN orders o
      ON c1.customer_id = o.customer_id
    WHERE o.customer_id IS NULL
);
-- Duplicate customers identified based on email
-- Customers linked to existing orders were preserved to maintain referential integrity
-- Only duplicate records not associated with any orders were removed



-- Correcting Inconsistent Formating

UPDATE customers
SET state = INITCAP(TRIM(state));

UPDATE customers
SET city = INITCAP(TRIM(city));

UPDATE customers
SET state = 'Lagos'
WHERE state = 'Lago S';

UPDATE products
SET category = INITCAP(TRIM(category));

UPDATE sellers
SET state = INITCAP(TRIM(state));

UPDATE sellers
SET city = INITCAP(TRIM(city));

UPDATE sellers
SET product_category = INITCAP(TRIM(product_category));



-- Ensure date format is consistent
UPDATE orders
SET order_date = order_date::DATE;

UPDATE orders
SET delivery_date = delivery_date::DATE
WHERE delivery_date IS NOT NULL;

UPDATE reviews
SET review_date = review_date::DATE

UPDATE sellers
SET onboarding_date = onboarding_date::DATE


-- Flagging inconsistent orders
SELECT o.order_id,
       o.total_amount,
       SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
HAVING ABS(o.total_amount - SUM(oi.quantity * oi.unit_price)) > 10;


-- Fix incorrect total_amount values using recalculated totals
UPDATE orders o
SET total_amount = sub.calculated_total
FROM (
    SELECT order_id,
           SUM(quantity * unit_price) AS calculated_total
    FROM order_items
    GROUP BY order_id
) sub
WHERE o.order_id = sub.order_id
AND ABS(o.total_amount - sub.calculated_total) > 10;
-- Validated order totals against line-item calculations
-- Identified discrepancies greater than ₦10
-- Updated only inconsistent records using aggregated values from order_items
-- order_items treated as source of truth due to granularity



-- checking ratings
SELECT *
FROM reviews
WHERE rating < 1 OR rating > 5;

DELETE FROM reviews
WHERE rating < 1 OR rating > 5;
-- Identified and removed invalid review ratings outside the range of 1–5
-- This ensures accuracy in customer satisfaction and seller performance analysis


-- checking unit_price
SELECT *
FROM products
WHERE unit_price < 0;
-- Checked for negative product prices; none found
-- No corrective action required

-- checking for discount percentage
SELECT *
FROM products
WHERE discount_percentage > 100;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'products';
-- Discount percentage column not found in the products table
-- Therefore, validation for discount values above 100% could not be performed
-- This limitation has been noted and does not impact other analyses



-- ============================
-- EXPLORATION
-- ============================

select * from customers;

select * from order_items;

select * from orders;

select * from payments;

select * from products; 

select * from reviews; 

select * from sellers;
