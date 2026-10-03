
-- PURCHASE METHOD ANALYSIS


USE retail_customer;


-- Q.1 Which purchase methods are used most frequently by customers ?


SELECT 
	purchase_method,
	COUNT(transaction_id) AS total_transactions
FROM purchase
GROUP BY purchase_method
ORDER BY total_transactions DESC;

 

-- Q.2 How does sales performance differ across purchase methods ?


SELECT 
	purchase_method,
	SUM(net_amount) AS total_net_sales
FROM purchase
GROUP BY purchase_method
ORDER BY total_net_sales DESC;



-- Q.3 Does purchase method preference vary across different customer segments ?


-- Gender

SELECT 
	purchase_method,
	gender,
	COUNT(transaction_id) AS total_transactions
FROM purchase
GROUP BY 
	purchase_method,
	gender
ORDER BY
	purchase_method ASC,
	total_transactions DESC;


-- Age-Group 

SELECT 
	purchase_method,
	age_group,
	COUNT(transaction_id) AS total_transactions
FROM purchase
GROUP BY 
	purchase_method,
	age_group
ORDER BY
	purchase_method ASC,
	total_transactions DESC;


-- Location

SELECT 
	purchase_method,
	location,
	COUNT(transaction_id) AS total_transactions
FROM purchase
GROUP BY 
	purchase_method,
	location
ORDER BY
	purchase_method ASC,
	total_transactions DESC;



-- Q.4 Are certain purchase methods associated with higher-value transactions ?


SELECT 
	purchase_method,
	CAST
	(
		SUM(net_amount) / COUNT(transaction_id)
		AS DECIMAL(10,2)
	) AS average_transaction_value
FROM purchase
GROUP BY purchase_method
ORDER BY average_transaction_value DESC;



