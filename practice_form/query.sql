--create database BikeStores;
--use BikeStores;
/*
	Retrieve all records from the brands table
*/

select * from production.brands;

/*
List all products with a list price greater than $1000
*/
select * from production.products as p where p.list_price > 1000

/*
Find all customers who live in New York (NY).
*/
select c.first_name + ' ' + c.last_Name, c.city  from sales.customers as c where c.city = 'New York'
select c.first_name + ' ' + c.last_Name, c.state  from sales.customers as c where c.state = 'NY'

/*
	Display the names and email addresses of all customers.
*/

select c.first_name+ '' + c.last_Name as [Name], c.email from sales.customers as c

/*
Retrieve all orders placed in the year 2016.
*/
select * from sales.orders as o where year(o.order_date) = 2016

/*
	List all products that belong to the 'Mountain Bikes' category.
*/

select p.product_id,p.product_name,c.category_id,c.category_name from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
where c.category_name = 'Mountain Bikes'

/*
	Find the total number of products in each category.
*/

select count(p.product_id) as [Products], c.category_id, c.category_name from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
group by c.category_id,c.category_name 


/*
	Retrieve the details of the product with the highest list price.
*/
select top 1 * from production.products order by list_price desc


/*
	List all orders along with the customer names who placed them.
*/
SELECT * FROM sales.customers
SELECT * FROM sales.orders

SELECT c.customer_id, c.first_name + ' ' + c.last_name as Name,o.order_id, o.order_date from sales.customers as c
inner join sales.orders as o
on c.customer_id = o.customer_id


/*
	Find all products that were listed in the year 2017.
*/
select * from production.products where model_year = '2017'
------------------------------------------------------------------------------------------------------------------------

/*
	Calculate the average list price of all products.
*/

SELECT AVG(list_price) AS [Average]
FROM production.products;


/*
Find the total quantity of each product sold.
*/

select p.product_id,p.product_name,count(oi.quantity) as [Quantity] from production.products as p
inner join sales.order_items as oi
on p.product_id = oi.product_id
group by p.product_id,p.product_name
order by 3 desc


/*
	Calculate the total sales amount for each store.
*/


select  
	s.store_id
	,s.store_name
	,sum(oi.quantity* oi.list_price* oi. discount) as [sales amount]
from sales.orders as o 
inner join sales.order_items as oi 
on o.order_id = oi.order_id 
inner join sales.stores as s 
on o.store_id = s.store_id
group by 	s.store_id
	,s.store_name

/*
Find the number of orders placed by each customer.
*/




SELECT c.customer_id, c.first_name + ' ' + c.last_name as Name, count(o.order_id) as [Orders] from sales.customers as c
inner join sales.orders as o
on c.customer_id = o.customer_id
group by c.customer_id, c.first_name + ' ' + c.last_name
order by 1

/*
5. Calculate the total discount given on all orders.
*/

SELECT order_id, SUM(quantity * list_price * discount ) AS total_discount
FROM sales.order_items group by order_id;

/*
6. Find the average list price of products in each category.
*/



select c.category_name ,avg(p.list_price) as [Average]
from production.products as p
inner join production.categories as c
on p.category_id = c.category_id
group by c.category_name


/*
7. Retrieve the total number of orders placed in each month of 2016.
*/

select  DATENAME(MONTH, o.order_date) AS [MonthName], count(o.order_id) from sales.orders as o WHERE 
    YEAR( o.order_date) = 2016 group by   DATENAME(MONTH, o.order_date) 


/*
	8. Calculate the total revenue generated from each product category
*/


SELECT 
	c.category_id
    ,c.category_name
    ,SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.order_items as oi
inner join production.products as p 
ON oi.product_id = p.product_id
inner join production.categories as c 
ON p.category_id = c.category_id
GROUP BY c.category_id,c.category_name
order by 1


/*
9.Find the total number of customers in each state.
*/
select state,count(customer_id) as customers from sales.customers group by state


/*
10.Calculate the total quantity of products sold in each year
*/

select year(order_date) as [year],count(oi.quantity ) [Total quantity]
from sales.orders as o
inner join sales.order_items as oi
on o.order_id = oi.order_id
group by year(order_date)
order by 1
-----------------------------------------------------------------------------------------------------
/*
1. Retrieve all orders along with the product details.
*/


select
    o.order_id,
    o.order_date,
    p.product_name,
    c.category_name,
    b.brand_name
from sales.orders o
inner join sales.order_items oi 
ON o.order_id = oi.order_id
inner join production.products p 
ON oi.product_id = p.product_id
inner join production.categories c 
ON p.category_id = c.category_id
inner join production.brands b ON 
p.brand_id = b.brand_id
order by o.order_id

/*
2. List all customers along with the orders they have placed.
*/

select 
c.customer_id,  c.first_name + ' ' + c.last_name as Name, o.order_id, o.order_date
from sales.customers as c
left outer  join sales.orders as o
on c.customer_id = o.customer_id

/*
3. Find all products that have never been ordered
*/

select * from production.products
select * from sales.orders

select * from sales.order_items

select p.product_id,p.product_name,oi.order_id 
from production.products as p
full outer join sales.order_items as oi
on p.product_id = oi.product_id 
where oi.order_id is null
order by 1

/*
	4. Retrieve the details of all orders along with the store and staff details
*/

select * from sales.orders
select * from sales.staffs
select * from sales.stores

select o.order_id, stf.staff_id, stf.first_name + ' '+ stf.last_name as [Staff Name], sto.store_id, sto.store_name
from sales.orders as o
left outer join sales.staffs as stf
on o.staff_id = stf.staff_id
left outer join sales.stores as sto
on o.store_id  = sto.store_id

/*
5. List all products along with their brand and category names.
*/
select * from production.products
select * from production.brands
select * from production.categories

select 
p.product_name,b.brand_name,c.category_name
from production.products p
inner join production.brands b 
ON p.brand_id = b.brand_id
inner join production.categories c 
ON p.category_id = c.category_id
ORDER BY p.product_name;

/*
6. Find all customers who have placed more than 5 orders.
*/

select c.customer_id,c.first_name + ' ' + c.last_name as name, count(o.order_id) AS total_orders
from sales.customers c
inner join sales.orders o ON c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name, c.email, c.phone
having COUNT(o.order_id) > 5

/*
7. Retrieve the details of all orders placed by customers from California (CA).
*/

select c.customer_id,c.first_name + ' ' + c.last_name as name, c.state
from sales.customers c
inner join sales.orders o ON c.customer_id = o.customer_id
where c.state = 'CA'


/*
8. List all products along with the total quantity sold for each product.
*/

select p.product_id, p.product_name, SUM(oi.quantity) AS [total quantity sold]
from production.products p
inner join sales.order_items as oi 
on p.product_id = oi.product_id
group by p.product_id, p.product_name
order by [total quantity sold] desc;


/*
9. Find all orders that include products from the 'Electric Bikes' category.
*/

SELECT 
    o.order_id,o.order_date,p.product_id,p.product_name,c.category_name
from sales.orders o
inner join sales.order_items oi 
on o.order_id = oi.order_id
inner join production.products p 
on oi.product_id = p.product_id
inner join production.categories c 
on p.category_id = c.category_id
where c.category_name = 'Electric Bikes'

/*
10. Retrieve the details of all orders along with the total discount applied.
*/

select o.order_id,o.order_date,SUM(oi.quantity * oi.list_price * (oi.discount)) AS total_discount
from sales.orders o
inner join sales.order_items oi ON o.order_id = oi.order_id
group by o.order_id, o.order_date, o.required_date, o.shipped_date, o.order_status
order by 1,3 desc;

------------------------------------------------------------------------------------
/*
1. Find the product with the second highest list price.
*/
select list_price from production.products order by 1 desc

select  p.product_id,p.product_name,p.list_price
from production.products p
where p.list_price = ( select max(list_price) from production.products where list_price not in (select max(list_price) from production.products))


/*
2. Retrieve the details of the most expensive product in each category.
*/

select p.product_id,p.product_name,p.list_price,c.category_name
from production.products p
inner join production.categories c on p.category_id = c.category_id
where p.list_price = (select max(list_price) from production.products where category_id = p.category_id)
order by c.category_name;


/*
3. Find all customers who have never placed an order.
*/


select c.customer_id,c.first_name,o.order_id, o.customer_id from sales.customers as c
right outer join sales.orders as o
on c.customer_id = o.customer_id

select c.customer_id,c.first_name,c.last_name
from sales.customers as c
left join sales.orders as o on c.customer_id = o.customer_id
where o.order_id IS NULL;

SELECT 
    c.customer_id,c.first_name,c.last_name
FROM sales.customers as c
WHERE NOT EXISTS (SELECT 1 FROM sales.orders as o WHERE o.customer_id = c.customer_id);

SELECT c.customer_id,c.first_name,c.last_name
FROM sales.customers as c
WHERE c.customer_id NOT IN (SELECT o.customer_id FROM sales.orders o);

/*
4. List all products that have been ordered more than 10 times.
*/


SELECT p.product_id,p.product_name
FROM production.products p
WHERE p.product_id IN 
(SELECT oi.product_id FROM sales.order_items oi GROUP BY oi.product_id HAVING count(oi.order_id) > 10);

/*
5. Retrieve the details of the latest order placed by each customer.
*/


WITH LatestOrders AS (
SELECT o.order_id as order_id,o.customer_id as customer_id,o.order_date as order_date,
ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC) AS rn
FROM sales.orders o
)
SELECT  order_id,customer_id,order_date  FROM LatestOrders as lo
WHERE lo.rn = 1
order by order_id;

/*
6. Find the total revenue generated from orders placed in the first quarter of 2016.
*/

SELECT SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM sales.order_items as oi
WHERE oi.order_id IN (SELECT o.order_id FROM sales.orders as o WHERE o.order_date BETWEEN '2016-01-01' AND '2016-03-31');


/*
7. List all products that have a list price higher than the average list price.
*/

SELECT p.product_id,p.product_name, p.list_price
FROM production.products p
WHERE p.list_price > (SELECT AVG(list_price) FROM production.products);

/*
8. Retrieve the details of all orders placed in the last month.
*/

select  order_id,convert(varchar(20),order_date,106) as [month]
from sales.orders
where month(order_date)=12
order by 1


/*
9. Find the customer who has placed the highest number of orders.
*/




select 
c.customer_id,c.first_name,c.last_name,
count(o.order_id) as total_orders
from sales.customers c
inner join sales.orders as o on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name
having count(o.order_id) = (
select max(order_count)
from(select count(*) as order_count
from sales.orders
group by customer_id) as subquery);

/*
10. List all products that belong to brands that have more than 5 products
*/

select p.product_id,p.product_name,p.list_price,p.brand_id
from production.products p
where p.brand_id IN (select brand_id from production.products group by brand_id having count(*) > 5);
-------------------------------------------------------------------------------------------------------------------------

/*
1. Calculate the total revenue generated from each customer
*/

select 
o.customer_id,c.first_name+' '+c.last_name as [Full name],sum(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
from sales.orders o
inner join sales.order_items oi on o.order_id = oi.order_id
inner join production.products p on oi.product_id = p.product_id
inner join sales.customers c on o.customer_id = c.customer_id
group by o.customer_id, c.first_name+' '+c.last_name 



/*
2. Find the top 5 products with the highest total sales.
*/

with cte_duplicates as (
select oi.product_id,p.product_name,
sum(oi.quantity * oi.list_price * (1 - oi.discount)) as Sales,
DENSE_RANK() over (order by sum(oi.quantity * oi.list_price * (1 - oi.discount)) desc) as dense_nums
from sales.order_items oi
inner join production.products p on oi.product_id = p.product_id
group by oi.product_id, p.product_name
)
select * 
from cte_duplicates
where dense_nums <= 5;

/*
3. Retrieve the details of all orders that include more than 3 different products.
*/
select  o.order_id,o.customer_id,o.order_date
from sales.orders o
inner join sales.order_items oi on o.order_id = oi.order_id
group by o.order_id, o.customer_id, o.order_date
having count(distinct oi.product_id) > 3;

/*
4. Calculate the total discount given to each customer.
*/
select 
o.customer_id,c.first_name,c.last_name,
sum(oi.quantity * oi.list_price * oi.discount) as total_discount
from  sales.orders o
inner join sales.order_items oi on o.order_id = oi.order_id
inner join sales.customers c on o.customer_id = c.customer_id
group by o.customer_id, c.first_name, c.last_name;

/*
5. Find the average list price of products for each brand.
*/

select b.brand_name,AVG(p.list_price) as average_list_price
from production.products p
inner join production.brands b on p.brand_id = b.brand_id
group by b.brand_name
order by 2

/*
6. Retrieve the details of all orders placed in the last 7 days
*/
select top 7 * from sales.orders order by order_date desc

/*
7. Find the total quantity of products sold in each store.
*/
select s.store_id,s.store_name,sum(oi.quantity) as total_quantity_sold
from sales.stores s
inner join sales.orders o on s.store_id = o.store_id
inner join sales.order_items oi on o.order_id = oi.order_id
group by s.store_id, s.store_name
order by 1;

/*
8. Calculate the total revenue generated from each product in each year
*/
select
p.product_name,p.model_year,sum(ot.quantity * ot.list_price * (1-ot.discount)) as [Revenue]
from [production].[products] as p
inner join  sales.order_items as ot 
on p.product_id = ot.product_id
group by p.product_name,p.model_year

/*
9. Find the top 3 customers with the highest total order value.
*/

select top 3 customer_id,count(order_id) as [count]   from sales.orders 
group by customer_id

/*
10. Retrieve the details of all orders that include products from more than one category
*/


with cte_ord as ( select order_id ,count(product_id) as [count]  from sales.order_items
group by order_id)
select * from cte_ord
where [count]  > 3
--------------------------------------------------------------------------------------

/*
1. Insert a new product into the products table.
*/
insert into production.products (product_name, brand_id, category_id, model_year, list_price)
select 'tesla 1177', 1, 3, 2025, 799.99


/*
2. Update the list price of all products in the 'Road Bikes' category by 10%
*/

update production.products
set list_price = list_price * 1.10
where category_id = (select category_id from production.categories where category_name = 'Road Bikes');

/*
3. Delete all orders placed before 2016.
*/

delete from sales.orders
where order_date < '2016-01-01';

/*
4. Insert a new customer into the customers table
*/

insert into sales.customers (first_name, last_name, phone, email, street, city, state, zip_code)
select'neil', 'tyson', '1234567890', 'neil.tyson@example.com', '123 Main St', 'Anytown', 'CA', '12345'
select * from sales.customers order by 1 desc
/*
5. Update the email address of a customer.
*/

update sales.customers
set email = 'newemail@example.com'
where customer_id = 1445;

/*
6. Delete a product from the products table
*/
select * from production.products

delete from production.products where product_id = 322

/*
7. Insert a new order into the orders table.
*/

insert into sales.orders (customer_id, order_status, order_date, required_date, store_id, staff_id)
select  1, 1, '2025-01-07', '2025-01-14', 2, 3

/*
8. Update the quantity of a product in an order
*/
update sales.order_items
set quantity = 5
where order_id = 1 ;

select * from sales.order_items

/*
9. Delete a customer from the customers table
*/
delete from sales.customers
where customer_id = 1;

/*
10. Insert a new category into the categories table.
*/
insert into production.categories (category_name)
select 'Electric cars'
-----------------------------------------------------------------------------------------------------------------
/*
1. Create a function to calculate the total sales for a given product.
*/
create proc CalculateTotalSalesForProduct
    @ProductID int
as
begin
    -- Declare a variable to store the total sales
    declare @TotalSales decimal(18, 2);
    
    -- Calculate the total sales for the given product
    select @TotalSales = sum(oi.quantity * oi.list_price)
    from sales.order_items oi
    where oi.product_id = @ProductID;

    -- Return the total sales
    select @TotalSales as TotalSales;
end;

EXEC CalculateTotalSalesForProduct @ProductID = 1;

/*
2. Write a stored procedure to retrieve all orders for a given customer
*/

