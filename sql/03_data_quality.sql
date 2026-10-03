
-- DATA CLEANING & QUALITY ASSURANCE 

USE retail_customer;

SELECT * FROM purchase;


-- Duplicate Primary Key Values --

SELECT
	transaction_id,
	COUNT(*) AS duplicate_count
FROM purchase
GROUP BY transaction_id
HAVING COUNT(*) > 1;



-- NULL Values --

SELECT *
FROM purchase
WHERE customer_id IS NULL;

SELECT *
FROM purchase
WHERE gender IS NULL;

SELECT *
FROM purchase
WHERE age_group IS NULL;

SELECT *
FROM purchase
WHERE gross_amount IS NULL;

SELECT *
FROM purchase
WHERE net_amount IS NULL;

SELECT *
FROM purchase
WHERE purchase_date IS NULL;

SELECT *
FROM purchase
WHERE product_category IS NULL;

SELECT *
FROM purchase
WHERE discount_availed IS NULL;

SELECT *
FROM purchase
WHERE purchase_method IS NULL;

SELECT *
FROM purchase
WHERE location IS NULL;



-- Invalid Values 


-- The discount_name column contains 27585 empty strings ('').

SELECT
	discount_name,
	COUNT(*) AS empty_strings
FROM purchase
WHERE discount_name = ''
GROUP BY discount_name;


-- Therefore converting empty strings into NULL values.

UPDATE purchase
SET discount_name = NULL
WHERE discount_name = '';


-- All empty strings are converted into NULL.

SELECT * 
FROM purchase
WHERE discount_name = '';


-- Checking For Invalid Dates

SELECT 
	MIN(purchase_date) AS first_date_of_purchase, -- '2019-09-19 11:46:07'
	MAX(purchase_date) AS last_date_of_purchase   -- '2024-09-18 16:00:08'
FROM purchase;

SELECT * 
FROM purchase
WHERE purchase_date < '2019-09-19 11:46:07'
OR purchase_date > '2024-09-18 16:00:08';


-- Inconsistent Data 

SELECT 
	product_category,
	COUNT(*) AS total_products
FROM purchase
GROUP BY product_category;


SELECT 
	purchase_method
FROM purchase
GROUP BY purchase_method;



-- Negative Quantities (discout_amount, gross_amount, net_amount)

SELECT *
FROM purchase
WHERE discount_amount < 0;

SELECT *
FROM purchase
WHERE gross_amount < 0;

SELECT *
FROM purchase
WHERE net_amount < 0;



-------- FINDING :

-- == ANOMALY : 


-- == There are 606 products where the net_amount is in (-ve) Negative.

-- == Reason : The discount_amount given for those 606 products is greater than the product's  gross_amount,
--             resulting in (-ve) Negative net_amount, thus leading to (-ve) sales and loss.

SELECT *
FROM purchase
WHERE net_amount < 0;



-- == ANOMALY #2 : I've figured that there are some calculation discrepancies / mismatches between 
--				   stored net_amount AND our calculated_net_amount.

SELECT
	transaction_id,
	discount_availed,
	gross_amount,
	discount_amount,
	net_amount,
	calculated_net_amount = gross_amount - discount_amount
FROM purchase
WHERE net_amount < 0
AND discount_availed = 'Yes';



-- Documenting Negative Net Amounts & Calculation Discrepancies .


SELECT 
	transaction_id,
	discount_availed,
	gross_amount,
	discount_amount,
	net_amount,
	calculated_net_amount = gross_amount - discount_amount,
	calculation_difference = (gross_amount - discount_amount) - net_amount,
	status = 
			CASE
				WHEN (gross_amount - discount_amount) != net_amount
				THEN 'Calculation Discrepancy'
				ELSE 'No Discrepancy'
			END 
FROM purchase
WHERE net_amount < 0
AND discount_availed = 'Yes';



-- =====================================================
-- Customer ID Consistency Check
-- =====================================================

-- The dataset documentation describes CID (Customer ID) as a unique identifier for each customer.

-- During data validation, repeated customer_id values were found across multiple transactions. Some repeated IDs
-- were also associated with different gender, age_group,and location values.

-- Therefore, customer_id is not treated as a primary key and customer-level analysis using customer_id should be
-- interpreted with caution.

-- transaction_id was checked for uniqueness and found to be unique across the dataset, so it is used as the
-- primary key for the purchase table.