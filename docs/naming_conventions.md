# **Naming Conventions**

This document outlines the naming conventions used for schemas, tables, views, columns, and other objects in the data warehouse.

## **Table of Contents**

1. [General Principles](#general-principles)
2. [Table Naming Conventions](#table-naming-conventions)
   - [Bronze Rules](#bronze-rules)
   - [Silver Rules](#silver-rules)
   - [Gold Rules](#gold-rules)
3. [Column Naming Conventions](#column-naming-conventions)
   - [Surrogate Keys](#surrogate-keys)
   - [Technical Columns](#technical-columns)
4. [Stored Procedure](#stored-procedure-naming-conventions)
5. [Data Definition Language (DDL)](#data-definition-language-ddl)
---

## **General Principles**

- **Naming Conventions**: Use snake_case, with lowercase letters and underscores (`_`) to separate words.
- **Language**: Use English for all names.
- **Avoid Reserved Words**: Do not use SQL reserved words as object names.

## **Table Naming Conventions**

### **Bronze Rules**
- All table names must match their original names, while removing "dataset" as part of their name.
- **`entity_datset`**  
  - `<entity>`: Exact table name from the Olist datasets.  
  - Example: `olist_customers_dataset` → `olist_customers`, Customer information from the Olist datasets.

### **Silver Rules**
- All table names must match their original names, while removing "dataset" as part of their name.
- **`entity_datset`**  
  - `<entity>`: Exact table name from the Olist datasets.  
  - Example: `olist_customers_dataset` → `olist_customers`, Customer information from the Olist datasets.

### **Gold Rules**
- All names must use meaningful, business-aligned names for tables, starting with the category prefix.
- **`<category>_<entity>`**  
  - `<category>`: Describes the role of the table, such as `dim` (dimension) or `fact` (fact table).  
  - `<entity>`: Descriptive name of the table, aligned with the business domain (e.g., `customers`, `sellers`, `orders`).  
  - Examples:
    - `dim_customers` → Dimension table for customer data.  
    - `fact_orders` → Fact table containing orders transactions.  

#### **Glossary of Category Patterns**

| Pattern     | Meaning                           | Example(s)                              |
|-------------|-----------------------------------|-----------------------------------------|
| `dim_`      | Dimension table                  | `dim_customer`, `dim_sellers`           |
| `fact_`     | Fact table                       | `fact_orders`                            |

## **Column Naming Conventions**

### **Surrogate Keys**  
- All primary keys in dimension tables must use the suffix `_key`.
- **`<table_name>_key`**  
  - `<table_name>`: Refers to the name of the table or entity the key belongs to.  
  - `_key`: A suffix indicating that this column is a surrogate key.  
  - Example: `customer_key` → Surrogate key in the `dim_customers` table.
  
### **Technical Columns**
- All technical columns must start with the prefix `dwh_`, followed by a descriptive name indicating the column's purpose.
- **`dwh_<column_name>`**  
  - `dwh`: Prefix exclusively for system-generated metadata.  
  - `<column_name>`: Descriptive name indicating the column's purpose.  
  - Example: `dwh_load_date` → System-generated column used to store the date when the record was loaded.
 
## **Stored Procedure**

- All stored procedures used for loading data must follow the naming pattern:
- **`load_<layer>`**.
  
  - `<layer>`: Represents the layer being loaded, such as `bronze`, `silver`, or `gold`.
  - Example: 
    - `load_bronze` → Stored procedure for loading data into the Bronze layer.
    - `load_silver` → Stored procedure for loading data into the Silver layer.

## **Data Definition Language (DDL)** 

These are the SQL scripts for creating tables in the Bronze, Silver or Gold schemas/layers

- All stored procedures used for loading data must follow the naming pattern:
- **`ddl_<layer>`**.
  
  - `<layer>`: Represents the layer being loaded, such as `bronze`, `silver`, or `gold`.
  - Example: 
    - `ddl_bronze` → This script creates tables in the 'bronze' schema.
    - `ddl_silver` → This script creates tables in the 'silver' schema.
