-- Calculate the total sales per month
-- and the running total of sales over time
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER(
		PARTITION BY YEAR(order_date)
		ORDER BY order_date ASC) AS running_total_sales 
FROM (
	SELECT
		DATETRUNC(MONTH, order_date) AS order_date,
		SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH, order_date)) AS monthly_sales;

-- Calculate the total sales per year
-- and the running total of sales over time
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER(ORDER BY order_date ASC) AS running_total_sales
FROM (
	SELECT
		DATETRUNC(YEAR, order_date) AS order_date,
		SUM(sales_amount) AS total_sales
	FROM gold.fact_sales
	GROUP BY DATETRUNC(YEAR, order_date)) AS yearly_sales;

-- Moving average price (yearly)
SELECT
	order_date,
	avg_price,
	AVG(avg_price) OVER(ORDER BY order_date ASC) AS moving_average_price
FROM (
	SELECT
		DATETRUNC(YEAR, order_date) AS order_date,
		AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR, order_date)) AS yearly_avg_price;