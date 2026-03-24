use ecom;

select * from employees;

select employeenumber, firstname, email, jobtitle from employees where jobTitle = 'Sales Rep';

select employeenumber, firstname, lastname, officecode from employees where reportsto = '1143';

select * from employees where officecode != 5 and officecode > 3;

select * from offices;

select * from offices where country = 'USA';

select * from offices where territory != 'NA';

select * from orderdetails;

select * from orderdetails where quantityOrdered > 30;

select * from orderdetails where priceEach > 100;

select * from orders;

select * from orders where status = 'Cancelled';

select * from orders where status = 'Shipped';

select * from orders where status = 'On Hold';

select * from orders where status = 'Resolved';

select * from orders where status = 'Disputed';

select * from orders where status = 'In Process';

select * from payments;

select customernumber, amount from payments;

select * from productlines;

select * from products;

select * from products where MSRP > 100.00 and buyprice < 65;

select * from employees;
describe employees;

alter table employees add column city varchar(30) not null default "Bhopal";

insert into employees(city) values
('New York'),
('Paris'),
('San Francisco'),
('New York');

insert into employees(employeeNumber, lastname, firstname, extension, email, officeCode, reportsTo, jobTitle, city) values
(1011, 'Martin', 'Rob', 'x4567', 'rrmartin@classicmodelcars.com', 2, 1143, 'Sales Rep', 'New York'),
(1111, 'Nolan', 'Chris', 'x7800', 'nolanchris@classicmodelcars.com', 1, 1056, 'Sales Rep', 'Paris');

alter table employees drop column city;

alter table employees modify column lastname varchar(70) not null;

update employees set city = 'Bhopal' where employeeNumber = 1401;

select * from customers;

select customerNumber, contactLastName, city, country, creditlimit from customers 
where creditLimit >= 50000 and 
(country = 'France' or country = 'USA');

show tables;
select * from employees;

select * from employees where (reportsTo = 1056 or reportsTo = 1143) and officeCode >= 3;

select * from products;

select productCode, ProductName, productDescription, quantityInStock, buyPrice, MSRP
from products where productline = "Classic Cars";

select * from orders;
select * from orders where status = "Shipped";

select * from orders where ordernumber > 10150;

select * from orderdetails;

show tables;

select * from customers;

select customerNumber, contactLastName, city, country, creditlimit from customers 
where customerNumber > 150 and customerNumber < 400 and ( country = 'France' or (city = 'Las Vegas' or city = 'NYC'));

select customerNumber, contactLastName, city, country, creditlimit from customers 
where city = 'Las Vegas' or city = 'NYC';

use ecom;

show tables;

select * from employees;
select * from customers;

select * from customers inner join
employees on employees.employeeNumber = customers.salesRepEmployeeNumber;

select e.firstName, e.lastName, e.jobTitle, c.customerNumber, c.customerName, 
c.salesRepEmployeeNumber, c.city
from employees e 
inner join customers c
on e.employeeNumber = c.salesRepEmployeeNumber;

select od.orderNumber, od.productCode, od.quantityOrdered, od.priceEach, 
o.status, o.customerNumber
from orders as o
left join orderdetails as od
on od.orderNumber = o.orderNumber;

select c.customerNumber, c.customerName, c.city, c.country, p.paymentDate, p.amount
from customers c
left join payments p
on c.customernumber = p.customernumber;

select c.customerNumber, c.customerName, c.city, c.country, p.paymentDate, p.amount
from customers c
left join payments p
on c.customernumber = p.customernumber
union
select c.customerNumber, c.customerName, c.city, c.country, p.paymentDate, p.amount
from customers c
right join payments p
on c.customernumber = p.customernumber;

select c.customerNumber, c.customerName, c.city, c.country, p.paymentDate, p.amount
from customers c
right join payments p
on c.customernumber = p.customernumber;