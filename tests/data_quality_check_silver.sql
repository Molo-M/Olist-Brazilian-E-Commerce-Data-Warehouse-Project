-- 1) Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results

-- For customers table
SELECT 
    customer_unique_id,
    COUNT(*) 
FROM silver.customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1 OR customer_unique_id IS NULL
GO

-- For orders table
SELECT
    order_id,
    COUNT(*)
FROM silver.orders
GROUP BY order_id
HAVING COUNT(*) > 1 OR order_id IS NULL
GO

-- For order reviews table
SELECT
    review_id,
    COUNT(*)
FROM silver.order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1 OR review_id IS NULL
GO

-- Result: There duplicates of review_id. This is because if a customer buys multiple items in a single shopping cart session, 
-- Olist sometimes splits them into different orders (especially if they are purchased from different sellers).

-- For product category name translation table
SELECT
    product_category_name,
    COUNT(*)
FROM silver.product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1 OR product_category_name IS NULL
GO

-- For products table
SELECT
    product_id,
    COUNT(*)
FROM silver.products
GROUP BY product_id
HAVING COUNT(*) > 1 OR product_id IS NULL
GO

-- For sellers table
SELECT
    seller_id,
    COUNT(*)
FROM silver.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1 OR seller_id IS NULL
GO

-- 2) Check for Invalid Date Orders (Start Date > End Date)
-- Expectation: No Results

-- For orders table
SELECT *
FROM silver.orders
WHERE order_delivered_customer_date < order_purchase_timestamp
GO

-- For order reviews table
SELECT *
FROM silver.order_reviews
WHERE review_answer_timestamp < review_creation_date
GO

-- 3) Data Standardization & Consistency
-- Expectation: No NULLS or Duplicates

-- For order payments table
SELECT DISTINCT payment_type
FROM silver.order_payments
GO

-- For products table
SELECT DISTINCT product_category_name
FROM silver.products
GO

-- For seller table
SELECT DISTINCT seller_state
FROM silver.sellers
GO
