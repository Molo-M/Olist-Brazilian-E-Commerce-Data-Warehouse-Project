/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Galaxy Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/


-- Fact table 1: fact_sales_items
IF OBJECT_ID('gold.fact_sales_items', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales_items;
GO

CREATE VIEW gold.fact_sales_items AS
SELECT
    ROW_NUMBER() OVER (ORDER BY o.order_id, oi.order_item_id) sales_item_id, -- Create a primary key for this table
    o.order_id,
    oi.order_item_id,       -- This keeps each order item unique!
    o.customer_unique_id,   -- Key to dim_customers
    oi.product_id,          -- Key to dim_products
    oi.seller_id,           -- Key to dim_sellers
    oi.price,
    oi.freight_value,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    oi.shipping_limit_date
FROM silver.orders o
INNER JOIN silver.order_items oi 
ON o.order_id = oi.order_id
GO

-- Fact Table 2: fact_order_payments
IF OBJECT_ID('gold.fact_order_payments', 'V') IS NOT NULL
    DROP VIEW gold.fact_order_payments;
GO

CREATE VIEW gold.fact_order_payments AS
SELECT
    ROW_NUMBER() OVER (ORDER BY o.order_id, op.payment_sequential) order_payment_id, -- Create a primary key for this table
    o.order_id,
    op.payment_sequential,   -- This keeps each payment unique!
    o.customer_unique_id,    -- Key to dim_customers
    o.order_status,
    op.payment_type,
    op.payment_installments,
    op.payment_value,
    o.order_purchase_timestamp
FROM silver.orders o
INNER JOIN silver.order_payments op 
ON o.order_id = op.order_id;
GO

-- Fact Table 3: fact_order_reviews
IF OBJECT_ID('gold.fact_order_reviews', 'V') IS NOT NULL
    DROP VIEW gold.fact_order_reviews;
GO

CREATE VIEW gold.fact_order_reviews AS
SELECT
    ROW_NUMBER() OVER (ORDER BY o.order_id, r.review_id) AS order_review_id, -- Create a primary key for this table
    o.order_id,
    r.review_id,
    o.customer_unique_id,    -- Links to gold.dim_customers
    o.order_status,
    o.order_purchase_timestamp, 
    r.review_score,
    r.review_comment_title,
    r.review_comment_message,
    r.review_creation_date,
    r.review_answer_timestamp
FROM silver.orders o
INNER JOIN silver.order_reviews r 
ON o.order_id = r.order_id
GO

-- DIM TABLE 1: dim_product
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS
SELECT
      p.product_id,
      p.product_category_name,
      COALESCE(tr.product_category_name_english, 'n/a') AS product_category_name_english, -- Turn NULLs into 'n/a' to keep consistency
      p.product_name_length,
      p.product_description_length,
      p.product_photos_qty,
      p.product_weight_g,
      p.product_length_cm,
      p.product_height_cm,
      p.product_width_cm
FROM silver.products p
LEFT JOIN silver.product_category_name_translation tr
ON p.product_category_name = tr.product_category_name
GO

-- Dim Table 2: dim_customers
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS
SELECT
      c.customer_unique_id,
      c.customer_zip_code_prefix,
      c.customer_city,
      c.customer_state,
      g.geolocation_lat,
      g.geolocation_lng
FROM silver.customers c
LEFT JOIN silver.geolocation g
ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
GO

-- Dim Table 3: dim_sellers
IF OBJECT_ID('gold.dim_sellers', 'V') IS NOT NULL
    DROP VIEW gold.dim_sellers;
GO

CREATE VIEW gold.dim_sellers AS
SELECT
      sl.seller_id,
      sl.seller_zip_code_prefix,
      sl.seller_city,
      sl.seller_state,
      g.geolocation_lat,
      g.geolocation_lng
FROM silver.sellers sl
LEFT JOIN silver.geolocation g
ON sl.seller_zip_code_prefix = g.geolocation_zip_code_prefix
GO
