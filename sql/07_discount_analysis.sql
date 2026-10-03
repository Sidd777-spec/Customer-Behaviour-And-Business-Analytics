
-- DISCOUNT ANALYSIS 

USE retail_customer;


-- Q.1 How frequently are discounts been used across transactions ?

SELECT 
	discount_availed,
	COUNT(transaction_id) AS total_transactions,
	CAST(
		COUNT(transaction_id) * 100.0
		/
		SUM(COUNT(transaction_id)) OVER() 
		AS DECIMAL(10,2)
	)AS discount_availed_percentage
FROM purchase
GROUP BY discount_availed
ORDER BY total_transactions ASC;



--Q.2 How does sales performance compare between transactions where a discount was availed and transactions where 
--    no discount was availed ?


SELECT 
	discount_availed,
	COUNT(transaction_id) AS total_transactions,
	SUM(net_amount) AS total_sales
FROM purchase
GROUP BY discount_availed
ORDER BY total_sales DESC;



-- Q.3 Which discount campaigns are associated with the highest sales activity?


SELECT 
	discount_name,
	SUM(net_amount) AS total_net_sales
FROM purchase
WHERE discount_availed = 'Yes'
AND discount_name IS NOT NULL
GROUP BY discount_name
ORDER BY total_net_sales DESC;



-- Q.4 How does the impact of discount differ across product categories ?

	-- Q 4.1 Impact when Discount is Involved

	SELECT 
		product_category,
		COUNT(transaction_id) AS total_transactions,
		SUM(net_amount) AS total_net_sales
	FROM purchase
	WHERE discount_availed = 'Yes'
	GROUP BY product_category
	ORDER BY 
		total_net_sales DESC;


	-- Q 4.2 Impact when NO discount is involved

	SELECT 
		product_category,
		COUNT(transaction_id) AS total_transactions,
		SUM(net_amount) AS total_net_sales
	FROM purchase
	WHERE discount_availed = 'No'
	GROUP BY product_category
	ORDER BY 
		total_net_sales DESC;


	-- Q 4.3 Discount usage By product category .

	WITH discount_transc AS
	(
		SELECT 
			product_category,
			COUNT(transaction_id) AS discounted_transactions
		FROM purchase
		WHERE discount_availed = 'Yes'
		GROUP BY product_category
	),
	total_transc AS
	(
		SELECT
			product_category,
			COUNT(transaction_id) AS total_transactions
		FROM purchase
		GROUP BY product_category
	)
	SELECT 
		tt.product_category,
		tt.total_transactions,
		dt.discounted_transactions,
		CAST
		( 
			(dt.discounted_transactions * 100.0) / tt.total_transactions AS DECIMAL(10,2)
		) AS discount_share_percentage
	FROM discount_transc AS dt
	INNER JOIN total_transc AS tt
	ON dt.product_category = tt.product_category
	ORDER BY discount_share_percentage DESC;



-- Q.5 Are Discounts being used more heavily by particular customer segments ?


-- Gender

WITH discount_transc AS
(
	SELECT 
		gender,
		COUNT(transaction_id) AS dicounted_transactions
	FROM purchase
	WHERE discount_availed = 'Yes'
	GROUP BY gender
),
total_transc AS 
(
	SELECT 
		gender,
		COUNT(transaction_id) AS total_ransactions
	FROM purchase
	GROUP BY gender
)
SELECT 
	tt.gender,
	tt.total_ransactions,
	dt.dicounted_transactions,
	CAST
	(
		(dt.dicounted_transactions * 100.0) / tt.total_ransactions AS DECIMAL(10,2)
	) AS discount_usage
FROM discount_transc AS dt
INNER JOIN total_transc AS tt
ON dt.gender = tt.gender
ORDER BY discount_usage DESC;



-- Age Group

WITH discount_transc AS
(
	SELECT 
		age_group,
		COUNT(transaction_id) AS dicounted_transactions
	FROM purchase
	WHERE discount_availed = 'Yes'
	GROUP BY age_group
),
total_transc AS 
(
	SELECT 
		age_group,
		COUNT(transaction_id) AS total_ransactions
	FROM purchase
	GROUP BY age_group
)
SELECT 
	tt.age_group,
	tt.total_ransactions,
	dt.dicounted_transactions,
	CAST
	(
		(dt.dicounted_transactions * 100.0) / tt.total_ransactions AS DECIMAL(10,2)
	) AS discount_usage
FROM discount_transc AS dt
INNER JOIN total_transc AS tt
ON dt.age_group = tt.age_group
ORDER BY discount_usage DESC;



-- Location 

WITH discount_transc AS
(
	SELECT 
		location,
		COUNT(transaction_id) AS dicounted_transactions
	FROM purchase
	WHERE discount_availed = 'Yes'
	GROUP BY location
),
total_transc AS 
(
	SELECT 
		location,
		COUNT(transaction_id) AS total_ransactions
	FROM purchase
	GROUP BY location
)
SELECT 
	tt.location,
	tt.total_ransactions,
	dt.dicounted_transactions,
	CAST
	(
		(dt.dicounted_transactions * 100.0) / tt.total_ransactions AS DECIMAL(10,2)
	) AS discount_usage
FROM discount_transc AS dt
INNER JOIN total_transc AS tt
ON dt.location = tt.location
ORDER BY discount_usage DESC;



-- Purchase Method

WITH discount_transc AS
(
	SELECT 
		purchase_method,
		COUNT(transaction_id) AS dicounted_transactions
	FROM purchase
	WHERE discount_availed = 'Yes'
	GROUP BY purchase_method
),
total_transc AS 
(
	SELECT 
		purchase_method,
		COUNT(transaction_id) AS total_ransactions
	FROM purchase
	GROUP BY purchase_method
)
SELECT 
	tt.purchase_method,
	tt.total_ransactions,
	dt.dicounted_transactions,
	CAST
	(
		(dt.dicounted_transactions * 100.0) / tt.total_ransactions AS DECIMAL(10,2)
	) AS discount_usage
FROM discount_transc AS dt
INNER JOIN total_transc AS tt
ON dt.purchase_method = tt.purchase_method
ORDER BY discount_usage DESC;



