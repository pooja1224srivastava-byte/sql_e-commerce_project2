create database ecommerce_sales;
use ecommerce_sales;
CREATE TABLE ecomm_sales (
    OrderID INT PRIMARY KEY,
    OrderDate DATETIME,
    CustomerID INT,
    CustomerName VARCHAR(50),
    Region VARCHAR(25),
    Category VARCHAR(35),
    ProductName VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10 , 2 ),
    Discount DECIMAL(4 , 2 ),
    Sales DECIMAL(12 , 2 ),
    Profit DECIMAL(12 , 2 )
);

SELECT 
    *
FROM
    ecomm_sales;
SELECT 
    COUNT(*)
FROM
    ecomm_sales;

SELECT 
    *
FROM
    ecomm_sales
WHERE
    OrderID IS NULL OR OrderDate IS NULL
        OR CustomerID IS NULL
        OR CustomerName IS NULL
        OR Region IS NULL
        OR Category IS NULL
        OR ProductName IS NULL
        OR Quantity IS NULL
        OR UnitPrice IS NULL
        OR Discount IS NULL
        OR Sales IS NULL
        OR Profit IS NULL;


-- 🔹 1. Basic Queries

-- 1. Show the first 10 rows of the table.
SELECT 
    *
FROM
    ecomm_sales
LIMIT 10;

-- Count the total number of orders.
SELECT 
    COUNT(OrderId) AS total_number_of_orders
FROM
    ecomm_sales;
 -- or
 SELECT 
    COUNT(*) AS total_number_of_orders
FROM
    ecomm_sales;
 
 -- List all unique regions.
SELECT DISTINCT
    region
FROM
    ecomm_sales;

-- Find the earliest and latest order dates.
SELECT 
    OrderDate AS earliest_order_date
FROM
    ecomm_sales
ORDER BY 1
LIMIT 1;
SELECT 
    OrderDate AS lates_order_date
FROM
    ecomm_sales
ORDER BY 1 DESC
LIMIT 1;
-- or
SELECT 
    MIN(OrderDate) AS earliest_date,
    MAX(OrderDate) AS latest_date
FROM
    ecomm_sales;

-- Show all orders where Discount > 0.2
SELECT 
    *
FROM
    ecomm_sales
WHERE
    Discount > 0.2;



-- 🔹 2. Aggregations

-- Find the total sales.
SELECT 
    SUM(Sales) AS total_sales
FROM
    ecomm_sales;

-- Calculate the average profit per order.
SELECT 
    AVG(Profit) AS average_profit
FROM
    ecomm_sales;

-- Find total quantity sold for each product.
SELECT 
    ProductName, SUM(Quantity) AS total_quantity_sold
FROM
    ecomm_sales
GROUP BY ProductName;

-- Get the number of customers per region.
SELECT 
    Region, COUNT(DISTINCT CustomerName) AS number_of_customers
FROM
    ecomm_sales
GROUP BY Region;

-- Show the total sales and profit per category.
SELECT 
    Category,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit
FROM
    ecomm_sales
GROUP BY Category;


-- 🔹 3. Sorting & Filtering

-- Find the top 10 highest sales orders.
SELECT 
    *
FROM
    ecomm_sales
ORDER BY Sales DESC
LIMIT 10;

-- Show customers who made purchases worth more than 50,000 in total.
SELECT 
    CustomerName, SUM(Sales) AS Total_Sales
FROM
    ecomm_sales
GROUP BY CustomerName
HAVING Total_Sales > 50000;

-- List the top 5 most profitable products.
SELECT 
    ProductName, SUM(Profit) AS Total_Profit
FROM
    ecomm_sales
GROUP BY ProductName
ORDER BY Total_Profit DESC
LIMIT 5;

-- Show the bottom 5 products (least sales).
SELECT 
    ProductName, SUM(Sales) AS least_sales
FROM
    ecomm_sales
GROUP BY ProductName
ORDER BY least_sales
LIMIT 5;

-- Find all orders from the "Technology" category in the "East" region.
SELECT 
    *
FROM
    ecomm_sales
WHERE
    Category = 'Technology'
        AND region = 'East';
        
        
-- 🔹 4. Time-based Analysis

-- Calculate monthly sales totals.
SELECT 
    EXTRACT(MONTH FROM OrderDate) AS month_name,
    SUM(Sales) AS Total_sales
FROM
    ecomm_sales
GROUP BY month_name
ORDER BY 2;

-- Find the year with the highest profit.
SELECT 
    YEAR(OrderDate) AS year, SUM(profit) AS hieghest_profit
FROM
    ecomm_sales
GROUP BY year
ORDER BY 2
LIMIT 1;

-- Show sales trends per year for each category.
SELECT 
    YEAR(OrderDate) AS year, Category, SUM(Sales) AS Total_Sales
FROM
    ecomm_sales
GROUP BY year , Category
ORDER BY year , Total_Sales DESC; 

-- Find the busiest day (highest number of orders).
SELECT 
    DATE(OrderDate) AS day, COUNT(OrderId) AS number_of_orders
FROM
    ecomm_sales
GROUP BY day
ORDER BY number_of_orders DESC
LIMIT 1;


-- Show average sales per quarter.
SELECT 
    YEAR(OrderDate) AS year,
    QUARTER(OrderDate) AS quarter,
    AVG(Sales) AS avg_sales
FROM
    ecomm_sales
GROUP BY year , quarter;

-- 🔹 5. Customer Insights

-- Find the top 10 customers by sales.
SELECT 
    CustomerName, SUM(Sales) AS sales
FROM
    ecomm_sales
GROUP BY CustomerName
ORDER BY sales DESC
LIMIT 10;

-- Count how many distinct products each customer bought.
select CustomerName, count(distinct ProductName) as distinct_product
from ecomm_sales
group by CustomerName;

-- Find customers who only purchased from two category.
SELECT 
    CustomerName, COUNT(DISTINCT Category) AS category
FROM
    ecomm_sales
GROUP BY CustomerName
HAVING COUNT(DISTINCT Category) = 2;
SELECT 
    CustomerName, COUNT(DISTINCT Category) AS category_count
FROM
    ecomm_sales
GROUP BY CustomerName
ORDER BY category_count ASC
LIMIT 10;

-- Find customers from the "West" region who bought "Furniture".
SELECT DISTINCT
    CustomerName, Region, Category
FROM
    ecomm_sales
WHERE
    Region = 'West'
        AND Category = 'Furniture';

-- 🔹 6. Profitability Analysis

-- Calculate the profit margin = Profit / Sales.
SELECT 
    CustomerName,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    (SUM(Profit) / SUM(Sales)) * 100 AS profit_margin_percentage
FROM ecomm_sales
GROUP BY CustomerName
ORDER BY profit_margin_percentage DESC;



-- Show average profit margin per category
SELECT 
    Category,
    SUM(Profit) / SUM(Sales) AS avg_profit_margin
FROM 
    ecomm_sales
GROUP BY 
    Category
ORDER BY 
    avg_profit_margin DESC;


-- Find regions with overall negative profit.
SELECT 
    Region, SUM(Profit) AS overall_profit
FROM
    ecomm_sales
GROUP BY Region
HAVING SUM(Profit) < 0;


-- Rank categories by total profit.
select Category, sum(Profit) as total_profit,
RANK()OVER(ORDER BY sum(Profit) desc) as profit_rank
from ecomm_sales
group by Category
order by sum(Profit) desc;


-- 🔹 7. Advanced (Joins / Windows)
-- (Even though we have one table, you can simulate joins by grouping or creating small lookup tables)

-- 31. Use a window function to rank products by sales in each region.
select Region, ProductName,
total_sales,
rank() over(partition by Region order by total_sales desc) as sales_rank
from
(select Region, ProductName,
sum(Sales) as total_sales
from ecomm_sales
group by Region, ProductName) as sub
order by Region, sales_rank;


-- 32. Find cumulative sales per month (running total).
select year, month, total_sales,
sum(total_sales) over(order by year, month) as running_total
from
(select year(OrderDate) as year,
month(OrderDate) as month,
sum(Sales) as total_sales
from ecomm_sales
group by year, month) as sub
order by year, month;


select year(OrderDate) as year,
month(OrderDate) as month,
sum(Sales) as total_sales,
sum(sum(Sales)) over(order by year(OrderDate), month(OrderDate)) as running_total
from ecomm_sales
group by year, month
order by year, month;


-- 33. Show year-over-year sales growth.
select year,
total_sales,
lag(total_sales) over(order by year) as previous_year_sales,
concat(round(((total_sales - lag(total_sales) over(order by year))
 / lag(total_sales) over(order by year)) * 100, 2), '%') as yoy_growth_percent
 from
(select year(OrderDate) as year, sum(Sales) as total_sales
from ecomm_sales
group by year
order by  year) as sub
order by year;

-- 34. Find the top 3 products per category by sales.
select * from
(select Category,
ProductName,
total_sales,
rank() over(partition by Category order by total_sales desc) as ranking
from
(select Category, ProductName,
sum(Sales) as total_sales
from ecomm_sales
group by Category, ProductName)
as sub) as ranked
where ranking <= 3
order by Category, ranking;


-- 35. Calculate the percentage contribution of each category to total sales
select Category,
sum(Sales) as Sales_by_category,
round((sum(Sales) / (select sum(Sales) from ecomm_sales)) * 100,2) as percentage_contribution
from ecomm_sales
group by Category
order by percentage_contribution desc;
