create database practice_2;
use practice_2;

CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, "Rahul", "Mumbai"),
(2, "Anjali", "Delhi"),
(3, "Rohit", "Pune"),
(4, "Neha", "Mumbai"),
(5, "Aman", "Bangalore");

CREATE TABLE Orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount INT
);

INSERT INTO Orders VALUES
(101, 1, "2024-01-10", 5000),
(102, 2, "2024-01-12", 3000),
(103, 1, "2024-01-15", 7000),
(104, 3, "2024-01-18", 2000),
(105, 6, "2024-01-20", 4000);

CREATE TABLE Products (
product_id INT PRIMARY KEY,
product_name VARCHAR(50),
price INT
);

INSERT INTO Products VALUES
(201, "Laptop", 60000),
(202, "Mobile", 25000),
(203, "Headphones", 3000),
(204, "Keyboard", 1500);

CREATE TABLE Order_Items (
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT
);

INSERT INTO Order_Items VALUES
(1, 101, 201, 1),
(2, 101, 203, 2),
(3, 102, 202, 1),
(4, 103, 204, 3),
(5, 104, 203, 1);

CREATE TABLE Employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
manager_id INT
);

INSERT INTO Employees VALUES
(1, "Ramesh", NULL),
(2, "Suresh", 1),
(3, "Mahesh", 1),
(4, "Dinesh", 2);

-- 1
select c.customer_name, o.order_id from customers c inner join orders o on c.customer_id = o.customer_id;

-- 2
select c.customer_name, o.order_id, o.total_amount from customers c 
inner join orders o on c.customer_id = o.customer_id;

-- 3
select c.customer_name from customers c inner join orders o on c.customer_id = o.customer_id;

-- 4
select p.product_name, oi.quantity from products p inner join order_items oi on p.product_id = oi.product_id;

-- 5
select o.order_id, o.total_amount, o.order_date, o.customer_id, oi.product_id, oi.order_item_id, oi.quantity, p.price
from orders o inner join order_items oi on o.order_id = oi.order_id 
inner join products p on p.product_id = oi.product_id;

-- 6
select o.total_amount, c.city from customers c right join orders o on c.customer_id = o.customer_id;

-- 7
select oi.order_id from order_items oi inner join products p on oi.product_id = p.product_id 
where p.price > 2000;

-- 8
select c.customer_name, o.order_date from customers c right join orders o 
on c.customer_id = o.customer_id;

-- 9
select * from customers c left join orders o on c.customer_id = o.customer_id;

-- 10
select c.customer_name from customers c left join orders o on c.customer_id = o.customer_id 
where o.customer_id is null;

-- 11
select o.order_id from customers c right join orders o on c.customer_id = o.customer_id;

-- 12
select p.product_name, oi.order_id from products p left join order_items oi 
on oi.product_id = p.product_id;

-- 13
select c.customer_name, o.total_amount from customers c left join orders o on c.customer_id = o.customer_id;

-- 14
select e1.emp_name as manager, e2.emp_name as employee from employees e1 right join employees e2 
on e1.emp_id = e2.manager_id;

-- 15
select e1.emp_name as manager, e2.emp_name as employee from employees e1 right join employees e2 
on e1.emp_id = e2.manager_id where e2.manager_id is null;

-- 16
select * from customers c right join orders o on c.customer_id = o.customer_id;

-- 17
select * from customers c right join orders o on c.customer_id = o.customer_id where c.customer_id is null;

-- 18
select * from orders o right join order_items oi on o.order_id = oi.order_id;

-- 19
select e1.emp_name as manager, e2.emp_name as employee from employees e1 right join employees e2 
on e1.emp_id = e2.manager_id;

-- 20
select e1.emp_name as manager, e2.emp_name as employee from employees e1 right join employees e2 
on e1.emp_id = e2.manager_id where e1.emp_name = "Ramesh";

-- 21
select e1.emp_name as manager, e2.emp_name as employee from employees e1 join employees e2 
on e1.emp_id = e2.manager_id;

-- 22
select distinct e1.emp_name as manager from employees e1 join employees e2 
on e1.emp_id = e2.manager_id;

-- 23 doubt
select e2.emp_id from employees e1 inner join employees e2 
on  e1.manager_id = e2.manager_id and e1.emp_id <> e2.emp_id;

-- 24
select c.customer_name, oi.order_id, p.product_name, oi.quantity from customers c inner join orders o 
on c.customer_id = o.customer_id inner join order_items oi on o.order_id = oi.order_id inner join
products p on p.product_id = oi.product_id;

-- 25 doubt
select c.customer_name, sum(o.total_amount) as total_spending from customers c inner join orders o on c.customer_id = o.customer_id
group by o.customer_id;


select c.customer_name, count(o.customer_id) as order_count
from customers c inner join orders o 
on c.customer_id = o.customer_id
group by o.customer_id
having order_count > 1;
-- Having is used with temprory column created with group by

-- 26
select o.order_id, p.product_name, (o.quantity * p.price) as total_amonut from order_items o inner join products p 
on o.product_id = p.product_id;

-- 27 
select c.customer_name, count(oi.order_id) from customers c join orders o on c.customer_id = o.customer_id 
inner join order_items oi 
on oi.order_id = o.order_id group by o.customer_id;

-- 28
select c.city, sum(o.total_amount) from customers c inner join orders o on c.customer_id = o.customer_id 
group by o.customer_id;

-- 29
select * from customers cross join products;

-- 30
select c.customer_name, sum(o.total_amount) from customers c inner join orders o 
on c.customer_id = o.customer_id inner join order_items oi on o.order_id = oi.order_id join products p
on p.product_id = oi.product_id 
group by o.customer_id having sum(o.total_amount) > sum(p.price);