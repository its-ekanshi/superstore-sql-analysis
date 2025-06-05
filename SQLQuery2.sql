CREATE DATABASE PRACTICE
SELECT * FROM Superstore_Data;
SELECT COUNT(*) FROM Superstore_Data;

--1.Top 10 Customers by Total Sales
select top 10 customer_id, customer_name, 
round(sum(Sales), 2) as total_sales, 
count(distinct order_id) as count_of_orders
from Superstore_Data
group by customer_id, customer_name
order by total_sales desc;

--2.Calculate total sales by year-month
select format(CAST(Order_Date AS datetime), 'yyyy-MM') as year_month,
round(sum(Sales), 2) as total_sales
from Superstore_Data
group by format(CAST(Order_Date AS datetime), 'yyyy-MM')
order by year_month;
--48 rows

--3.Average Order Value
select round(avg(sales), 2) as avg_order_value
from Superstore_Data;

--4.Sales and Profit by Product Category
select category,
round(sum(sales), 2) as total_sales,
round(sum(cast(profit as float)), 2) as total_profit
from Superstore_Data
group by category
order by total_sales, total_profit;

--5.Orders by Shipping Mode
--what is the count & percentage distribution of orders by ship mode ?
select ship_mode,
count(ship_mode) as count_ship_mode,
round((count(ship_mode)*100.0/(select count(*) from Superstore_Data)),2) as percentage_distribution
from Superstore_Data
group by ship_mode
order by percentage_distribution desc;

--6.Top 5 most profitable products
select top 5 product_name,
product_id,
round(avg(cast(profit as float)), 2) as avg_profit
from Superstore_Data
group by product_name, product_id
order by avg_profit desc;

--7.Region-wise Sales & Profit Analysis
select region,
round(sum(cast(profit as float)), 2) as total_profit,
round(sum(sales), 2) as total_sales
from Superstore_Data
group by region
order by total_profit desc, total_sales desc; 

--8.Customer Segments Performance
select top 3 segment,
round(sum(sales), 2) as total_sales
from Superstore_Data
group by segment
order by total_sales desc;

--9.Daily Sales Trend
select cast(order_date as Date) as Order_day,
round(sum(sales), 2) as total_sales
from Superstore_Data
group by cast(order_date as Date)
order by total_sales desc, order_day;
--1237 rows

--10.Orders with Negative Profit (Loss-Making Orders)
select order_id, profit
from Superstore_Data
where TRY_CAST(profit AS FLOAT) < 0
order by order_id;
--1871 rows

--11.Sales & Profit by top 10 States
select top 10 state,
round(sum(sales), 2) as total_sales,
round(sum(cast(profit as float)), 2) as total_profit
from Superstore_Data
group by state
order by total_sales desc, total_profit desc;

--12.Top 10 states performing worst in terms of sales & profit 
select top 10 state,
round(sum(sales), 2) as total_sales,
round(sum(cast(profit as float)), 2) as total_profit
from Superstore_Data
group by state
having sum(sales) < 0 or sum(cast(profit as float)) < 0

--13.Average Delivery Time by Region
select region, order_id,
avg(datediff(day, order_date, ship_date)) as avg_no_of_days,
avg(datediff(hour, order_date, ship_date)) as avg_no_of_days
from Superstore_Data
group by region, order_id
order by region, avg(datediff(day, order_date, ship_date)) desc;

--14.Identify Sales Outliers (High Value Orders)
select *
from Superstore_Data
where sales > (select avg(sales) + 2*STDEV(sales) from Superstore_Data)
--247 rows

--15.Repeat Customer Rate
select count(distinct customer_id) as total_customers,
count(distinct case when order_count > 1 then customer_id end) as repeat_customers,
round(count (distinct case when order_count > 1 then customer_id end)*100.0/count(distinct customer_id),2) as repeat_customer_rate
from (
select customer_id,
count(order_id) as order_count
from Superstore_Data
group by customer_id) A;

































































































































































