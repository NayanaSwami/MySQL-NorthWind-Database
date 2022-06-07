-- Intermediate Problems

-- 20. Categories, and the total products in each category For this problem, we’d like to see the total number of products in each
-- category. Sort the results by the total number of products, in descending order.

select  
categories.category_name,
count(products.product_name) as Total_num_products
from categories
join products on products.category_id = categories.category_id
group by category_name
order by Total_num_products desc;


-- 21. Total customers per country/city
-- In the Customers table, show the total number of customers per Country and City.

select 
country, 
city ,
count(country) as total_country_customers
from customers 
group by city, country  
order by total_country_customers desc;

-- 22. Products that need reordering What products do we have in our inventory that should be reordered?
-- For now, just use the fields UnitsInStock and ReorderLevel, where UnitsInStock is less than the ReorderLevel, ignoring the fields
-- UnitsOnOrder and Discontinued.  Order the results by ProductID

select  product_id ,product_name, units_in_stock,reorder_level from products where units_in_stock <= reorder_level
order by product_id; 


-- 23. Products that need reordering, continued Now we need to incorporate these fields—UnitsInStock, UnitsOnOrder,
-- ReorderLevel, Discontinued—into our calculation. We’ll define “products that need reordering” with the following:
-- UnitsInStock plus UnitsOnOrder are less than or equal to ReorderLevel . The Discontinued flag is false (0).


select  product_id, product_name ,units_in_stock ,units_on_order,reorder_level
from products 
where  units_in_stock + units_on_order <= reorder_level 
and discontinued =0;


-- 24. Customer list by region  salesperson for Northwind is going on a business trip to visit
 -- customers, and would like to see a list of all customers, sorted by region, alphabetically.However, he wants the customers with no region (null in the Region
-- field) to be at the end, instead of at the top, where you’d normally find the null values. Within the same region, companies should be sorted by CustomerID.

select 
customer_id,
company_name,
region
from customers
group by customer_id
order by region desc;

-- 25. High freight charges Some of the countries we ship to have very high freight charges. We'd
-- like to investigate some more shipping options for our customers, to be able to offer them lower freight charges. Return the three ship countries
-- with the highest average freight overall, in descending order by average freight.

select  ship_country,avg(freight) as Average_freight from orders group by ship_country order by Average_freight desc limit 3 ;

-- 26. High freight charges - 2015 We're continuing on the question above on high freight charges. Now,
-- instead of using all the orders we have, we only want to see orders from the year 2015   					--- check once again--

select order_date, ship_country,avg(freight) as Average_freight from orders where order_date > 1995-12-01  
group by ship_country order by Average_freight  desc  limit 3;


-- 27. High freight charges with between Another (incorrect) answer to the problem above is this:
-- Notice when you run this, it gives Sweden as the ShipCountry with the  third highest freight charges. However, this is wrong - it should be France.
-- What is the OrderID of the order that the (incorrect) answer above is missing

select year(order_date), ship_country,avg(freight) as Average_freight from orders where order_date between "1/1/1997" and "12/31/1997"
group by ship_country order by order_date  desc  ;

-- 28. High freight charges - last year We're continuing to work on high freight charges. We now want to get
-- the three ship countries with the highest average freight charges. But instead of filtering for a particular year, we want to use the last 12
-- months of order data, using as the end date the last OrderDate in Orders

Select 
Ship_Country,
max(order_date), avg(freight) as Avg_freight
From Orders
where order_date between 1997-01-09 and  1996-01-01
Group By Ship_Country
Order By Avg_freight desc;

Select 
Ship_Country, 
Avg(freight) as average_freight
From Orders
Where
Order_Date >= Dateadd(1996, -1, (Select max(Order_Date) from Orders))
Group by Ship_Country
Order by average_freight desc;

-- 29. Inventory list We're doing inventory, and need to show information like the below, for all orders. Sort by OrderID and Product ID

Select
Employees.Employee_ID
,Employees.Last_Name
,Orders.Order_ID
,Products.Product_Name
,Order_Details.Quantity
From Employees
join Orders
on Orders.Employee_ID = Employees.Employee_ID
join Order_Details
on Orders.Order_ID = Order_Details.Order_ID
join Products
on Products.Product_ID = Order_Details.Product_ID
Order by
Orders.Order_ID
,Products.Product_Id;

