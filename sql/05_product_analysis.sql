
-- PRODUCT CATEGORY PERFORMANCE ANALYSIS 

USE retail_customer


-- Q1. Which product category contributes the most to overall sales ?

SELECT 
	product_category,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY product_category
ORDER BY total_sales DESC;


-- Q2. How does customer purchasing activity differ across product categories ?

SELECT 
	product_category,
	COUNT(transaction_id) AS total_transactions,
	COUNT(DISTINCT customer_id) AS unique_customers
FROM purchase
GROUP BY product_category
ORDER BY 
	total_transactions DESC, 
	unique_customers DESC;



-- Q3. Are there product categories where the difference between gross sales and net sales is particulary significant ?


WITH sale_diff AS
(
	SELECT 
		product_category,
		SUM(gross_amount) AS gross_sales,
		SUM(net_amount) AS net_sales,
		sales_difference = SUM(gross_amount) - SUM(net_amount)
	FROM purchase
	GROUP BY product_category
)
SELECT *
FROM sale_diff
WHERE sales_difference > 1500000;



-- Q4. Which product categories should management pay closer attention to based on their sales and 
--     transaction performance ?


SELECT 
	product_category,
	COUNT(transaction_id) AS total_transactions,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY product_category
ORDER BY 
	total_transactions ASC,
	total_sales ASC;



