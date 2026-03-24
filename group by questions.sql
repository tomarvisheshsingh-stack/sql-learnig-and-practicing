create database groupby;
use groupby;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    country VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers (customer_id, customer_name, country, city) VALUES
(1, 'Aryan Sharma', 'India', 'Mumbai'),
(2, 'Priya Patel', 'India', 'Delhi'),
(3, 'John Smith', 'USA', 'New York'),
(4, 'Emily Davis', 'USA', 'Chicago'),
(5, 'Carlos Lopez', 'Mexico', 'Monterrey'),
(6, 'Sophia Lee', 'UK', 'London'),
(7, 'Liam Brown', 'UK', 'Manchester'),
(8, 'Mia Chen', 'China', 'Beijing'),
(9, 'David Kim', 'South Korea', 'Seoul'),
(10, 'Olivia Wilson', 'Australia', 'Sydney');

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 70000.00),
(102, 'Smartphone', 'Electronics', 40000.00),
(103, 'Tablet', 'Electronics', 25000.00),
(104, 'Headphones', 'Accessories', 3000.00),
(105, 'Office Chair', 'Furniture', 8000.00),
(106, 'Desk Lamp', 'Furniture', 2500.00),
(107, 'T-Shirt', 'Clothing', 1200.00),
(108, 'Shoes', 'Clothing', 3500.00);

INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1001, 1, '2025-01-05', 140000.00),
(1002, 2, '2025-01-15', 41000.00),
(1003, 3, '2025-02-10', 78000.00),
(1004, 4, '2025-02-18', 58000.00),
(1005, 5, '2025-03-02', 30000.00),
(1006, 6, '2025-03-12', 55000.00),
(1007, 7, '2025-04-01', 24000.00),
(1008, 8, '2025-04-18', 15000.00),
(1009, 9, '2025-05-10', 22000.00),
(1010, 10, '2025-05-20', 64000.00);

INSERT INTO order_details (order_detail_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 2, 70000.00),
(2, 1002, 104, 2, 3000.00),
(3, 1002, 107, 5, 1200.00),
(4, 1003, 102, 1, 40000.00),
(5, 1003, 103, 1, 25000.00),
(6, 1003, 104, 4, 3000.00),
(7, 1004, 105, 5, 8000.00),
(8, 1004, 106, 2, 2500.00),
(9, 1005, 108, 3, 3500.00),
(10, 1005, 107, 10, 1200.00),
(11, 1006, 103, 2, 25000.00),
(12, 1006, 104, 1, 3000.00),
(13, 1006, 106, 2, 2500.00),
(14, 1007, 107, 8, 1200.00),
(15, 1007, 108, 2, 3500.00),
(16, 1008, 104, 5, 3000.00),
(17, 1008, 106, 2, 2500.00),
(18, 1009, 108, 4, 3500.00),
(19, 1010, 101, 1, 70000.00),
(20, 1010, 104, 2, 3000.00);


-- 1
select c.customer_name, count(o.order_id) as total_orders from customers c join orders o 
on c.customer_id = o.customer_id group by o.customer_id;

-- 2
select c.customer_name, sum(total_amount) as total_amount from customers c join orders o 
on c.customer_id = o.customer_id group by o.customer_id;

-- 3
select c.country, count(o.order_id) as total_orders from customers c join orders o 
on c.customer_id = o.customer_id group by c.country;

-- 4
select c.country, sum(total_amount) as total_amount from customers c join orders o 
on c.customer_id = o.customer_id group by c.country;

-- 5
select c.customer_name, avg(total_amount) as total_Amount from customers c join orders o
on c.customer_id = o.customer_id group by c.customer_name;

-- 6 
select p.product_name, sum(od.quantity) as total_quantity from products p 
inner join order_details od
on od.product_id = p.product_id group by p.product_name;

-- 7 
select p.product_name, sum(od.quantity*od.unit_price) as `total revenue per product` from products p
join order_details od on od.product_id = p.product_id group by od.product_id;

-- 8
select count(order_id) as total_order, month(order_date) from orders group by month(order_date);

-- 9
select sum(total_amount) as total_amount, month(order_date) from orders group by month(order_date);

-- 10
select p.product_name, avg(od.quantity) as total_quantity from products p 
join order_details od
on od.product_id = p.product_id group by p.product_name;

-- 11
select c.customer_name, c.country, sum(total_amount) as total_amount from customers c join orders o 
on c.customer_id = o.customer_id group by c.country, c.customer_name;

-- 12
select p.category, c.country, sum(o.total_amount) as total_amount from customers c join orders o
on c.customer_id = o.customer_id join order_details od on o.order_id = od.order_id join products p 
on od.product_id = p.product_id group by c.country, p.category; 

-- 13
select c.customer_name, p.category, sum(od.quantity * od.unit_price) from customers c join orders o
on c.customer_id = o.customer_id join order_details od on o.order_id = od.order_id join products p 
on od.product_id = p.product_id group by c.customer_name, p.category; 

-- 14
select c.customer_name, count(distinct od.product_id) as `distinct product count` 
from customers c join orders o on c.customer_id = o.customer_id 
join order_details od on o.order_id = od.order_id group by c.customer_name;

-- 15
select c.city, count(o.order_id) as `total orders from a city` from customers c join orders o
on c.customer_id = o.customer_id group by c.city;

-- 16
select c.customer_name, sum(od.quantity * od.unit_price) as total_revenue from 
customers c join orders o on c.customer_id = o.customer_id join order_details od 
on o.order_id = od.order_id group by c.customer_name having total_revenue > 1000; 

-- 17
select p.product_name, sum(od.quantity) as total_quantity from products p 
left join order_details od
on od.product_id = p.product_id group by p.product_name having total_quantity > 50;

-- 18
select c.country, sum(o.total_amount) as total_amount from customers c join orders o 
on c.customer_id = o.customer_id group by c.country having total_amount > 500;

-- 19
select p.category, sum(od.quantity * od.unit_price) as total_revenue from order_details od join products p
on od.product_id = p.product_id group by p.category having total_revenue > 5000;

-- 20
select count(order_id) as order_count from orders 
group by month(order_date) having order_count > 10;