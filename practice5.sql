 use practice;
 
 create table customers(
 customer_no int primary key auto_increment,
 name varchar(30) not null,
 country char(20) default "India");
 
 create table orders(
 order_no int primary key,
 order_date date not null,
 order_status ENUM("Delivered", "Out for Delivery", "Order processing"),
 customer_no int,
 foreign key(customer_no) references customers(customer_no));
 
 create table order_details(
 order_no int,
 order_quantity int not null,
 priceEach int not null,
 foreign key(order_no) references orders(order_no));
 
insert into customers(name) values
('ertf'),
('ertfc'),
('temba');

insert into orders(order_no, order_date, order_status, customer_no) values
(1, "2025-11-10", "Delivered", 3),
(2, "2025-10-31", "Out for Delivery", 3),
(3, "2025-11-23", "Order processing", 1);

insert into order_details(order_no, order_quantity, priceEach) values
(1, 25, 100),
(2, 10, 1500),
(3, 5, 20);

select * from customers;

select * from orders;

select * from order_details;