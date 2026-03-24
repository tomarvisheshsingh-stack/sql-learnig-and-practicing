create database cte;
use cte;

-- scenario 1
CREATE TABLE employees (
emp_id INT PRIMARY KEY,
name VARCHAR(50),
department VARCHAR(50),
salary INT
);

INSERT INTO employees VALUES
(1, "Rahul", "IT", 60000),
(2, "Anita", "HR", 45000),
(3, "Suresh", "IT", 80000),
(4, "Neha", "Sales",50000),
(5, "Amit", "IT", 70000);

with sce_1 as (
select avg(salary) as avg_salary from employees where department = "IT")
select * from employees e join sce_1 s on e.salary > s.avg_salary where department = "IT";

-- scenario 2
CREATE TABLE sales (
sale_id INT PRIMARY KEY,
sale_date DATE,
amount INT
);
INSERT INTO sales VALUES
(1,'2024-01-05',1200),
(2,'2024-01-15',800),
(3,'2024-02-10',1500),
(4,'2024-02-20',1000);

with sce_2 as(
select month(sale_date), sum(amount) as total_sales from sales group by month(sale_date) having total_sales > 2000)
select * from sce_2;

-- scenerio 3
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE
);

INSERT INTO orders VALUES
(1,101, '2024-01-01'),
(2,101, '2024-01-10'),
(3,102, '2024-01-15'),
(4,103, '2024-01-20'),
(5,101, '2024-02-01');

with sce_3 as (
select customer_id, count(order_id) as total_orders from orders group by customer_id having total_orders > 2)
select * from sce_3;

-- scenerio 4
CREATE TABLE products (
product_id INT PRIMARY KEY,
category VARCHAR(50),
price INT
);

INSERT INTO products VALUES
(1, 'Mobile',15000),
(2, 'Mobile',22000),
(3, 'Laptop',55000),
(4, 'Laptop',65000);

with sce_4 as (
select category, avg(price) as avg_price from products group by category)
select * from products p join sce_4 s on p.price > s.avg_price and p.category = s.category;

-- scenerio 5
CREATE TABLE students (
student_id INT PRIMARY KEY,
name VARCHAR(50),
marks INT
);
INSERT INTO students VALUES
(1, 'Ravi',85),
(2, 'Sneha',72),
(3, 'Arjun',90),
(4, 'Priya',65);

with sce_5 as (
select avg(marks) as avg_marks from students) 
select * from students s join sce_5 s5 on s.marks > s5.avg_marks;

-- scenerio 6
CREATE TABLE users (
user_id INT PRIMARY KEY,
email VARCHAR(100)
);
INSERT INTO users VALUES
(1,'a@gmail.com'),
(2,'b@gmail.com'),
(3,'a@gmail.com');

with sce_6 as (
select email from users group by email having count(email) > 1)
select * from sce_6;

-- scenerio 7
CREATE TABLE expenses (
expense_id INT PRIMARY KEY,
department VARCHAR(50),
amount INT
);
INSERT INTO expenses VALUES
(1, "IT",5000),
(2, "HR",3000),
(3, "IT",7000),
(4, "Sales",4000);

with sce_7 as (
select department from expenses group by department having sum(amount) > 9000)
select * from sce_7;

-- scenerio 8
CREATE TABLE emp_salary (
emp_id INT PRIMARY KEY,
name VARCHAR(50),
salary INT
);
INSERT INTO emp_salary VALUES
(1, 'A',30000),
(2, 'B',50000),
(3, 'C',40000);

with sce_8 as (
select avg(salary) as avg_salary from emp_salary)
select * from emp_salary e join sce_8 s on e.salary > s.avg_salary;

-- scenerio 9
CREATE TABLE logins (
user_id INT,
login_date DATE
);
INSERT INTO logins VALUES
(1, '2024-01-01'),
(2, '2024-01-01'),
(1, '2024-01-02');

with sce_9 as (
select login_date, count(user_id) as `total users that logged on` from logins group by login_date)
select * from sce_9;

-- scenerio 10
CREATE TABLE order_amounts (
order_id INT PRIMARY KEY,
customer_id INT,
amount INT
);
INSERT INTO order_amounts VALUES
(1,101,500),
(2,101,700),
(3,102,1200);

with sce_10 as (
select customer_id from order_amounts group by customer_id having sum(amount) > 1000)
select * from sce_10;