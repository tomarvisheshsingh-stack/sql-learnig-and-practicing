use practice;

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

-- Rank sales reps by their total sales within each month.
select sales_rep, rank() over (partition by month order by sum(sales_amount)) as emp_rank from sales_data 
group by month, sales_rep;

-- Show the cumulative (running) total of sales for each sales rep across months.    
select sales_rep, month,
	sum(sales_amount) over (partition by sales_rep order by month
					rows between unbounded preceding and current row ) as total_sales
from sales_data;

-- 4. Compare each month’s sales amount with the previous month&#39;s sales for each
-- sales rep.
select sales_rep, month, sales_amount,
	lag(sales_amount) over (partition by sales_rep order by month) as last_months,
sales_amount - lag(sales_amount) over (partition by sales_rep order by month) as difference
from sales_data;

-- 5. Find the sales amount of the next month for each sales rep.
select sales_rep, month,
	lead(sales_amount) over (partition by sales_rep order by month) as `next month's`
from sales_data;

-- 6. Find what percentage of the total regional sales is contributed by each record.
select sales_rep, region, sales_amount,
	round((sales_amount*100)/sum(sales_amount) over (partition by region),2) as percentage
from sales_data;

-- 7. For each sales rep, find their highest monthly sales amount (and display it
-- alongside each row).
select *,
	max(sales_amount) over (partition by sales_rep) as `best performance`
from sales_data;

-- 8. Check whether each sales rep’s sales increased or not compared to their previous
-- month.
select *,
	sales_amount - lag(sales_amount) over (partition by sales_rep order by month) as difference,
    case 
    when (sales_amount - lag(sales_amount) over (partition by sales_rep order by month)) > 0 then 'increased'
		else 'decreased'
	end as `change in sales`
from sales_data;

-- 9. Assign a row number to each sales rep within their region and month based on
-- sales amount.
select *,
	row_number() over (partition by region, month order by sales_amount desc) as `sales rep row`
from sales_data;

-- 10. Compare each record’s sales amount with the average sales of that region and
-- month.
select *,
	avg(sales_amount) over (partition by region, month) as `avg sales`,
    sales_amount - avg(sales_amount) over (partition by region, month) as difference
from sales_data;