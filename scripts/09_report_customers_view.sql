-- report_customers (veiw)
-- age_group
SELECT
	age_group,
	COUNT(customer_number) AS total_customers,
	SUM(total_sales) AS total_sales
FROM gold.report_customers
GROUP BY age_group
ORDER BY age_group;

-- customer_segment
SELECT
	customer_segment,
	COUNT(customer_number) AS total_customers,
	SUM(total_sales) AS total_sales
FROM gold.report_customers
GROUP BY customer_segment;