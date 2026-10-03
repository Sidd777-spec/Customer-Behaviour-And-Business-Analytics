
-- ISSUE :
-- == SSIS was unable to automatically interpret the DD/MM/YYYY format as a datetime.


-- SOLUTION : 
-- == Imported Purchase Date into a staging table (purchase_staging) as NVARCHAR, then explicitly converted it  

-- == using : TRY_CONVERT(DATETIME2, purchase_date, 103) AS converted_date


USE retail_customer;


-- Staging Table --

CREATE TABLE purchase_staging
(
    customer_id INT,
    transaction_id BIGINT,
    gender NVARCHAR(20),
    age_group NVARCHAR(20),
    purchase_date NVARCHAR(30),
    product_category NVARCHAR(50),
    discount_availed NVARCHAR(10),
    discount_name NVARCHAR(50),
    discount_amount DECIMAL(10,2),
    gross_amount DECIMAL(10,2),
    net_amount DECIMAL(10,2),
    purchase_method NVARCHAR(25),
    location NVARCHAR(25)
);


-- Check whether purchase_date (NVARCHAR) can be successfully converted to DATETIME2 using
-- style 103 (DD/MM/YYYY) before loading it into the final table.

-- If not,then returns NULL.

SELECT
    purchase_date,
    TRY_CONVERT(DATETIME2, purchase_date, 103) AS converted_date
FROM purchase_staging;



-- Checking that all dates in the purchase_date column are converted.

SELECT
    purchase_date
FROM purchase_staging
WHERE purchase_date IS NOT NULL
AND TRY_CONVERT(DATETIME2, purchase_date, 103) IS NULL;


-- Inserting staging table (purchase_staging) data, INTO the main (purchase) table.
-- While also converting the purchase_date from NVARCHAR to DATETIME2.

INSERT INTO purchase
(
    customer_id,
    transaction_id,
    gender,
    age_group,
    purchase_date,
    product_category,
    discount_availed,
    discount_name,
    discount_amount,
    gross_amount,
    net_amount,
    purchase_method,
    location
)
SELECT
    customer_id,
    transaction_id,
    gender,
    age_group,
    TRY_CONVERT(DATETIME2, purchase_date, 103),
    product_category,
    discount_availed,
    discount_name,
    discount_amount,
    gross_amount,
    net_amount,
    purchase_method,
    location
FROM purchase_staging;


-- Ensuring all rows are imported successfully into our main table.

SELECT COUNT(*) FROM purchase

