use ecom;
show tables;

-- JOINS

create table table1(id int);
create table table2(id int);

insert into table1(id) values (1), (2), (3), (4), (null), (null);
insert into table2(id) values (1), (1), (2), (3), (3), (null), (null);

select * from table1;
select * from table2;

select * from table1 inner join table2 on table1.id = table2.id;

select * from table1 left join table2 on table1.id = table2.id;

select * from table1 right join table2 on table1.id = table2.id;

select * from table1 cross join table2;

select * from table1 natural join table2;

describe customers;
describe orders;

select * from customers inner join orders on
customers.customernumber = orders.customernumber;

select * from customers left join orders on
customers.customernumber = orders.customernumber;

select * from customers right join orders on
customers.customernumber = orders.customernumber;

select * from customers left join orders on
customers.customernumber = orders.customernumber 
where orders.customernumber is null;

select * from customers right join orders on
customers.customernumber = orders.customernumber 
where customers.customernumber is null;

select * from customers left join orders on
customers.customernumber = orders.customernumber
union
select * from customers right join orders on
customers.customernumber = orders.customernumber;

-- Aliasing -- Table level -- Column level  
select c.customernumber, c.customername, c.country, o.status, o.ordernumber
from customers c inner join orders o 
on c.customernumber = o.customernumber;

select customers.customernumber, customers.customername, customers.country, 
orders.status, orders.ordernumber
from customers inner join orders 
on customers.customernumber = orders.customernumber;

-- if only common column of tables is defined then also I will get the output
select c.customernumber, customername, country, status, ordernumber
from customers c inner join orders o 
on c.customernumber = o.customernumber;

select c.customernumber, c.customername, c.country, o.status, o.ordernumber
from customers c right join orders o 
on c.customernumber = o.customernumber;

select c.customernumber, c.country, o.status
from customers c left join orders o 
on c.customernumber = o.customernumber;


-- questions
select c.customername, od.ordernumber, od.productcode, od.quantityordered,
od.priceeach, od.orderlinenumber from customers c inner join orders o 
on c.customernumber = o.customernumber inner join orderdetails od
on o.ordernumber = od.ordernumber;

select * from customers c left join orders o on
c.customernumber = o.customernumber where o.customernumber = null;

select * from customers c left join orders o on
c.customernumber = o.customernumber;

select * from customers c inner join orders o on
c.customernumber = o.customernumber where c.city = 'Los Angeles';

select * from customers c inner join orders o on
c.customernumber = o.customernumber 
where c.city = 'Chicago' or c.city = 'Los Angeles'
order by orderdate limit 5;

select * from customers c inner join orders o on
c.customernumber = o.customernumber 
where c.city != 'New York' or c.city != 'Miami'
order by orderdate;

select c.customername, (od.quantityordered * od.priceeach) as order_amount 
from customers c inner join orders o 
on c.customernumber = o.customernumber inner join orderdetails od
on o.ordernumber = od.ordernumber where (od.quantityordered * od.priceeach)
between 200 and 500 order by order_amount desc;
-- or
select c.customernumber, c.customername, p.amount from customers c
inner join payments p on c.customernumber =  p.customernumber 
where amount between 200 and 500 order by amount desc;

select * from customers c left join orders o on
c.customernumber = o.customernumber where o.customernumber = null
order by customername;