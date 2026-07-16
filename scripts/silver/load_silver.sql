/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'silver' schema from external CSV files. 
    It performs the following actions:
    - Truncates the silver tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to silver tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
===============================================================================
*/
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	-- Define variables for figuring out time of data loading --
	DECLARE @silver_start_time DATETIME, @start_time DATETIME, @end_time DATETIME;

	BEGIN TRY
		-- Figure out the starting time for loading the whole silver layer --
		SET @silver_start_time = GETDATE();

		PRINT '================================'
		PRINT 'Loading silver Layer'
		PRINT '================================'


		PRINT '--------------------------------'
		PRINT 'Loading Olist Tables'
		PRINT '--------------------------------'

		-- 1) Loading the silver.customers table
		SET @start_time = GETDATE();
		PRINT '1) Truncating Table: silver.customers'
		TRUNCATE TABLE silver.customers;
	
		PRINT 'Inserting Data Into: silver.customers'
		INSERT INTO silver.customers(
					customer_unique_id, 
					customer_zip_code_prefix, 
					customer_city, 
					customer_state
				)
		SELECT
			customer_unique_id,
			customer_zip_code_prefix,
			customer_city,
			customer_state
		FROM (
			SELECT *,
			ROW_NUMBER() OVER (PARTITION BY customer_unique_id ORDER BY customer_id DESC) as flag
			FROM bronze.customers
		) t
		WHERE flag = 1
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 2) Loading the silver.orders table
		SET @start_time = GETDATE();
		PRINT '2) Truncating Table: silver.orders'
		TRUNCATE TABLE silver.orders;

		PRINT 'Inserting Data Into: silver.orders'
		INSERT INTO silver.orders (
			order_id,
			customer_unique_id,
			order_status,
			order_purchase_timestamp,
			order_approved_at,
			order_delivered_carrier_date,
			order_delivered_customer_date,
			order_estimated_delivery_date
		)
		SELECT 
			o.order_id,
			c.customer_unique_id, -- We swap customer_id for the true unique ID here. (Having both customer_id and customer_unique_id as identifiers is redundant)
			o.order_status,
			o.order_purchase_timestamp,
			o.order_approved_at,
			o.order_delivered_carrier_date,
			o.order_delivered_customer_date,
			o.order_estimated_delivery_date
		FROM bronze.orders o
		INNER JOIN bronze.customers c 
			ON o.customer_id = c.customer_id
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 3) Loading the silver.order_payments table
		SET @start_time = GETDATE();
		PRINT '3) Truncating Table: silver.order_payments'
		TRUNCATE TABLE silver.order_payments;

		PRINT 'Inserting Data Into: silver.order_payments'
		INSERT INTO silver.order_payments (
			order_id,
			payment_sequential,
			payment_type,
			payment_installments,
			payment_value
		)
		SELECT
			order_id,
			payment_sequential,
			CASE
				WHEN payment_type = 'not_defined' THEN 'n/a'
				ELSE payment_type
			END AS payment_type,		-- Transform payment type of 'not_defined' to 'n/a'
			payment_installments,
			payment_value
		FROM bronze.order_payments
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 4) Loading the silver.order_reviews table
		SET @start_time = GETDATE();
		PRINT '4) Truncating Table: silver.order_reviews'
		TRUNCATE TABLE silver.order_reviews;

		PRINT 'Inserting Data Into: silver.order_reviews'
		INSERT INTO silver.order_reviews (
			  review_id,
			  order_id,
			  review_score,
			  review_comment_title,
			  review_comment_message,
			  review_creation_date,
			  review_answer_timestamp
		)
		SELECT
			  review_id,
			  order_id,
			  review_score,
			  review_comment_title,
			  review_comment_message,
			  review_creation_date,
			  review_answer_timestamp
		  FROM bronze.order_reviews
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 5) Loading the silver.order_items table
		SET @start_time = GETDATE();
		PRINT '5) Truncating Table: silver.order_items'
		TRUNCATE TABLE silver.order_items;

		PRINT 'Inserting Data Into: silver.order_items'
		INSERT INTO silver.order_items (
		  order_id,
		  order_item_id,
		  product_id,
		  seller_id,
		  shipping_limit_date,
		  price,
		  freight_value
		)
		SELECT
		  order_id,
		  order_item_id,
		  product_id,
		  seller_id,
		  shipping_limit_date,
		  price,
		  freight_value
		FROM bronze.order_items
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 6) Loading the silver.geolocation table
		SET @start_time = GETDATE();
		PRINT '6) Truncating Table: silver.geolocation'
		TRUNCATE TABLE silver.geolocation;

		PRINT 'Inserting Data Into: silver.geolocation'
		INSERT INTO silver.geolocation(
			geolocation_zip_code_prefix,
			geolocation_lat,
			geolocation_lng,
			geolocation_city,
			geolocation_state
		)
		SELECT
			geolocation_zip_code_prefix,
			geolocation_lat,
			geolocation_lng,
			geolocation_city,
			geolocation_state
		FROM bronze.geolocation
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 7) Loading into the silver.product_category_name_translation table
		SET @start_time = GETDATE();
		PRINT '7) Truncating Table: silver.product_category_name_translation'
		TRUNCATE TABLE silver.product_category_name_translation;

		PRINT 'Inserting Data Into: silver.product_category_name_translation'
		INSERT INTO silver.product_category_name_translation(
			product_category_name,
			product_category_name_english
		)
		SELECT
			product_category_name,
			product_category_name_english
		FROM bronze.product_category_name_translation
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 8) Loading the silver.products table
		SET @start_time = GETDATE();
		PRINT '8) Truncating Table: silver.products'
		TRUNCATE TABLE silver.products;

		PRINT 'Inserting Data Into: silver.products'
		INSERT INTO silver.products (
		  product_id,
		  product_category_name,
		  product_name_length,
		  product_description_length,
		  product_photos_qty,
		  product_weight_g,
		  product_length_cm,
		  product_height_cm,
		  product_width_cm
		)
		SELECT
		  product_id,
		  CASE
			WHEN product_category_name IS NULL THEN 'n/a'
			ELSE product_category_name
			END AS product_category_name,		-- Replace NULLs with 'n/a'
		  product_name_lenght AS product_name_length,						-- Column name was corrected
		  product_description_lenght AS product_description_length,			-- Column name was corrected
		  product_photos_qty,
		  product_weight_g,
		  product_length_cm,
		  product_height_cm,
		  product_width_cm
		FROM bronze.products
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 9) Loading the silver.sellers table
		SET @start_time = GETDATE();
		PRINT '9) Truncating Table: silver.sellers'
		TRUNCATE TABLE silver.sellers;

		PRINT 'Inserting Data Into: silver.sellers'
		INSERT INTO silver.sellers (
			seller_id,
			seller_zip_code_prefix,
			seller_city,
			seller_state
		)
		SELECT
			seller_id,
			seller_zip_code_prefix,
			seller_city,
			seller_state
		FROM bronze.sellers
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';
		
		-- END: Calculate loading time for whole silver layer --
		SET @end_time = GETDATE();
		PRINT '>> Load Duration for Whole silver Layer: ' + CAST(DATEDIFF(second, @silver_start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

	END TRY
	-- Catch errors --
	BEGIN CATCH
		PRINT '================================='
		PRINT 'ERROR OCCURED DURING LOADING silver LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '================================='
	END CATCH
END
