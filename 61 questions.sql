-- 64 questions
show tables;
use ecom;
-- 1. List all the data in the classic models database tables

-- a) contactperson123 table
select * from contactperson123;
describe contactperson123;
select count(customername) from contactperson123;

-- b) customers table
select * from customers;
describe customers;
select count(customernumber) from customers;

-- c) employee_view
select * from employee_view;
describe employee_view;
select count(employeenumber) from employee_view;

-- d) employees
select * from employees;
describe employees;
select count(employeenumber) from employees;

-- e) offices 
select * from offices;
describe offices;
select count(officecode) from offices;

-- f) orderdetails
select * from orderdetails;
describe orderdetails;
select count(ordernumber) from employees;

-- g) orders
select * from orders;
describe orders;
select count(ordernumber) from employees;

-- h) payments 
select * from payments;
describe payments;
select count(customernumber) from employees;

-- i) productlines
select * from productlines;
describe productlines;
select count(productline) from employees;

-- j) products
select * from products;
describe products;
select count(productcode) from employees;

-- 2.	Select customer name from customer. Sort by customer name
select customername from customers order by customername;

-- 3.	List each of the different status that an order may be in (6)
select distinct(status) from orders;

-- 4.	List firstname and lastname for each employee. Sort by lastname then firstname (23)
select contactfirstname, contactlastname from customers order by contactlastname, contactfirstname;

-- 5.	List all the employee job titles (7)
select distinct jobtitle from employees;

-- 6.	List all products along with their product scale (110)
select productname, productscale from products;

-- 7.	List all the territories where we have Offices (4)
select distinct territory from offices;

-- WHERE Clause
-- 8.	select contact firstname, contact lastname and credit limit for all Customers where credit limit > 50000 (85)
select contactfirstname, contactlastname, creditlimit from customers where creditlimit > 50000;

-- 9.	select Customers who do not have a credit limit (0.00) (24)
select customername from customers where creditlimit = 0.00;

-- 10.	List all Offices not in the USA (4)
select * from offices where country != "USA";

-- 11.	List Orders made between June 16, 2014 and July 7, 2014 (8)
select * from orders where orderdate between "2014-06-16 " and "2014-07-07";

-- 12.	List products that we need to reorder (quantityinstock < 1000) (12)
select productname, quantityinstock from products where quantityinstock < 1000;

-- 13.	List all Orders that shipped after the required date (1)
select * from orders where shippeddate > requireddate;

-- 14.	List all Customers who have the word 'Mini' in their name (10)
select customername from customers where customername like "%mini%";

-- 15.	List all products supplied by 'Highway 66 Mini Classics' (9)
select productname from products where productvendor = "Highway 66 Mini Classics";

-- 16.	List all product not supplied by 'Highway 66 Mini Classics' (101)
select productname from products where productvendor != "Highway 66 Mini Classics";

-- 17.	List all employees that don't have a manager (1)
select firstname, lastname from employees where reportsto is null;

-- 18.	Display every order along with the details of that order for order numbers 10270, 10272, 10279 (23)
select * from orders natural join orderdetails where ordernumber in (10270, 10272, 10279);
select * from orderdetails od join orders o on o.ordernumber = od.ordernumber where o.ordernumber in (10270, 10272, 10279);

-- 19.	List of ProductLines and vendors that supply the products in that productline. (65)
select distinct productvendor, productline from productlines natural join products order by productvendor;

-- 20.	select Customers that live in the same state as one of our Offices (26)
select c.customername from customers c join offices o on c.state = o.state;
select customername from customers where state in (select state from offices);

-- 21.	select Customers that live in the same state as their employee representative works (26)
select c.customername from customers c join employees e on c.salesrepemployeenumber = e.employeenumber 
join offices os on os.officecode = e.officecode where c.state = os.state;

-- 22.	select customerName, orderDate, quantityOrdered, productLine, productName for all Orders made and shipped in 2015 (444)
select c.customerName, o.orderDate, od.quantityOrdered, p.productLine, p.productName from customers c join orders o
on c.customernumber = o.customernumber join orderdetails od on o.ordernumber = od.ordernumber join products p 
on od.productcode = p.productcode where orderdate like "2015%" and shippeddate like "2015%";

-- 23.	List products that didn't sell (1)
select p.productname from products p left join orderdetails od on p.productcode = od.productcode where od.productcode is null;
select productname from products where productcode not in (select productcode from orderdetails);

-- 24.	List all Customers and their sales rep even if they don't have a sales rep (122)
select distinct c.customername, e.lastname, e.firstname from customers c left join employees e on c.salesrepemployeenumber = e.employeenumber ;

-- 25.	Find the total of all Payments made by each customer (98)
select c.customername, count(p.customernumber) from customers c join payments p on c.customernumber = p.customernumber group by c.customername;

-- 26.	Find the largest payment made by a customer (1)
select max(amount) from payments;

-- 27.	Find the average payment made by a customer (1)
select avg(amount) from payments;

-- 28.	What is the total number of products per product line (7)
select productline, count(productname) as total_products from products group by productline;

-- 29.	What is the number of Orders per status (6)
select status, count(ordernumber) as total_orders from orders group by status;

-- 30.	List all Offices and the number of employees working in each office (7)
select * from offices;
select officecode, count(employeenumber) as total_employee from employees group by officecode;

-- 31.	List the total number of products per product line where number of products > 3 (6)
select productline, count(productname) as total_products from products group by productline having total_products > 3;

-- 32.	List the orderNumber and order total for all Orders that totaled more than $60,000.00.
select ordernumber, sum(quantityordered * priceeach) as total_price from orderdetails group by ordernumber having total_price > 60000;

-- 33.	List the products and the profit that we have made on them.  
--      The profit in each order for a given product is (priceEach - buyPrice) * quantityOrdered.  
--      List the product's name and code with the total profit that we have earned selling that product.  
--      Order the rows descending by profit. 
--      Only show those products whose profit is greater than $60,000.00. (11)
select p.productname, p.productcode, sum((priceeach - buyprice) * quantityordered) as Total_profit from orderdetails od join products p
on od.productcode = p.productcode group by p.productname, p.productcode having Total_profit > 60000 order by Total_profit desc;

-- 34.	List the average of the money spent on each product across all Orders 
--      where that product appears when the customer is based in Japan.  
--      Show these products in descending order by the average expenditure (45).
select p.productname, avg(priceeach * quantityordered) as avg_spend from customers c join orders o on c.customernumber = o.customernumber
join orderdetails od on o.ordernumber = od.ordernumber join products p on od.productcode = p.productcode 
where c.country = "Japan" group by p.productname order by avg_spend desc;

-- 35.	What is the profit per product (MSRP-buyprice) (110)
select productname, (msrp - buyprice) as profit from products order by profit desc;

-- 36.	List the Customer Name and their total Orders (quantity * priceEach) 
--      across all Orders that the customer has ever placed with us,
--      in descending order by order total 
--      for those Customers who have ordered more than $100,000.00 from us. (32)
select c.customername, sum(od.quantityordered * od.priceeach) as total_spend from customers c join orders o
on o.customernumber = c.customernumber join orderdetails od on od.ordernumber = o.ordernumber 
group by customername having total_spend > 100000 order by total_spend desc;

-- 37.	List all Customers who didn't order in 2015 (78)
select distinct c.customername from customers c join orders o on c.customernumber = o.customernumber where year(orderdate) != 2015;

-- 38.	List all people that we deal with (employees and customer contacts). 
--      Display first name, last name, company name (or employee) (145)
select customername as `company name`, contactlastname as `last name`, contactfirstname as `first name` from customers 
union
select 'employee' as `company name`, lastname as `last name`, firstname as `first name` from employees;

-- 39.	List the last name, first name, and employee number of all of the employees who do not have any Customers.  
--      Order by last name first, then the first name. (8)
select lastname, firstname, e.employeenumber from employees e left join customers c on c.salesrepemployeenumber = e.employeenumber 
where c.salesrepemployeenumber is null order by lastname, firstname;

-- 40.	List the states and the country that the state is part of that have 
--      Customers but not Offices, 
--      Offices but not Customers,
--      or both one or more Customers and one or more Offices all in one query.  
--      Designate which state is which with the string 'Customer', 'Office', or 'Both'.  
--      If a state falls into the "Both" category, do not list it as a Customer or an Office state.
--      Order by the country, then the state.
--      Give the category column (where you list 'Customer', 'Office', or 'Both') a header of "Category"
--      and exclude any entries in which the state is null. (19)

-- 41.	List the Product Code and Product name of every product that has never been 
--      in an order in which the customer asked for more than 48 of them.  
--      Order by the Product Name.  (8)
select distinct productcode, productname from products where productcode not in
(select productcode from orderdetails where quantityordered > 48) order by productname;

-- 42.	List the first name and last name of any customer who ordered any products
--      from either of the two product lines 'Trains' or 'Trucks and Buses'.
--      Do not use an "or".
--      Instead perform a union.  
--      Order by the customer's name.  (61)
select distinct c.contactfirstname, c.contactlastname from customers c join orders o on c.customernumber = o.customernumber 
join orderdetails od on od.ordernumber = o.ordernumber join products p on p.productcode = od.productcode 
where p.productline = "Trains"
union
select distinct c.contactfirstname, c.contactlastname from customers c join orders o on c.customernumber = o.customernumber 
join orderdetails od on od.ordernumber = o.ordernumber join products p on p.productcode = od.productcode 
where p.productline = "Trucks and Buses" order by contactfirstname, contactlastname;

-- 43.	List the name of all Customers who do not live in the same state and country with any other customer.
select customername from customers where (state, country) in 
(select state, country from customers group by state, country having count(customername) = 1);

-- 44.	What product that makes us the most money (qty*price) (1)
select productname from products natural join orderdetails group by productname having sum(quantityordered * priceeach) = 
(select max(e.sum_price) from (select productcode, sum(quantityordered * priceeach) as sum_price from orderdetails group by productcode) as e);

-- 45.	List the product lines and vendors for product lines which are supported by < 5 vendors (3)
select * from productlines;
select * from products;
select pl.productline, p.productvendor from productlines pl natural join products p where p.productline in 
(select p.productline from products p group by p.productline having count(productvendor) < 5);

-- 46.	List the products in the product line with the most number of products (38)
select productname from products where  productline = (select productline from products group by productline having count(productcode) =
(select max(p.count) from (select productline, count(productcode) as count from products group by productline) as p));

-- 47.	Find the first name and last name of all customer contacts
--      whose customer is located in the same state as the San Francisco office. (11)
select * from customers;
select * from employees;
select * from offices;
select contactfirstname, contactlastname from customers where state = (select state from offices where city = "San Francisco");

-- 48.	What is the customer and sales person of the highest priced order? (1)
select * from orders;
select * from customers;
select * from orderdetails;
select customername, salesrepemployeenumber from customers where customernumber in (select customernumber from orders where ordernumber in 
(select ordernumber from orderdetails group by ordernumber having sum(quantityordered * priceeach) = 
(select max(k.sum_price) from (select sum(quantityordered * priceeach) as sum_price, ordernumber from orderdetails group by ordernumber) as k)));

-- 49.	What is the order number and the cost of the order for the most expensive Orders?
--      Note that there could be more than one order which all happen to add up to the same cost,
--      and that same cost could be the highest cost among all Orders. (1)
select ordernumber, sum(quantityordered * priceeach) as total_price from orderdetails group by ordernumber having total_price = 
(select max(k.sump) from (select ordernumber, sum(quantityordered * priceeach) as sump from orderdetails group by ordernumber) as k); 

-- 50.	What is the name of the customer, the order number,
--      and the total cost of the most expensive Orders? (1)
select customername, ordernumber, sum(quantityordered * priceeach) as `highest order` from customers natural join orders natural join orderdetails
group by ordernumber, customername having `highest order` = (select max(k.sump) from 
(select ordernumber, sum(quantityordered * priceeach) as sump from orderdetails group by ordernumber) as k);

-- 51.	Perform the above query using a view. (1)
--    YOU NEED TO RUN BOTH QUERIES BELOW:
--    However, in derby, there is no "OR REPLACE" so after the first time you
--    create the below view table, theres no way to replace it in the case
--    that some other order becomes the highest price order besides manually
--    dropping the view and running it again
create view `max order value` as 
(select ordernumber from orderdetails group by ordernumber having sum(quantityordered * priceeach) = 
(select max(k.summ) from (select ordernumber, sum(quantityordered * priceeach) as summ from orderdetails group by ordernumber) as k));
select customername, ordernumber, sum(quantityordered * priceeach) as `largest order` from customers natural join orders natural join orderdetails
group by ordernumber, customername having ordernumber in (select ordernumber from `max order value`);

-- 52.	Show all of the Customers who have ordered at least one product
--      with the name "Ford" in it, that "Dragon Souveniers, Ltd." has also ordered.  
--      List them in reverse alphabetical order,
--      and do not consider the case of the letters in the customer name in the ordering.
--      Show each customer no more than once. (61)
select distinct customername from customers natural join orders natural join orderdetails natural join products where productcode in 
(select productcode from products where productname like "%ford%" and productcode in (select productcode from products natural join orderdetails
natural join orders natural join customers where customername = "Dragon Souveniers, Ltd.")) order by customername desc;

-- 53.	Which products have an MSRP within 5% of the average MSRP across all products?
--      List the Product Name, the MSRP, and the average MSRP ordered by the product MSRP. (14)
select productname, msrp, avg_msrp from 
(select productname, msrp, (select avg(msrp) from products) as avg_msrp from products) a where msrp 
between (avg_msrp - (avg_msrp *0.05)) and (avg_msrp *1.05) order by msrp;

-- 54.	List all of the Customers who have never made a payment on the same date as another customer. (57)
select * from customers;
select * from payments;
select distinct customername from customers where customernumber in 
(select p1.customernumber from payments p1, payments p2 where p1.paymentdate = p2.paymentdate and p1.customernumber != p2.customernumber);

-- 55.	Find Customers who have ordered the same thing.
--      Find only those customer pairs who have ordered the same thing as each other at least 201 times (1)
with cte as (select customernumber, productcode from orders natural join orderdetails)
select e1.customernumber , e2.customernumber from cte e1 join cte e2 on e1.customernumber = e2.customernumber
where e1.productcode = e2.productcode and e1.customernumber != e2.customernumber group by e1.customernumber, e2.customernumber;

-- 56.	What is the manager who manages the greatest number of employees (2)
select employeenumber, lastname, firstname from employees where employeenumber = 
(select reportsto from employees group by reportsto having count(employeenumber) =
(select max(count1) from (select reportsto, count(employeenumber) as count1 from employees group by reportsto) as t));

-- 57.	Select all employees who work for the manager that manages the greatest number of employee (12)
select employeenumber, lastname, firstname from employees where reportsto in 
(select reportsto from employees group by reportsto having count(employeenumber) =
(select max(count1) from (select reportsto, count(employeenumber) as count1 from employees group by reportsto) as t));

-- 58.	List all employees that have the same last name. Make sure each combination is listed only once (5)
select a.lastname, a.firstname, b.lastname, b.firstname from employees a join employees b
on a.lastname = b.lastname where a.firstname > b.firstname;

-- 59.	Select the name of each of two Customers who have made at least one payment on the same date as the other.
--      Make sure that each pair of Customers only appears once. (46)
select * from payments;
select a.customernumber, a.paymentdate, b.customernumber, b.paymentdate from payments a join payments b
on a.paymentdate = b.paymentdate where a.customernumber < b.customernumber;

-- 60.	Find Customers that share the same state and country.
--      The country must be one of the following: UK, Australia, Italy or Canada.
--      Remember that not all countries have states at all, so you need to substitute
--       a character sting like 'N/A' for the state in those cases so that you can compare the states.

with cte as (
select customername, customernumber, country, case when state is not null then state else "N/A" end as new_state from customers)
select c1.customername, c2.customername from cte c1 join cte c2 on c1.country = c2.country and c1.new_state = c2.new_state 
where c1.country in ("UK", "Australia", "Italy", "Canada") and c1.customername > c2.customername;

-- 61.	Find all of the Customers who have the same sales representative as some other customer,
--      and either customer name has 'Australian' in it.
--      List each of the Customers sharing a sales representative, and the name of the sales representative.
--      Order by the name of the first customer, then the second.  Do not show any combination more than once. (9)
with cte as (
select a1.customername as c1, a2.customername as c2, a1.salesrepemployeenumber from customers a1 join customers a2 on 
a1.salesrepemployeenumber = a2.salesrepemployeenumber where (a1.customername like "%Australian%" or a2.customername like "%Australian%") 
and a1.customername > a2.customername)
select c1, c2, lastname, firstname from cte join employees on cte.salesrepemployeenumber = employees.employeenumber 
order by c1, c2;