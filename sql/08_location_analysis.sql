
-- LOCATION ANALYSIS 

USE retail_customer;


-- Q.1 How does the sales performance vary across locations ?

SELECT 
	location,
	SUM(net_amount) AS total_net_sales
FROM purchase
GROUP BY location
ORDER BY total_net_sales DESC;



-- Q.2 Which locations contribute the most to overall sales ?

SELECT 
	location,
	SUM(net_amount) AS total_net_sales,
	CAST(
		SUM(net_amount) * 100.0
		/
		SUM(SUM(net_amount)) OVER() AS DECIMAL(10,2)
	) AS overall_contribution
FROM purchase
GROUP BY location 
ORDER BY overall_contribution DESC;



-- Q.3 Are there locations with high transaction activity but comparatively lower sales ?


-- Comparing total_transactions Vs total_sales

WITH CTE AS 
(
	SELECT 
		location,
		COUNT(transaction_id) AS total_transactions,
		RANK() OVER
		(
			ORDER BY COUNT(transaction_id) DESC
		) AS transaction_rnk,
		SUM(net_amount) AS total_sales,
		RANK() OVER
		(
			ORDER BY SUM(net_amount) DESC
		) AS sales_rnk
	FROM purchase
	GROUP BY location
)
SELECT 
	location,
	total_transactions,
	transaction_rnk,
	total_sales,
	sales_rnk
FROM CTE
WHERE transaction_rnk != sales_rnk;



-- Q.4 Does discount usage differ across locations ?


WITH total_transc_by_location AS
(
	SELECT 
		location,
		COUNT(transaction_id) AS total_transactions
	FROM purchase
	GROUP BY location
)
,
discounted_transc_by_location AS
(
	SELECT 
		location,
		COUNT(transaction_id) AS discounted_transactions
	FROM purchase
	WHERE discount_availed = 'Yes'
	GROUP BY location
)
SELECT 
	dt.location,
	tt.total_transactions,
	dt.discounted_transactions,
	CAST
	(
		(dt.discounted_transactions * 100.0) 
		/
		tt.total_transactions
		AS DECIMAL(10,2)
	) AS discount_usage
FROM total_transc_by_location AS tt
INNER JOIN discounted_transc_by_location AS dt
ON tt.location = dt.location
ORDER BY discount_usage DESC;



 
