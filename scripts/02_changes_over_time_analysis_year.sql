-- -- Changes Over Time Analysis (Year)
SELECT
	YEAR(order_date) AS order_year,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantities
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_year;

-- Alternative way
SELECT
	DATETRUNC(YEAR, order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(quantity) AS total_quantities
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR, order_date)
ORDER BY order_date;

-- How many new customers were added each year
SELECT
	DATETRUNC(YEAR, create_date) AS create_date,
	COUNT(customer_key) AS total_customer
FROM gold.dim_customers
GROUP BY DATETRUNC(YEAR, create_date)
ORDER BY create_date;