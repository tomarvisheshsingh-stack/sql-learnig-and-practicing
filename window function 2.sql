-- window fn practice 2

use window_funct;

select * from employees;
select * from sales;
select * from student_marks;
select * from monthly_revenue;

-- question 1.1
select emp_name, salary, department,
	row_number() over (order by salary desc)
from employees;

-- question 1.2
select emp_name, salary, department,
	row_number() over (partition by department order by salary desc)
from employees;

-- question 1.3
select emp_name, salary,
	rank() over (order by salary desc),
    dense_rank() over (order by salary desc)
from employees;

-- question 1.4
select emp_name, salary, department
from( select emp_name, salary, department,
	dense_rank() over (partition by department order by salary desc) as rank_
from employees) as ranked_emp 
where rank_ = 1
order by department;

-- question 2.1
