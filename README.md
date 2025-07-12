# SQL Data Analysis Portfolio Project

This project is based on the YouTube tutorial  
🎥 [SQL Data Analyst Portfolio Project | Like I Do in My Real Projects](https://www.youtube.com/watch?v=2jGhQpbzHes)

It simulates a real-world SQL data analysis scenario, covering different types of analysis and reporting.

---

## 📌 Objectives

The project demonstrates how to:

- Analyze data over time
- Perform cumulative and performance analysis
- Execute part-to-whole and segmentation analysis
- Generate actionable insights through SQL reports

---

## 🔍 Analysis Types

- 📈 **Changes Over Time**
- 📊 **Cumulative Analysis**
- 🚀 **Performance Analysis**
- 🧩 **Part-to-Whole Analysis**
- 🔍 **Data Segmentation**

---

## 📋 Final Deliverables

Two comprehensive reports saved as **SQL views**:

- **Customer Report** → `08_customer_report.sql`
- **Product Report** → `09_report_customers_view.sql`

---

## 🛠️ SQL Techniques Used

- Basic SQL: `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `ORDER BY`
- Intermediate: `CASE WHEN`, `JOINS`
- Advanced: `Window Functions`, `CTEs`, `Subqueries`

---

## 📂 Files

### `scripts/` — SQL Analysis & Reporting Scripts

| File                                  | Description                                        |
|---------------------------------------|----------------------------------------------------|
| `00_init_database.sql`               | Initializes database schema and tables             |
| `01_changes_over_time_analysis_month.sql` | Analyzes sales trends on a monthly basis     |
| `02_changes_over_time_analysis_year.sql`  | Analyzes sales trends on a yearly basis      |
| `03_cumulative_analysis.sql`         | Calculates cumulative metrics over time            |
| `04_performance_analysis.sql`        | Evaluates sales performance across dimensions      |
| `05_part_to_whole_analysis.sql`      | Analyzes sales contribution by segments            |
| `06_data_segmentation_cost.sql`      | Segments data based on cost-related criteria       |
| `07_data_segmentation_customer.sql`  | Segments data by customer characteristics          |
| `08_customer_report.sql`             | Constructs customer report logic                   |
| `09_report_customers_view.sql`       | Creates a view for the customer report             |
| `10_product_report.sql`              | Constructs and saves the product report as a view  |

### `dataset/` — Source Data Tables

| File                          | Description                                |
|-------------------------------|--------------------------------------------|
| `gold.fact_sales.csv`         | Fact table containing transactional sales data |
| `gold.report_customers.csv`   | Dimension table for customer information |
| `gold.report_products.csv`    | Dimension table for product information  |

---

## 💬 Feedback

If you have suggestions for improvements or feedback, feel free to connect on [LinkedIn](https://www.linkedin.com/in/mi7773).

---

## 📎 Credits

Inspired by the tutorial:
[SQL Data Analyst Portfolio Project | Like I Do in My Real Projects](https://www.youtube.com/watch?v=2jGhQpbzHes)
