use store_db;

show tables;

-- 1
select * from products where status = 
'active';

-- 2
select product_name, price from products where
category = 'Electronics';

-- 3
select * from customers where 
city = 'New York';

-- 4
select * from orders where 
order_status = 'Delivered';

-- 5
select product_name, price, status 
from products where
status = 'active' and price>100;

-- 6
select customer_name, city, age 
from customers where
city = 'New York' and age<30;

-- 7
select * from orders where
order_status = 'Delivered' and 
total_amount > 150;

-- 8
select product_name, stock_quantity 
from products where 
category = 'Accessories' and
stock_quantity < 50;

-- 9
select customer_name, member_since, country 
from customers where member_since > "2022-01-01"
and country = "USA";

set sql_safe_updates = 0;

-- 10
update products set status = 'active' where 
product_name = 'Screen Protector';

-- 11
update products set price = price * 1.10 where 
category = 'Electronics';

-- 12
update products set stock_quantity = 0 where 
product_name = 'Monitor Stand';

-- 13
update products set stock_quantity = stock_quantity + 20
where status = 'active' and category = 'Accessories';

-- 14
update orders set order_status = 'shipped' where 
order_status = 'pending' and total_amount > 100;

-- 15
update customers set age = age + 5 where
member_since >= '2020-01-01' and country = 'USA';

-- 16
select product_name, price,
if(price>200, 'Expensive', 'Affordable') as price_level
from products;
-- if doesn't changes structure of table but instead adds a virtual column at select query

-- 17
select customer_name, age, member_since, 
if(member_since < '2022-01-01', 'Loyal', 'Recent') 
as membership_duration
from customers;
-- comparison operators work on date

-- 18
select order_id, total_amount, 
if(total_amount>500, 'High Value', 'Standard Value')
as order_value 
from orders;

-- 19
select product_name, stock_quantity,
if(stock_quantity<20, 'Low Stock', 'Good Stock') as stock_status
from products where status = 'active';

-- 20
select customer_name, age, 
if(age<30, 'Young', if(age<40, 'Middle-aged', 'Senior')) as age_group
from customers where city = 'New York';

-- 21
select order_id, total_amount, 
if(total_amount>100, 'Paid', 'Small Order') from
orders where order_status = 'Delivered';