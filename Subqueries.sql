-- subqueries :- A query inside a query is called subquery

use ecom;
show tables;
select * from customers;
select * from orders;
select * from orderdetails;
select * from payments;

select * from customers where customernumber in (select customernumber
from orders o join orderdetails od on o.ordernumber = od.ordernumber where (quantityordered * priceeach) > 5000);
-- select operand in inner query allows only one 1 column

-- 1
select * from customers where creditlimit > (select avg(creditlimit) from customers) limit 5;

-- 2
select * from customers where creditlimit = (select max(creditlimit) from customers);

-- 3 
select * from customers where customernumber in (select customernumber from orders);

-- 4
select * from customers where customernumber not in (select customernumber from payments);

-- 5
select * from customers where creditlimit > (select creditlimit from customers where city = "New York");

select * from customers where city = "New York";

-- 6 doubt
select * from customers where (select c.customernumber from customers c join orders o 
on o.customernumber = c.customernumber group by c.customernumber order by count(ordernumber) desc);

-- correct query of 6
select customernumber from orders group by customernumber having count(ordernumber) = (select max(order_count) from 
(select count(ordernumber) as order_count from orders group by customernumber) as ordercount);
 
select * from orders where customernumber = 141;

select customernumber from orders group by customernumber order by count(ordernumber) desc;

-- 7
select * from customers where customernumber not in (select customernumber from orders);

select * from customers c left join orders o on c.customernumber = o.customernumber where o.customernumber is null;

-- 8
select * from customers where customernumber in (select customernumber from orders) 
and customernumber not in (select customernumber from payments);

-- correct query for 9
select customernumber from payments group by customernumber having sum(amount) = (select max(total_amount) from
(select sum(amount) as total_amount from payments group by customernumber) as max_amount);

select * from payments where customernumber = 141;
-- 10
select * from products where productcode not in (select productcode from orderdetails); 

-- 11
select * from products where buyprice = (select max(buyprice) from  products);

-- 12
select p.productline, sum(od.quantityordered * od.priceeach) as total_revenue 
from orderdetails od join products p on p.productcode = od.productcode 
group by p.productline having total_revenue > 
	(select avg(total_revenue) from 
    (select (quantityordered * priceeach) as total_revenue from orderdetails) as avg_revenue);

-- '*' gives unidentified data 
select * from customers;

select 1 from customers where country = 'USA';

select * from employees;

create view employee_view as
select lastname, employeenumber from employees where officecode = 1;

select * from employee_view;
drop view employee_view;

-- updatable view :- bidirectional(changes in both table)