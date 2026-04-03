use cte;

-- Question:
-- Find IT employees earning more than average IT salary using CTE.
-- my version
with cte_1 as (select avg(salary) as avg_sal from employees where department = "IT")
select * from employees e join cte_1 on e.salary > cte_1.avg_sal where department = "IT";

-- Chat gpt's recommendation 
with cte_1 as (select avg(salary) as avg_sal from employees where department = "IT")
select * from employees e cross join cte_1 c where department = "IT" and
e.salary = c.avg_sal;

-- Question:
-- Calculate total sales per month and display months with sales above 2000 using CTE.
with cte_2 as
(select month(sale_date), sum(amount) as total_sales from sales group by month(sale_date) )
select * from cte_2 where total_sales > 2000;

-- Question:
-- Find customers who placed more than 2 orders using CTE.
with cte_3 as 
(select count(order_id) as total_orders, customer_id from orders group by customer_id)
select * from cte_3 where total_orders > 2;

-- Question:
-- Find products priced above their category average using CTE.
with cte_4 as
(select avg(price) as avg_price, category from products group by category)
select * from products p join cte_4 c on p.category = c.category where c.avg_price < p.price;

-- Question:
-- Identify students scoring above class average using CTE.
with cte_5 as 
(select avg(marks) as avg_mark from students)
select * from students s cross join cte_5 c where s.marks > c.avg_mark;

-- Question:
-- Find duplicate email addresses using CTE.
with cte_6 as
(select email from users group by email having count(email) > 1)
select * from cte_6;

-- Question:
-- Display departments with total expenses greater than 9000 using CTE.
with cte_7 as 
(select department, sum(amount) as expense from expenses group by department)
select * from cte_7 where expense > 9000;

-- Question:
-- Find employees earning above average salary using CTE.
with cte_8 as 
(select avg(salary) as avg_sal from emp_salary)
select * from emp_salary e cross join cte_8 c where e.salary > avg_sal;

-- Question:
-- Count unique users per day using CTE.
with cte_9 as
(select user_id from logins group by user_id having count(user_id) = 1)
select * from cte_9;

-- Question:
-- Find high-value customers with total spending above 1000 using CTE.
with cte_10 as 
(select customer_id, sum(amount) as total_amt from order_amounts group by customer_id)
select * from cte_10 where total_amt > 1000;