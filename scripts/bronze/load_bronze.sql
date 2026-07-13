/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	-- Define variables for figuring out time of data loading --
	DECLARE @bronze_start_time DATETIME, @start_time DATETIME, @end_time DATETIME;

	BEGIN TRY
		-- Figure out the starting time for loading the whole bronze layer --
		SET @bronze_start_time = GETDATE();

		PRINT '================================'
		PRINT 'Loading Bronze Layer'
		PRINT '================================'


		PRINT '--------------------------------'
		PRINT 'Loading Olist Tables'
		PRINT '--------------------------------'
		
		-- 1) Load data from olist_customers_dataset.csv --
		SET @start_time = GETDATE();
		PRINT '1) Truncating Table: bronze.customers'
		TRUNCATE TABLE bronze.customers;
	
		PRINT 'Inserting Data Into: bronze.customers'
		BULK INSERT bronze.customers
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\olist_customers_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';


		-- 2) Load data from olist_geolocation_dataset.csv --
		SET @start_time = GETDATE();
		PRINT '2) Truncating Table: bronze.geolocation'
		TRUNCATE TABLE bronze.geolocation;

		PRINT 'Inserting Data Into: bronze.geolocation'
		BULK INSERT bronze.geolocation
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\olist_geolocation_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';


		-- 3) Load data from olist_order_items_dataset.csv --
		SET @start_time = GETDATE();
		PRINT '3) Truncating Table: bronze.order_items'
		TRUNCATE TABLE bronze.order_items;

		PRINT 'Inserting Data Into: bronze.order_items'
		BULK INSERT bronze.order_items
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\olist_order_items_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 4) Load data from olist_order_payments_dataset.csv --
		SET @start_time = GETDATE();
		PRINT '4) Truncating Table: bronze.order_payments'
		TRUNCATE TABLE bronze.order_payments;

		PRINT 'Inserting Data Into: bronze.order_payments'
		BULK INSERT bronze.order_payments
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\olist_order_payments_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- 5) Load data from olist_order_reviews_dataset.csv --
		SET @start_time = GETDATE();
		PRINT '5) Truncating Table: bronze.order_reviews'
		TRUNCATE TABLE bronze.order_reviews;

		PRINT 'Inserting Data Into: bronze.order_reviews'
		BULK INSERT bronze.order_reviews
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\olist_order_reviews_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDQUOTE = '"',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',   -- Signals the absolute end of a complete data row
			CODEPAGE = '65001',     -- UTF-8 encoding (Crucial for Portuguese text)
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';
		
		-- 6) Load data from olist_orders_dataset.csv --
		SET @start_time = GETDATE();
		PRINT '6) Truncating Table: bronze.orders'
		TRUNCATE TABLE bronze.orders;

		PRINT 'Inserting Data Into: bronze.orders'
		BULK INSERT bronze.orders
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\olist_orders_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';
		
		-- 7) Load data from olist_products_dataset.csv --
		SET @start_time = GETDATE();
		PRINT '7) Truncating Table: bronze.products'
		TRUNCATE TABLE bronze.products;

		PRINT 'Inserting Data Into: bronze.products'
		BULK INSERT bronze.products
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\olist_products_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';
		
		-- 8) Load data from olist_sellers_dataset.csv --
		SET @start_time = GETDATE();
		PRINT '8) Truncating Table: bronze.sellers'
		TRUNCATE TABLE bronze.sellers;

		PRINT 'Inserting Data Into: bronze.sellers'
		BULK INSERT bronze.sellers
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\olist_sellers_dataset.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';
		
		-- 9) Load data from product_category_name_translation.csv --
		SET @start_time = GETDATE();
		PRINT '9) Truncating Table: bronze.product_category_name_translation'
		TRUNCATE TABLE bronze.product_category_name_translation;

		PRINT 'Inserting Data Into: bronze.product_category_name_translation'
		BULK INSERT bronze.product_category_name_translation
		FROM 'C:\Users\GADGET STORE\Downloads\Data Engineering Course\Olist Brazilian E-Commerce Datawarehouse Project\datasets\product_category_name_translation.csv'
		WITH (
			FORMAT = 'CSV',
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0A',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

		-- Calculate loading time for whole bronze layer --
		SET @end_time = GETDATE();
		PRINT '>> Load Duration for Whole Bronze Layer: ' + CAST(DATEDIFF(second, @bronze_start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------';

	END TRY
	-- Catch errors --
	BEGIN CATCH
		PRINT '================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '================================='
	END CATCH
END