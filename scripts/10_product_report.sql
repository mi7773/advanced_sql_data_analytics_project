/*
===============================================================================
Product Report
===============================================================================
Purpose:
	- This report consolidates key product metrics and behaviors.

Highlights:
	1. Gather essential fields such as product name, category, subcategory, and cost.
	2. Segment products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
	3. Aggregate product-level metrics:
		- total orders
		- total sales
		- total quantity sold
		- total customers (unique)
		- lifespan (in months)
	4. Calculate valuable KPIs:
		- recency (months since last sale)
		- average order revenue (AOR)
		- average monthly revenue
===============================================================================
*/
CREATE VIEW gold.report_products AS
WITH base_query AS (
	/*---------------------------------------------------------------------
	1) Base Query: Retrieve core columns from fact_sales and dim_products
	---------------------------------------------------------------------*/
	SELECT
		s.order_number,
		s.product_key,
		s.customer_key,
		s.order_date,
		s.sales_amount,
		s.quantity,
		p.product_name,
		p.category,
		p.subcategory,
		p.cost
	FROM gold.fact_sales AS s
	LEFT JOIN gold.dim_products AS p
	ON s.product_key = p.product_key
	WHERE order_date IS NOT NULL), -- only consider valid sales dates

product_aggregation AS (
	/*---------------------------------------------------------------------
	2) Product Aggregation: Summarize key metrics at the product level
	---------------------------------------------------------------------*/
	SELECT
		product_key,
		product_name,
		category,
		subcategory,
		cost,
		COUNT(DISTINCT order_number) AS total_orders,
		SUM(sales_amount) AS total_sales,
		SUM(quantity) AS total_quantities_sold,
		COUNT(DISTINCT customer_key) AS total_customers,
		MAX(order_date) AS last_order_date,
		DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
		ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)), 1) AS avg_selling_price
	FROM base_query
	GROUP BY
		product_key,
		product_name,
		category,
		subcategory,
		cost)
/*---------------------------------------------------------------------
3) Final Query: Combines all product results into one output
---------------------------------------------------------------------*/
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_order_date,
	DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency_in_months,
	CASE
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantities_sold,
	total_customers,
	avg_selling_price,
	-- Average Order Revenue (AOR)
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue,
	-- Average Monthly Revenue
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM product_aggregation;