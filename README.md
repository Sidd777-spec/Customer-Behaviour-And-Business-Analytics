

# Retail Sales Business Analysis



## Project Overview

This project analyzes retail transaction data using **SQL Server** to identify sales patterns, customer behavior, 
discount usage, payment-method trends, and product and location performance.

The analysis focuses on transforming raw transaction data into structured business findings and actionable 
recommendations.



## Business Objective

The objective of this project is to:

* Analyze overall sales and transaction performance.
* Identify high-performing product categories and customer segments.
* Understand purchasing behavior across different customer dimensions.
* Analyze discount usage and its relationship with transaction value.
* Compare sales and transaction contribution across locations and purchase methods.
* Identify data-quality issues that may affect analysis.
* Translate analytical findings into business recommendations.




## Dataset

The dataset contains retail purchase transactions with the following key fields:

* `transaction_id` | Unique transaction identifier | 
* `customer_id` | Customer identifier |
* `gender` | Customer gender |
* `age_group` | Customer age segment |
* `purchase_date` | Date when the transaction was done |
* `product_category` | Product category |
* `discount_availed` | Whether a discount was availed |
* `discount_name` | Name of the discount |
* `discount_amount` | Amount that was discounted |
* `gross_amount` | Transaction amount before discount |
* `net_amount` | Transaction amount after discount |
* `purchase_method` | Payment/purchase method |
* `location` | Customer/purchase location |

This raw dataset is stored in the `raw_data` folder.



## Tools & Technologies

* **SQL Server**
* **SQL Server Management Studio (SSMS)**
* **Microsoft Excel** — initial dataset handling
* **Git & GitHub** — project version control and documentation



<div align = "center">

```text
### Project Workflow


**Raw Data**
↓  
**Database Setup**
↓
**Data Import**
↓
**Data Quality Analysis**
↓
**Business Analysis**
↓
**Business Insights**
↓
**Recommendations**
```
</div>


## Data Quality & Preparation

Before performing the business analysis, the dataset was examined for potential data-quality issues, including:

* Duplicate transaction records
* NULL and blank values
* Invalid or inconsistent dates
* Negative net amounts
* Invalid transaction values
* Discount-related calculation inconsistencies
* Inconsistent customer demographic attributes

Data-quality issues were investigated using SQL and documented during the analysis process.

Repeated customer IDs with inconsistent demographic attributes were also identified. Since the available dataset did 
not provide enough information to determine the underlying cause, these records were retained rather than assigning new 
demographic values.




## Business Analysis

The analysis covers multiple business dimensions, including:

* Overall sales performance
* Yearly sales trends
* Product-category performance
* Customer demographics
* Location performance
* Purchase-method behavior
* Discounted vs non-discounted transactions
* Transaction value
* Sales and transaction contribution
* Customer-product combinations

The detailed SQL analysis is available in the `sql` folder.




## Key Business Insights

Some of the key findings from the analysis include:

* The business generated approximately **₹165.68M in gross sales** and **₹158.15M in net sales** across approximately 
55K transactions.
* Net sales increased from **2019 through 2023**, while the available 2024 data only extends through September and 
therefore should not be treated as a complete-year comparison.
* **Electronics and Clothing** accounted for the largest shares of transaction activity and net sales.
* **Female customers aged 25–45 in Mumbai using Credit Card** generated the highest net sales among the combined 
customer segments analyzed.
* Discounted and non-discounted transactions occurred at nearly equal volumes, but **non-discounted transactions 
generated higher net sales and average transaction value**.
* Discount usage was relatively consistent across gender, age group, and purchase method, while greater variation was 
observed across locations.
* **Credit Card and Debit Card** dominated transaction volume and total net sales, while PhonePe UPI and Paytm UPI 
showed slightly higher average transaction values.

Detailed findings are available in [`business_insights.md`](business_insights.md).




## Recommendations

Based on the analysis, the project proposes recommendations around:

1. **Discount Strategy** — review how discounts are targeted and their relationship with transaction value.
2. **Product/Category Focus** — investigate lower-contributing categories and evaluate opportunities to increase their 
demand.
3. **Customer Segment Targeting** — further analyze high-performing customer-product combinations.
4. **Geographic Discount Review** — investigate factors contributing to geographic differences in discount usage.
5. **Payment Method Performance** — investigate the factors associated with differences in average transaction value 
across payment methods.

Detailed recommendations are available in [`business_recommendations.md`](business_recommendations.md).




## Repository Structure

```text
Retail-Sales-Business-Analysis/
│
├── raw_data/
│   └── project1_df.csv
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_database_import.sql
│   ├── 03_data_quality.sql
│   ├── 04_business_analysis.sql
|   ├── 05_product_analysis.sql
|   ├── 06_customer_behaviour_&_segmentation.sql
|   ├── 07_discount_analysis.sql
|   ├── 08_location_analysis.sql
|   ├── 09_purchase_method_analysis.sql
|   └── 10_deep_business_analysis.sql
│
├── business_insights.md
├── business_recommendations.md
└── README.md
```


## Conclusion

This project demonstrates the process of taking raw retail transaction data through **database preparation, 
data-quality investigation, SQL-based business analysis, insight generation, and business recommendations**.

The analysis focuses not only on writing SQL queries, but also on interpreting the results from a business perspective 
and identifying limitations within the underlying data.
