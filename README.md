# Olist Brazilian E-Commerce Data Warehouse Project
Let's goo! This is a data engineering project that demonstrates a comprehensive data warehousing solution, involving the building of a data warehouse that will help data analysts with finding actionable insights in data. The data used for this project comes from the Brazilian E-Commerce store, "Olist".

---

## Data Architecture

The data architecture for this project follows Medallion Architecture **Bronze**, **Silver**, and **Gold** layers:
![Data Architecture](docs/Data_Architecture.png)

1. **Bronze Layer**: Stores raw data as-is from the source systems. Data is ingested from CSV Files into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.

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

## 🛡️ License & Acknowledgments

This project is licensed under the [MIT License](LICENSE). 

## 🌟 About Me

Hi there! I'm **Molo Munyansanga**. I’m an IT professional and passionate data enthusiast who loves working with data.

Let's stay in touch! Feel free to connect with me on: 

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/molomunyansanga/)
