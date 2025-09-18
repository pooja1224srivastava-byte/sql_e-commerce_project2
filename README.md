# sql_e-commerce_project2
Project Overview-
         This project analyzes a large E-commerce sales dataset using SQL to answer real-world business questions.
         It demonstrates skills in data cleaning, aggregation, window functions, ranking, and business insights generation-core skills for a Data Analyst role.

Dataset
- File: ecommerce_sales_dataset.csv
- Rows: 50,000+orders
- Columns:
        OrderID (Primary Key)
        OrderDate
        CustomerID
        CustomerName
        Region
        Category
        ProductName
        Quantity
        UnitPrice
        Discount
        Sales
        Profit

Key SQL Skills Demonstrated ----

  Basic Queries → Filtering, Sorting, Distinct values

  Aggregations → SUM, AVG, COUNT, MIN, MAX

  Joins & Subqueries → Simulated with aggregations and lookups

  Window Functions → RANK, ROW_NUMBER, CUME_DIST, LAG

  Business Analysis → Profit margin, YoY growth, top customers, seasonal analysis

 
  Business Questions Solved-----

✔️ Total sales & profit across categories
✔️ Top 10 customers by sales
✔️ Top 5% customers by sales (Pareto principle)
✔️ Loyal customers (>20 orders)
✔️ Seasonal trends (which month has highest sales)
✔️ YoY growth using LAG()
✔️ Top 3 products per category using RANK()
✔️ Category contribution % to total sales
✔️ Impact of discount on profit


   Insights from the Analysis----

The technology category generates the highest revenue.

The top 5% of customers contribute a major share of total sales.

Loyal customers (20+ orders) are spread across all regions.

Discounts often reduce profitability, especially in Furniture.

November and December show consistently higher sales (seasonality effect).






  
