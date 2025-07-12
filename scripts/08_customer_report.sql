/*
========================================================================================
Customer Report
========================================================================================
Purpose:
	- This report consolidates key customer metrics and behaviors

Highlights:
	1. Gather essential fields such as names, ages, and transaction details.
	2. Segment Customers into categories (VIP, Regular, New) and age groups.
	3. Aggregate customer-level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products
		- life span (in months)
	4. Calculate valuable KPIs:
		- recency (months since last order)
		- average order value
		- average monthly spend
========================================================================================
*/
/* base -> transform -> Aggregations -> final result -> final transformations -> view (report) */
CREATE VIEW gold.report_customers AS
WITH base_query AS (
	/*--------------------------------------------------------------------------------------
	1) Base Query: Retrieve core columns from tables
	--------------------------------------------------------------------------------------*/
	SELECT
		s.order_number,
		s.product_key,
		s.order_date,
		s.sales_amount,
		s.quantity,
		c.customer_key,
		c.customer_number,
		CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
		DATEDIFF(YEAR, c.birthdate, GETDATE()) AS age
	FROM gold.fact_sales AS s
	LEFT JOIN gold.dim_customers AS c
	ON s.customer_key = c.customer_key
	WHERE order_date IS NOT NULL),

customer_aggregation AS (
	/*--------------------------------------------------------------------------------------
	2) Customer Aggregations: Summarize key metrics at the customer level
	--------------------------------------------------------------------------------------*/
	SELECT
		customer_key,
		customer_number,
		customer_name,
		age,
		COUNT(DISTINCT order_number) AS total_orders,
		COUNT(DISTINCT product_key) AS total_products,
		MAX(order_date) AS last_order_date,
		DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
		SUM(sales_amount) AS total_sales,
		SUM(quantity) AS total_quantities
	FROM base_query
	GROUP BY
		customer_key,
		customer_number,
		customer_name,
		age)

SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	CASE
		WHEN age < 20 THEN 'Under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20 - 29'
		WHEN age BETWEEN 30 AND 39 THEN '30 - 39'
		WHEN age BETWEEN 40 AND 49 THEN '40 - 49'
		ELSE '50 and above'
	END AS age_group,
	CASE
		WHEN lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment,
	last_order_date,
	DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
	total_orders,
	total_sales,
	total_quantities,
	total_products,
	lifespan,
	-- Compute average order value (AOV)
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_value,
	-- Compute average monthly spend
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_spend
FROM customer_aggregation;