/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'silver' Tables
===============================================================================
*/
IF OBJECT_ID('silver.customers', 'U') IS NOT NULL
    DROP TABLE silver.customers;
GO

CREATE TABLE silver.customers (		-- customer_id column was removed since it was redundant. We can't have both customer_id and customer_unique_id as identifiers
	customer_unique_id NVARCHAR(50),
	customer_zip_code_prefix NVARCHAR(50),
	customer_city NVARCHAR(50),
	customer_state NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.geolocation', 'U') IS NOT NULL
    DROP TABLE silver.geolocation;
GO

CREATE TABLE silver.geolocation (
	geolocation_zip_code_prefix NVARCHAR(50),
	geolocation_lat DECIMAL(18,15),
	geolocation_lng DECIMAL(18,15),
	geolocation_city NVARCHAR(50),
	geolocation_state NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.order_items', 'U') IS NOT NULL
    DROP TABLE silver.order_items;
GO

CREATE TABLE silver.order_items (
	order_id NVARCHAR(50),
	order_item_id INT,
	product_id NVARCHAR(50),
	seller_id NVARCHAR(50),
	shipping_limit_date DATETIME,
	price FLOAT,
	freight_value FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.order_payments', 'U') IS NOT NULL
    DROP TABLE silver.order_payments;
GO

CREATE TABLE silver.order_payments (
	order_id NVARCHAR(50),
	payment_sequential INT,
	payment_type NVARCHAR(50),
	payment_installments INT,
	payment_value FLOAT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.order_reviews', 'U') IS NOT NULL
    DROP TABLE silver.order_reviews;
GO

CREATE TABLE silver.order_reviews (
	review_id NVARCHAR(50),
	order_id NVARCHAR(50),
	review_score INT,
	review_comment_title NVARCHAR(MAX),
	review_comment_message NVARCHAR(MAX),
	review_creation_date DATETIME,
	review_answer_timestamp DATETIME,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.orders', 'U') IS NOT NULL
    DROP TABLE silver.orders;
GO

CREATE TABLE silver.orders (
	order_id NVARCHAR(50),
	customer_unique_id NVARCHAR(50),  -- Replace this with customer unique id since customer id was redundant
	order_status NVARCHAR(50),
	order_purchase_timestamp DATETIME,
	order_approved_at DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.products', 'U') IS NOT NULL
    DROP TABLE silver.products;
GO

CREATE TABLE silver.products (
	product_id NVARCHAR(50),
	product_category_name NVARCHAR(50),
	product_name_length INT,			    -- Changed the column name to 'length' instead of 'lenght'
	product_description_length INT,		-- Changed the column name to 'length' instead of 'lenght'
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.sellers', 'U') IS NOT NULL
    DROP TABLE silver.sellers;
GO

CREATE TABLE silver.sellers (
	seller_id NVARCHAR(50),
	seller_zip_code_prefix NVARCHAR(50),
	seller_city NVARCHAR(50),
	seller_state NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('silver.product_category_name_translation', 'U') IS NOT NULL
    DROP TABLE silver.product_category_name_translation;
GO

CREATE TABLE silver.product_category_name_translation (
	product_category_name NVARCHAR(50),
	product_category_name_english NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO
