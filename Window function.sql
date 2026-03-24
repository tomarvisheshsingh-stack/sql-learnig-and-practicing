create database window_funct;
USE window_funct;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

INSERT INTO employees VALUES
(1, 'Amit', 'IT', 60000, '2021-01-10'),
(2, 'Neha', 'IT', 75000, '2020-03-15'),
(3, 'Ravi', 'IT', 75000, '2019-06-20'),
(4, 'Anita', 'HR', 50000, '2021-07-01'),
(5, 'Kiran', 'HR', 55000, '2019-11-25'),
(6, 'Meena', 'HR', 60000, '2018-02-18'),
(7, 'Suresh', 'Sales', 45000, '2022-01-05'),
(8, 'Pooja', 'Sales', 50000, '2021-09-10'),
(9, 'Rahul', 'Sales', 70000, '2019-04-12');

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    department VARCHAR(50),
    amount INT
);

INSERT INTO sales VALUES
(1, '2024-01-01', 'IT', 10000),
(2, '2024-01-02', 'IT', 15000),
(3, '2024-01-03', 'IT', 12000),
(4, '2024-01-01', 'HR', 8000),
(5, '2024-01-02', 'HR', 9000),
(6, '2024-01-03', 'HR', 11000),
(7, '2024-01-01', 'Sales', 20000),
(8, '2024-01-02', 'Sales', 25000),
(9, '2024-01-03', 'Sales', 22000);

CREATE TABLE student_marks (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    class VARCHAR(10),
    marks INT
);


INSERT INTO student_marks VALUES
(1, 'Aryan', '10A', 95),
(2, 'Rohit', '10A', 90),
(3, 'Sneha', '10A', 90),
(4, 'Kunal', '10A', 85),
(5, 'Priti', '10B', 92),
(6, 'Manish', '10B', 88),
(7, 'Neelam', '10B', 88),
(8, 'Aakash', '10B', 80);

CREATE TABLE monthly_revenue (
    month DATE,
    revenue INT
);

INSERT INTO monthly_revenue VALUES
('2024-01-01', 50000),
('2024-02-01', 65000),
('2024-03-01', 60000),
('2024-04-01', 70000),
('2024-05-01', 80000);

-- window function
select *, avg(salary) over (partition by department) as avg_salary from employees;

select department, avg(salary) as avg_salary from employees group by department;

select *, sum(salary) over (partition by department) as sum_salary from employees;

select *, max(salary) over (partition by department) as avg_salary from employees;

select *, lead(salary) over (partition by department) from employees;

select *, lag(salary) over (partition by department order by salary) from employees;

select emp_id, emp_name, lag(salary) over (partition by department order by salary) from employees;

select emp_id, emp_name, lag(salary) over (partition by department order by salary desc) as lead_salary from employees;

select *, rank() over(partition by department order by salary desc) as rnk from employees;

select *, dense_rank() over(partition by department order by salary desc) as rnk from employees;

select *, row_number() over(partition by department order by salary desc) as rnk from employees;

SELECT month,
       revenue,
       SUM(revenue) OVER (
           ORDER BY month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_revenue
FROM monthly_revenue;

SELECT month,
       revenue,
       AVG(revenue) OVER (
           ORDER BY month
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_avg_revenue
FROM monthly_revenue;

select *, sum(salary) over(order by salary asc rows between unbounded preceding and current row)
as cumulative_salary from employees;

select *, avg(salary) over(order by salary asc rows between unbounded preceding and current row)
as cumulative_salary_avg from employees;

select *, sum(salary) over(partition by department order by salary asc rows between unbounded preceding and current row)
as cumulative_salary from employees;

select *, avg(marks) over (partition by class rows between unbounded preceding and current row) as avg_cumulative_marks
from student_marks;

select *, sum(marks) over (partition by class rows between 1 preceding and current row) as avg_cumulative_marks
from student_marks;

select *, avg(salary) over (rows between unbounded preceding and current row) as avg_cumulative_salary,
			sum(salary) over (partition by department rows between unbounded preceding and current row) as sum_cumulative_salary
			from employees;