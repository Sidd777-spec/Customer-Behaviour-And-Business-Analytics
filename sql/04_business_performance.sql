
-- BUSINESS PERFORMANCE 

USE retail_customer;



-- Q1.What is the overall sales performance of the business based on gross sales, 
-- net sales, and number of transactions?


SELECT
	COUNT(transaction_id) AS total_transactions,
	SUM(gross_amount) AS gross_sales,
	SUM(net_amount) AS net_sales
FROM purchase;



-- Q2.How does the business's sales performance change over time ?

SELECT 
	YEAR(purchase_date) AS year,
	SUM(gross_amount) AS gross_sales,
	SUM(net_amount) AS net_sales
FROM purchase
GROUP BY YEAR(purchase_date)
ORDER BY year ASC;

-- Supporting analysis: Checking the latest available date in 2024
SELECT MAX(purchase_date)
FROM purchase
WHERE YEAR(purchase_date) = 2024;




-- Q3. Which year generates the highest and lowest sales ?

SELECT
	YEAR(purchase_date) AS year,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY YEAR(purchase_date)
ORDER BY total_sales DESC;

