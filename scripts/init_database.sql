/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'Olist_DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'Olist_DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- Enter "master" database in order to create our desired database
USE master;
GO

-- Drop and recreate the 'Olist_DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'Olist_DataWarehouse')
BEGIN
    ALTER DATABASE Olist_DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Olist_DataWarehouse;
END;
GO

-- Create Database 'Olist_DataWarehouse'
CREATE DATABASE Olist_DataWarehouse;
GO

-- Enter Database
USE Olist_DataWarehouse;
GO

-- Create the schemas/layers
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
