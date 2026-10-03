
CREATE DATABASE retail_customer;


USE retail_customer;


CREATE TABLE purchase
(
	customer_id INT,
	transaction_id BIGINT,
	gender NVARCHAR(10),
	age_group NVARCHAR(15),
	purchase_date DATE,
	product_category NVARCHAR(20),
	discount_availed NVARCHAR(5),
	discount_name NVARCHAR(25),
	discount_amount DECIMAL(10,2),
	gross_amount DECIMAL(10,2),
	net_amount DECIMAL(10,2),
	purchase_method NVARCHAR(25),
	location NVARCHAR(25)
);

ALTER TABLE purchase
ALTER COLUMN purchase_date DATETIME2;

ALTER TABLE purchase
ALTER COLUMN purchase_date DATETIME2(0);


-- Changing Primary Key --

EXEC sp_help 'purchase';

ALTER TABLE purchase
DROP CONSTRAINT PK__purchase__CD65CB85E1F8824B;


ALTER TABLE purchase
ALTER COLUMN transaction_id BIGINT NOT NULL ;


ALTER TABLE purchase
ADD CONSTRAINT PK__purchase
PRIMARY KEY (transaction_id);