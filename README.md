# Olist Brazilian E-Commerce Data Warehouse Project
Let's goo! This is a data engineering project that demonstrates a comprehensive data warehousing solution, involving the building of a data warehouse that will help data analysts with finding actionable insights in data. The data used for this project comes from the Brazilian E-Commerce store, "Olist".

---

## Project Requirements

### Building the Data Warehouse (Data Engineering)

#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales and orders data, enabling analytical reporting and informed decision-making.

#### Specifications
- **Data Sources**: Import data from Kaggle's [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data) provided as CSV files.
- **Data Quality**: Cleanse and resolve data quality issues prior to analysis.
- **Integration**: Create a single, user-friendly data model designed for analytical queries.
- **Scope**: Focus on the latest dataset only; historization of data is not required.
- **Documentation**: Provide clear documentation of the data model to support both business stakeholders and analytics teams.

#### Naming Conventions
Specific naming conventions have been followed in order to standardize file and table names. More details are provided [here](docs/naming_conventions.md).

---

## Data Architecture

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
![Data Architecture](docs/Data_Architecture.png)

## 1. **Bronze Layer**

Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database. You can veiw the SQL scripts [here](/scripts/bronze).

Since this is the bronze layer, the CSV datasets were loaded directly into the Bronze layer:
![Data Flow Diagram](docs/Data_Flow_Diagram.png)

## 2. **Silver Layer** 

This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis. You can veiw the SQL scripts [here](/scripts/silver).

As part of the data cleaning process a redundant column was dropped, some column names were corrected, and some values with NULLs were addressed. Data quality checks were also carried out [here](/tests/data_quality_check_silver.sql) to make sure that the tables in the Silver layer were okay.

![Data Integration Model](docs/Data_Integration_Model.png)


## 3. **Gold Layer**

Houses business-ready data modeled into a galaxy schema required for reporting and analytics.

 The tables in the Silver layer were finally transformed into analysis-ready dimension and fact tables. Data quality checks were also carried out [here](/tests/data_quality_check_gold.sql) to make sure that the tables in the Gold layer were okay.

![Data Model](docs/Data_Model.png)

---

## 📂 Repository Structure
```
Olist-Brazilian-E-Commerce-Data-Warehouse-Project/
│
├── datasets/                           # Raw datasets used for the project
│
├── docs/                               # Project documentation and architecture details
│   ├── Data_Architecture               # Draw.io file shows the project's architecture
│   ├── data_catalog.md                 # Catalog of datasets, including field descriptions and metadata
│   ├── Data_Flow_Diagram               # Draw.io file for the data flow diagram
│   ├── Data_Model                      # Draw.io file for data models (galaxy schema)
│   ├── naming-conventions.md           # Consistent naming guidelines for tables, columns, and files
│
├── scripts/                            # SQL scripts for ETL and transformations
│   ├── bronze/                         # Scripts for extracting and loading raw data
│   ├── silver/                         # Scripts for cleaning and transforming data
│   ├── gold/                           # Scripts for creating analytical models
│
├── tests/                              # Test scripts and quality files
│
├── README.md                           # Project overview and instructions
├── LICENSE                             # License information for the repository
```
---

## License & Acknowledgments

This project is licensed under the [MIT License](LICENSE). 

## About Me

Hi there! I'm **Molo Munyansanga**. I’m an IT professional and passionate data enthusiast who loves working with data.

Let's stay in touch! Feel free to connect with me on: 

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/molomunyansanga/)
