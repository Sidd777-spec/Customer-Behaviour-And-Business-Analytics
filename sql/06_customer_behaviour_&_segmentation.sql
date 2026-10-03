
-- CUSTOMER BEHAVIOUR AND SEGMENTATION

USE retail_customer;



-- Q1. How is the customer base distributed across different age group ?


SELECT 
	age_group,
	COUNT(transaction_id) AS total_transactions,
	CAST
		(
		COUNT(transaction_id) * 100.0
		/
		SUM(COUNT(transaction_id)) OVER () 
		AS DECIMAL(10,2)
	) AS transaction_percentage
FROM purchase
GROUP BY age_group
ORDER BY transaction_percentage DESC;



-- Q2. How does purchasing behaviour differ between age groups ?


	--Q 2.1 Group with highest purchasing activity 

		SELECT
			age_group,
			COUNT(transaction_id) AS total_purchases
		FROM purchase
		GROUP BY age_group
		ORDER BY total_purchases DESC;


	--Q 2.2 What type of product does each age group buy the most  ?

		SELECT
			age_group,
			product_category,
			COUNT(transaction_id) AS total_purchases
		FROM purchase
		GROUP BY 
			age_group,
			product_category
		ORDER BY 
			age_group ASC,
			total_purchases DESC;


	--Q 2.3 What is their most preffred purchasing method ?

	SELECT
		age_group,
		purchase_method,
		COUNT(transaction_id) AS total_purchases
	FROM purchase
	GROUP BY 
		age_group,
		purchase_method
	ORDER BY 
		age_group ASC,
		total_purchases DESC;



-- Q 3. How does purchasing behavior differ by gender?

	--Q.3.1  Which gender contributes the more in purchasing activity ?

	SELECT
		gender,
		COUNT(transaction_id) AS total_purchases
	FROM purchase
	GROUP BY gender
	ORDER BY total_purchases DESC;


	--Q.3.2  Which are the most frequently purchased product categories ?  

	SELECT 
		gender,
		product_category,
		COUNT(transaction_id) AS total_purchases
	FROM purchase
	GROUP BY 
		gender,
		product_category
	ORDER BY 
		gender ASC,
		total_purchases DESC;


		--Q.3.2.2 What products do each gender likes the most compared to others ? 

		SELECT 
			gender,
			product_category,
			COUNT(transaction_id) AS total_purchases
		FROM purchase
		GROUP BY 
			gender,
			product_category
		ORDER BY 
			product_category ASC,
			total_purchases DESC;


-- Q.4 Which customer segments contribute the most to overall sales?

-- Q.4.1 Sales Contribution by Individual Customer Segments


	-- Q.4.1.1 Sales by Age Group

	SELECT 
		age_group,
		SUM(net_amount) AS total_sales
	FROM purchase
	GROUP BY age_group
	ORDER BY total_sales DESC;


	-- Q.4.1.2 Sales by Gender

	SELECT 
		gender,
		SUM(net_amount) AS total_sales
	FROM purchase
	GROUP BY gender
	ORDER BY total_sales DESC;

 
	-- Q.4.1.3 Sales by Customer's Purchase Method 

	SELECT 
		purchase_method,
		SUM(net_amount) AS total_sales
	FROM purchase
	GROUP BY purchase_method
	ORDER BY total_sales DESC;


	-- Q.4.1.4 Sales by Customer's Location

	SELECT 
		location,
		SUM(net_amount) AS total_sales
	FROM purchase
	GROUP BY location
	ORDER BY total_sales DESC;



-- Q.4.2 Sales Contribution by Combined Customer Segments

SELECT 
	age_group,
	gender,
	purchase_method,
	location,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY 
	age_group,
	gender,
	purchase_method,
	location
ORDER BY total_sales DESC;



-- Q.5 Are there customer segments that generate relatively high transaction activity but comparatively lower sales?

-- Gender 

-- Transaction Activity
SELECT
	gender,
	COUNT(transaction_id) AS total_transactions
FROM purchase
GROUP BY gender
ORDER BY total_transactions DESC;


-- Sales Contribution

SELECT 
	gender,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY gender
ORDER BY total_sales DESC;



-- Age Group

-- Transaction Activity

SELECT
	age_group,
	COUNT(transaction_id) AS total_transactions
FROM purchase
GROUP BY age_group
ORDER BY total_transactions DESC;


-- Sales Contribution

SELECT 
	age_group,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY age_group
ORDER BY total_sales DESC;



-- Location

-- Transaction Activity

SELECT
	location,
	COUNT(transaction_id) AS total_transactions
FROM purchase
GROUP BY location
ORDER BY total_transactions DESC;


-- Sales Contribution

SELECT 
	location,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY location
ORDER BY total_sales DESC;



-- Purchase Method

-- Transaction Activity

SELECT
	purchase_method,
	COUNT(transaction_id) AS total_transactions
FROM purchase
GROUP BY purchase_method
ORDER BY total_transactions DESC;


-- Sales Contribution

SELECT 
	purchase_method,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY purchase_method
ORDER BY total_sales DESC;






