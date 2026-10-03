
-- DEEP BUSINESS ANALYSIS 

USE retail_customer;


-- Q.1 Which combination of customer segment and product category generate the most sales ?


-- Gender X Product Category

SELECT TOP 1
	product_category,
	gender,
	SUM(net_amount) AS total_net_sales  -- Electronics	Other	16157934.00
FROM purchase
GROUP BY 
	product_category,
	gender
ORDER BY total_net_sales DESC;



-- Age Group X Product Category


SELECT TOP 1
	product_category,
	age_group,
	SUM(net_amount) AS total_net_sales  -- Electronics	25-45	19214888.00
FROM purchase
GROUP BY 
	product_category,
	age_group
ORDER BY total_net_sales DESC;



-- Location X Product Category


SELECT TOP 1
	product_category,
	location,
	SUM(net_amount) AS total_net_sales  -- Electronics	Mumbai	9707325.00
FROM purchase
GROUP BY 
	product_category,
	location
ORDER BY total_net_sales DESC;




-- Q.2  Are customers who receive discounts purchasing differently from customers who do not receive discounts ?

-- Purchase Method

-- Discounted --
SELECT 
	purchase_method,
	COUNT(transaction_id) AS discounted_transactions
FROM purchase
WHERE discount_availed = 'Yes'
GROUP BY purchase_method
ORDER BY discounted_transactions DESC;


-- Non-Discounted --
SELECT 
	purchase_method,
	COUNT(transaction_id) AS non_discounted_transactions
FROM purchase
WHERE discount_availed = 'No'
GROUP BY purchase_method
ORDER BY non_discounted_transactions DESC;



-- Product Category 

-- Discounted --
SELECT 
	product_category,
	COUNT(transaction_id) AS discounted_transactions
FROM purchase
WHERE discount_availed = 'Yes'
GROUP BY product_category
ORDER BY discounted_transactions DESC;


-- Non-Discounted --
SELECT 
	product_category,
	COUNT(transaction_id) AS non_discounted_transactions
FROM purchase
WHERE discount_availed = 'No'
GROUP BY product_category
ORDER BY non_discounted_transactions DESC;



-- Age Group 

-- Discounted --
SELECT 
	age_group,
	COUNT(transaction_id) AS discounted_transactions
FROM purchase
WHERE discount_availed = 'Yes'
GROUP BY age_group
ORDER BY discounted_transactions DESC;


-- Non-Discounted --
SELECT 
	age_group,
	COUNT(transaction_id) AS non_discounted_transactions
FROM purchase
WHERE discount_availed = 'No'
GROUP BY age_group
ORDER BY non_discounted_transactions DESC;



-- Gender 

-- Discounted --
SELECT 
	gender,
	COUNT(transaction_id) AS discounted_transactions
FROM purchase
WHERE discount_availed = 'Yes'
GROUP BY gender
ORDER BY discounted_transactions DESC;


-- Non-Discounted --
SELECT 
	gender,
	COUNT(transaction_id) AS non_discounted_transactions
FROM purchase
WHERE discount_availed = 'No'
GROUP BY gender
ORDER BY non_discounted_transactions DESC;



-- Location 

-- Discounted --
SELECT 
	location,
	COUNT(transaction_id) AS discounted_transactions
FROM purchase
WHERE discount_availed = 'Yes'
GROUP BY location
ORDER BY discounted_transactions DESC;


-- Non-Discounted --
SELECT 
	location,
	COUNT(transaction_id) AS non_discounted_transactions
FROM purchase
WHERE discount_availed = 'No'
GROUP BY location
ORDER BY non_discounted_transactions DESC;



-- Transaction Value 

SELECT 
	CASE
		WHEN discount_availed = 'Yes' THEN 'Discounted'
		ELSE 'Non-Discounted'
	END AS discount_status,
	SUM(net_amount) AS total_net_sales,
	COUNT(transaction_id) AS total_transactions,
	CAST(
			SUM(net_amount) / COUNT(transaction_id)
			AS DECIMAL(10,2)
	) AS average_transaction_value
FROM purchase
GROUP BY discount_availed;




-- Q.3 Which areas of the business show a notable gap between transaction volume and sales contribution ?

-- Product Category 

WITH trans_volume AS
(
	SELECT 
		product_category,
		COUNT(transaction_id) AS total_transactions,
		CAST(
			COUNT(transaction_id) * 100.0
			/
			SUM(COUNT(transaction_id)) OVER() 
			AS DECIMAL(10,2)
		) AS transaction_contribution
	FROM purchase
	GROUP BY product_category
),
sales_contr AS 
(
	SELECT 
		product_category,
		SUM(net_amount) AS total_sales,
		CAST(
			SUM(net_amount) * 100.0
			/
			SUM(SUM(net_amount)) OVER () 
			AS DECIMAL(10,2)
		) AS sales_contribution
	FROM purchase
	GROUP BY product_category
)
SELECT 
	t.product_category,
	t.total_transactions,
	t.transaction_contribution,
	s.total_sales,
	s.sales_contribution
FROM trans_volume AS t
INNER JOIN sales_contr AS s
ON t.product_category = s.product_category
ORDER BY s.sales_contribution DESC;




-- Location 


WITH trans_volume AS
(
	SELECT 
		location,
		COUNT(transaction_id) AS total_transactions,
		CAST(
			COUNT(transaction_id) * 100.0
			/
			SUM(COUNT(transaction_id)) OVER() 
			AS DECIMAL(10,2)
		) AS transaction_contribution
	FROM purchase
	GROUP BY location
),
sales_contr AS 
(
	SELECT 
		location,
		SUM(net_amount) AS total_sales,
		CAST(
			SUM(net_amount) * 100.0
			/
			SUM(SUM(net_amount)) OVER () 
			AS DECIMAL(10,2)
		) AS sales_contribution
	FROM purchase
	GROUP BY location
)
SELECT 
	t.location,
	t.total_transactions,
	t.transaction_contribution,
	s.total_sales,
	s.sales_contribution
FROM trans_volume AS t
INNER JOIN sales_contr AS s
ON t.location = s.location
ORDER BY s.sales_contribution DESC;



-- Gender

WITH trans_volume AS
(
	SELECT 
		gender,
		COUNT(transaction_id) AS total_transactions,
		CAST(
			COUNT(transaction_id) * 100.0
			/
			SUM(COUNT(transaction_id)) OVER() 
			AS DECIMAL(10,2)
		) AS transaction_contribution
	FROM purchase
	GROUP BY gender
),
sales_contr AS 
(
	SELECT 
		gender,
		SUM(net_amount) AS total_sales,
		CAST(
			SUM(net_amount) * 100.0
			/
			SUM(SUM(net_amount)) OVER () 
			AS DECIMAL(10,2)
		) AS sales_contribution
	FROM purchase
	GROUP BY gender
)
SELECT 
	t.gender,
	t.total_transactions,
	t.transaction_contribution,
	s.total_sales,
	s.sales_contribution
FROM trans_volume AS t
INNER JOIN sales_contr AS s
ON t.gender = s.gender
ORDER BY s.sales_contribution DESC;



-- Age Group 


WITH trans_volume AS
(
	SELECT 
		age_group,
		COUNT(transaction_id) AS total_transactions,
		CAST(
			COUNT(transaction_id) * 100.0
			/
			SUM(COUNT(transaction_id)) OVER() 
			AS DECIMAL(10,2)
		) AS transaction_contribution
	FROM purchase
	GROUP BY age_group
),
sales_contr AS 
(
	SELECT 
		age_group,
		SUM(net_amount) AS total_sales,
		CAST(
			SUM(net_amount) * 100.0
			/
			SUM(SUM(net_amount)) OVER () 
			AS DECIMAL(10,2)
		) AS sales_contribution
	FROM purchase
	GROUP BY age_group
)
SELECT 
	t.age_group,
	t.total_transactions,
	t.transaction_contribution,
	s.total_sales,
	s.sales_contribution
FROM trans_volume AS t
INNER JOIN sales_contr AS s
ON t.age_group = s.age_group
ORDER BY s.sales_contribution DESC;




-- Purchase Method


WITH trans_volume AS
(
	SELECT 
		purchase_method,
		COUNT(transaction_id) AS total_transactions,
		CAST(
			COUNT(transaction_id) * 100.0
			/
			SUM(COUNT(transaction_id)) OVER() 
			AS DECIMAL(10,2)
		) AS transaction_contribution
	FROM purchase
	GROUP BY purchase_method
),
sales_contr AS 
(
	SELECT 
		purchase_method,
		SUM(net_amount) AS total_sales,
		CAST(
			SUM(net_amount) * 100.0
			/
			SUM(SUM(net_amount)) OVER () 
			AS DECIMAL(10,2)
		) AS sales_contribution
	FROM purchase
	GROUP BY purchase_method
)
SELECT 
	t.purchase_method,
	t.total_transactions,
	t.transaction_contribution,
	s.total_sales,
	s.sales_contribution
FROM trans_volume AS t
INNER JOIN sales_contr AS s
ON t.purchase_method = s.purchase_method
ORDER BY s.sales_contribution DESC;



















































































