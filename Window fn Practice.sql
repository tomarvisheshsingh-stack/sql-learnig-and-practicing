use window_funct;

CREATE TABLE sales_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sales_rep VARCHAR(50),
    region VARCHAR(50),
    product VARCHAR(50),
    month VARCHAR(20),
    sales_amount DECIMAL(10,2)
);


INSERT INTO sales_data (sales_rep, region, product, month, sales_amount) VALUES
('Alice', 'North', 'Laptop', 'Jan', 1200.00),
('Bob', 'South', 'Tablet', 'Jan', 800.00),
('Charlie', 'East', 'Laptop', 'Jan', 950.00),
('David', 'West', 'Phone', 'Jan', 600.00),
('Eva', 'North', 'Tablet', 'Feb', 1100.00),
('Alice', 'North', 'Laptop', 'Feb', 1300.00),
('Bob', 'South', 'Tablet', 'Feb', 850.00),
('Charlie', 'East', 'Laptop', 'Feb', 1000.00),
('David', 'West', 'Phone', 'Feb', 700.00),
('Eva', 'North', 'Tablet', 'Mar', 1200.00),
('Alice', 'North', 'Laptop', 'Mar', 1250.00),
('Bob', 'South', 'Tablet', 'Mar', 900.00),
('Charlie', 'East', 'Laptop', 'Mar', 1050.00),
('David', 'West', 'Phone', 'Mar', 650.00),
('Eva', 'North', 'Tablet', 'Apr', 1150.00),
('Alice', 'North', 'Laptop', 'Apr', 1400.00),
('Bob', 'South', 'Tablet', 'Apr', 950.00),
('Charlie', 'East', 'Laptop', 'Apr', 1100.00),
('David', 'West', 'Phone', 'Apr', 800.00),
('Eva', 'North', 'Tablet', 'May', 1180.00),
('Alice', 'North', 'Laptop', 'May', 1350.00);

-- 1
select *,
rank() over (partition by month order by sales_rep) as rnk
 from sales_data;

-- 2
select *, sum(sales_amount) over (partition by sales_rep
order by id rows between unbounded preceding and current row) 
as cumulative_sales from sales_data;

-- 3
select *,
avg(sales_amount) over (partition by region) as 
`avg sales of a region`
from sales_data;

-- 4
select *, 
lag(sales_amount) over (partition by sales_rep) as previous_sales
from sales_data;

-- 5
select * ,
lead(sales_amount) over (partition by sales_rep) as previous_sales
from sales_data;

-- 6
select region, month, sales_amount,
round(sales_amount *100 /sum(sales_amount) over (partition by region),2) as regional_percentage 
from sales_data;

-- 7
select *, max(sales_amount) over 
(partition by sales_rep) as max_sales
from sales_data;

-- 8
select *, case 
			when sales_amount > 
				lag(sales_amount) over (partition by month)
                then 'increased' 
                else 'decreased'
			end as sales_rep
from sales_data;

-- 9
select *, row_number() over (partition by region, month order by sales_amount  desc) as row_id 
from sales_data;

-- 10
select *, (sales_amount - avg(sales_amount) over (partition by region, month)) as difference_amount 
from sales_data;

-- 8
select *, case
			when sales_amount >
							lag(sales_amount) over (partition by month)
                            then 'increased'
                            else 'decreased'
						end as `Sales as compared from previous month's`
			from sales_data;