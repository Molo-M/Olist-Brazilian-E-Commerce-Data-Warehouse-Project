# Data Catalog for Gold Layer

## Overview
The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.

---

### 1. **gold.dim_customers**
- **Purpose:** Stores customer details enriched with demographic and geographic data. It has been joined with geographic data to allow for geographical mapping and analysis.
- **Columns:**

| Column Name      | Data Type     | Description                                                                                   |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| customer_unique_id     | NVARCHAR(50)           | Key uniquely identifying each customer record in the dimension table.               |
| customer_zip_code_prefix      | NVARCHAR(50)           | First five digits of customer zip code                                        |
| customer_city  | NVARCHAR(50)  | Customer city name         |
| customer_state       | NVARCHAR(50)  | Customer state name                                      |
| geolocation_lat        | INT  | Latitude coordinates                                               |
| geolocation_lng      | INT          | Longitude coordinates|

---

### 2. **gold.dim_products**
- **Purpose:** Provides information about the products and their attributes.
- **Columns:**

| Column Name         | Data Type     | Description                                                                                   |
|---------------------|---------------|-----------------------------------------------------------------------------------------------|
| product_id         | NVARCHAR(50)           | Key uniquely identifying each product record in the products dimension table.         |
| product_category_name          | NVARCHAR(50)           | Root category name of product, in Portuguese.            |
| product_category_name_english      | NVARCHAR(50)  | Translation of category name of product, in English.  |
| product_name_length        | INT  | number of characters extracted from the product name.|
| product_description_length         | INT  | number of characters extracted from the product description.|
| product_photos_qty            | INT)  | number of product published photos.|
| product_weight_g         | INT  | product weight measured in grams.|
| product_length_cm| INT  | product length measured in centimeters.|
| product_height_cm                | INT          | product height measured in centimeters.|
| product_width_cm        | INT  | product width measured in centimeters.|

---


### 3. **gold.dim_sellers**
- **Purpose:** Provides information about the sellers that fulfilled orders made at Olist. It has been joined with geographic data to allow for geographical mapping and analysis.
- **Columns:**

| Column Name         | Data Type     | Description                                                                                   |
|---------------------|---------------|-----------------------------------------------------------------------------------------------|
| seller_id         | NVARCHAR(50)           | Key uniquely identifying each seller record in the sellers dimension table.         |
| seller_zip_code_prefix          | NVARCHAR(50)           | first 5 digits of seller zip code            |
| seller_city      | NVARCHAR(50)  | seller city name.|
| seller_state        | NVARCHAR(50)  | seller state.|
| geolocation_lat         | INT  | Latitude|
| geolocation_lng            | INT  | Longitude|

---

### 4. **gold.fact_sales_items**
- **Purpose:** Stores the sales information of every item in an order. One order sometimes contains more than one item.
- **Structure:** The table was created by joining the ``orders`` and the ``order_items`` tables from the silver layer.
- **Columns:**

| Column Name     | Data Type     | Description                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| sales_item_id    | INT  | A surogate alphanumeric identifier for each sales item.                      |
| order_id    | NVARCHAR(50)  | Key uniquely identifying each order record. Note: One order can have multiple items                    |
| order_item_id     | NVARCHAR(50)           | sequential number identifying number of items included in the same order.|
| customer_unique_id     | NVARCHAR(50)           | key linking the order to the customer dimension table.                               |
| product_id     | NVARCHAR(50)           | key linking the order to the product dimension table.                               |
| seller_id    | NVARCHAR(50)           | key linking the order to the seller dimension table.                              |
| price      | FLOAT          | item price                                                        |
| freight_value   | FLOAT          | item freight value item (if an order has more than one item the freight value is splitted between items)       |
| order_status        | NVARCHAR(50)          | Reference to the order status (delivered, shipped, etc).                                                      |
| order_purchase_timestamp    | DATETIME           | Shows the purchase timestamp.   |
| order_approved_at        | DATETIME           | Shows the payment approval timestamp.|
| order_delivered_carrier_date           | DATETIME           | Shows the order posting timestamp. When it was handled to the logistic partner.      |
| order_delivered_customer_date           | DATETIME           | Shows the actual order delivery date to the customer.      |
| order_estimated_delivery_date           | DATETIME           | Shows the estimated delivery date that was informed to customer at the purchase moment.      |
| shipping_limit_date           | DATETIME           | Shows the seller shipping limit date for handling the order over to the logistic partner.      |


---

### 5. **gold.fact_order_payments**
- **Purpose:** Stores payment information for each order.
- **Structure:** The table was created by joining the ``orders`` and the ``order_payments`` tables from the silver layer.
- **Columns:**

| Column Name     | Data Type     | Description                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| order_payment_id    | INT  | A surogate alphanumeric identifier for each order payment                    |
| payment_sequential     | INT           | a customer may pay an order with more than one payment method. If he does so, a sequence will be created for every payment   |
| customer_unique_id     | NVARCHAR(50)           | key linking the order to the customer dimension table.                               |
| order_status        | NVARCHAR(50)          | Reference to the order status (delivered, shipped, etc).                                                      |
| payment_type    | NVARCHAR(50           | method of payment chosen by the customer.                        |
| payment_installments      | INT          | number of installments chosen by the customer.                                                         |
| payment_value   | FLOAT          | transaction value.         |
| order_purchase_timestamp    | DATETIME           | Shows the purchase timestamp.   |

---

### 6. **gold.fact_order_reviews**
- **Purpose:** Stores reviews made by customers after making an order. After a customer purchases the product from Olist Store a seller gets notified to fulfill that order. Once the customer receives the product, or the estimated delivery date is due, the customer gets a satisfaction survey by email where he can give a note for the purchase experience and write down some comments.
- **Structure:** The table was created by joining the ``orders`` and the ``order_reviews`` tables from the silver layer.
- **Columns:**

| Column Name     | Data Type     | Description                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| order_review_id    | INT  | A surogate alphanumeric identifier for each order review                    |
| review_id     | NVARCHAR(50)           | Key identifying each review.|
| customer_unique_id     | NVARCHAR(50)           | key linking the order to the customer dimension table.                               |
| order_status        | NVARCHAR(50)          | Reference to the order status (delivered, shipped, etc).                                                      |
| order_purchase_timestamp    | DATETIME           | Shows the purchase timestamp.   |
| review_score     | INT           | Note ranging from 1 to 5 given by the customer on a satisfaction survey.   |
| review_comment_title     | NVARCHAR(MAX)         | Comment title from the review left by the customer, in Portuguese.                               |
| review_comment_message        | NVARCHAR(MAX)          | Comment message from the review left by the customer, in Portuguese.                                      |
| review_creation_date    | DATETIME          | Shows the date in which the satisfaction survey was sent to the customer.     |
| review_answer_timestamp      | DATETIME          | Shows satisfaction survey answer timestamp.                                       |
