/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency, 
    and accuracy of the Gold Layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


-- 1)Check for Uniqueness of primary Keys
-- Expectation: No results 

-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================

SELECT 
    customer_unique_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.dim_products'
-- ====================================================================

SELECT 
    product_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.dim_sellers'
-- ====================================================================

SELECT 
    seller_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- 2) Check the data model connectivity between fact and dimensions

-- ====================================================================
-- Checking 'gold.fact_order_payments'
-- ====================================================================

SELECT * 
FROM gold.fact_order_payments p
LEFT JOIN gold.dim_customers c
ON c.customer_unique_id = p.customer_unique_id
WHERE  c.customer_unique_id IS NULL  

-- ====================================================================
-- Checking 'gold.fact_sales_items'
-- ====================================================================

SELECT * 
FROM gold.fact_sales_items f
LEFT JOIN gold.dim_customers c
ON c.customer_unique_id = f.customer_unique_id
LEFT JOIN gold.dim_products p
ON p.product_id = f.product_id
WHERE p.product_id IS NULL OR c.customer_unique_id IS NULL  

-- ====================================================================
-- Checking 'gold.fact_order_reviews'
-- ====================================================================

SELECT * 
FROM gold.fact_order_reviews r
LEFT JOIN gold.dim_customers c
ON c.customer_unique_id = r.customer_unique_id
WHERE  c.customer_unique_id IS NULL  