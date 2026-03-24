-- When Case statements 2

create database `case statements 2`;
use `case statements 2`;

CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50)
);
INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Sales'),
(4, 'Finance');

CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
dept_id INT,
salary INT,
gender VARCHAR(10),
hire_date DATE,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
INSERT INTO employees VALUES
(101, 'Amit', 1, 70000, 'Male', '2020-01-15'),
(102, 'Neha', 1, 85000, 'Female', '2019-03-10'),
(103, 'Ravi', 1, 85000, 'Male', '2018-07-21'),
(104, 'Anita', 2, 50000, 'Female', '2021-02-01'),
(105, 'Kiran', 2, 55000, 'Male', '2019-11-12'),
(106, 'Meena', 3, 60000, 'Female', '2020-06-18'),
(107, 'Suresh', 3, 45000, 'Male', '2022-01-05'),
(108, 'Pooja', 3, 50000, 'Female', '2021-09-10'),
(109, 'Rahul', 4, 90000, 'Male', '2017-04-22'),
(110, 'Sneha', 4, 95000, 'Female', '2018-08-30');

CREATE TABLE sales (
sale_id INT PRIMARY KEY,
emp_id INT,
sale_date DATE,
amount INT,
FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO sales VALUES
(1, 101, '2024-01-01', 15000),
(2, 101, '2024-01-05', 20000),
(3, 106, '2024-01-03', 25000),
(4, 106, '2024-01-07', 18000),
(5, 107, '2024-01-02', 12000),
(6, 108, '2024-01-06', 22000),
(7, 109, '2024-01-04', 30000),
(8, 110, '2024-01-08', 35000);

-- question 1
select d.dept_id, d.dept_name, count(e.emp_id) as emp_count,
	case
		when count(e.emp_id) >= 3 then "Large"
        else "Small"
	end as `emp dept count`
from departments d join employees e 
on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name;

-- question 2
select d.dept_name, round(avg(e.salary),2) as avg_salary,
	case
		when avg(e.salary) > 80000 then "High"
        when avg(e.salary) > 60000 then "Medium"
        else "Low"
	end as `salary category`
from departments d join employees e
on e.dept_id = d.dept_id
group by d.dept_name;

-- question 3
select d.dept_name,
	sum(case when e.gender = "Female" then 1 else 0 end) as `Female Count`,
    sum(case when e.gender = "Male" then 1 else 0 end) as `Male Count`,
    case 
		when sum(case when e.gender = "Female" then 1 else 0 end) >
			 sum(case when e.gender = "Male" then 1 else 0 end) then "Female Dominated" 
		when sum(case when e.gender = "Female" then 1 else 0 end) <
			 sum(case when e.gender = "Male" then 1 else 0 end) then "Male Dominated" 
		else "Balanced"
	end as `Gender`
from departments d join employees e
on d.dept_id = e.dept_id
group by d.dept_name;

-- question 4
select d.dept_name, sum(e.salary),
	case
		when sum(e.salary) >= 200000 then "Over Budget"
        else "Under Budget"
	end as `Budget Status`
from departments d join employees e
on d.dept_id = e.dept_id
group by d.dept_name;

-- question 5
SELECT
    e.emp_id, e.emp_name, d.dept_name, e.hire_date,
    CASE
        WHEN e.hire_date < '2019-01-01' THEN 'Senior'
        WHEN e.hire_date BETWEEN '2019-01-01' AND '2020-12-31' THEN 'Mid'
        ELSE 'Junior'
    END AS experience_level
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;
    
-- question 6
select d.dept_name, max(e.salary) as highest_salary,
	case
		when max(salary) > 80000 then "Premium"
        else "Standard"
	end as `Pay Level`
from employees e join departments d
on e.dept_id = d.dept_id
group by d.dept_name;

-- question 7
select d.dept_name,
sum(case when e.hire_date >= "2020-01-01" then 1 else 0 end) as `hired after 2020`,
sum(case when e.hire_date < "2020-01-01" then 1 else 0 end) as `hired before 2020`,
case
	when 
    sum(case when e.hire_date >= "2020-01-01" then 1 else 0 end) >
	sum(case when e.hire_date < "2020-01-01" then 1 else 0 end) then "New Hiring"
    when
    sum(case when e.hire_date >= "2020-01-01" then 1 else 0 end) <
	sum(case when e.hire_date < "2020-01-01" then 1 else 0 end) then "Old Hiring"
    else "Balanced Hiring"
end as "Hiring Trend"
from employees e join departments d
on e.dept_id = d.dept_id
group by d.dept_name;

-- question 8
select d.dept_name, avg(s.amount) as `avg sales`,
case
	when avg(s.amount) > 30000 then "Excellent"
    when avg(s.amount) > 22500 then "Good"
    else "Poor"
end as `Department's Performance`
from employees e join departments d
on e.dept_id = d.dept_id
join sales s on e.emp_id = s.emp_id
group by d.dept_name;

-- question 9
select d.dept_name, sum(s.amount) as `Total sales`,
case
	when sum(s.amount) > 100000 then "Excellent"
    when sum(s.amount) > 75000 then "Good"
    else "Poor"
end as `Department's Performance`
from employees e join departments d
on e.dept_id = d.dept_id
join sales s on e.emp_id = s.emp_id
group by d.dept_name;

-- question 10
select d.dept_name,
sum(case when e.salary > dp.avg_salary then 1 else 0 end) as `Above Average`,
sum(case when e.salary < dp.avg_salary then 1 else 0 end) as `Below Average`
from employees e join departments d 
on e.dept_id = d.dept_id
join( select avg(salary) as avg_salary, dept_id 
from employees group by dept_id) as dp
on dp.dept_id = e.dept_id
group by d.dept_name;

-- by window function
SELECT
    dept_name,
    SUM(CASE WHEN salary > avg_salary THEN 1 ELSE 0 END) AS above_avg,
    SUM(CASE WHEN salary < avg_salary THEN 1 ELSE 0 END) AS below_avg
FROM (
    SELECT
        d.dept_name,
        e.salary,
        AVG(e.salary) OVER (PARTITION BY e.dept_id) AS avg_salary
    FROM employees e
    JOIN departments d ON e.dept_id = d.dept_id
) t
GROUP BY dept_name;

-- question 11
select d.dept_name, sum(s.amount) as `Total sales`,
case
	when sum(s.amount) > 0 then "Revenue Generating"
    else "Non-revenue"
end as `Department's Performance`
from employees e join departments d
on e.dept_id = d.dept_id
join sales s on e.emp_id = s.emp_id
group by d.dept_name;

-- question 12
select d.dept_name, round(avg(e.salary),2) as avg_salary,
	case
		when avg(e.salary) > 70000 then "High Cost"
        else "Low Cost"
	end as `salary category`
from departments d join employees e
on e.dept_id = d.dept_id
group by d.dept_name;

-- question 13
select d.dept_id, d.dept_name, count(e.emp_id) as emp_count,
	case
		when count(e.emp_id) <= 1 then "High"
        when count(e.emp_id) <= 3 then "Medium"
        else "Low"
	end as `Workload`
from departments d join employees e 
on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name;

-- question 14
select d.dept_name,
sum(case when e.gender = "Female" then e.salary else 0 end) as `Total Female Salary`,
sum(case when e.gender = "Male" then e.salary else 0 end) as `Total Male Salary`,
case
	when 
		sum(case when e.gender = "Female" then e.salary else 0 end) =
		sum(case when e.gender = "Male" then e.salary else 0 end) 
        then "Gender Pay Balanced"
        else "Imbalanced"
	end as `Pay Balance`
from departments d join employees e 
on e.dept_id = d.dept_id
group by d.dept_id, d.dept_name;

-- question 15
select emp_id, emp_name, dept_name, salary,
case
	when salary = max_salary then 'Top Earner'
	when salary = min_salary then 'Low Earner'
	else 'Average Earner'
    end as earning_category
from (
    select e.emp_id, e.emp_name, d.dept_name, e.salary,
        max(e.salary) over (partition by e.dept_id) as max_salary,
        MIN(e.salary) over (partition by e.dept_id) as min_salary
    from employees e
    join departments d
        on e.dept_id = d.dept_id
) t;
