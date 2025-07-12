/*
Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history and spending €5,000 r less.
	- New: Customers  with a lifespan less than 12 months.
And find the total number of customers by each group.
*/
WITH customer_spending AS (
	SELECT
		customer_key,
		SUM(sales_amount) AS total_spending,
		MIN(order_date) AS first_order,
		MAX(order_date) AS last_order,
		DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan
	FROM gold.fact_sales
	GROUP BY customer_key)

SELECT
	customer_segment,
	-- FORMAT(COUNT(customer_key), 'N0') AS total_customers (output: string)
	COUNT(customer_key) AS total_customers
FROM (
	SELECT
		customer_key,
		CASE
			WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
			WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
			ELSE 'New'
		END AS customer_segment
	FROM customer_spending) AS seg_table
GROUP BY customer_segment
ORDER BY total_customers DESC;