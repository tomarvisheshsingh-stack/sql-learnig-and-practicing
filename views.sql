create database subquery;
use subquery;

CREATE TABLE Employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(100),
dept_id INT,
salary DECIMAL(10, 2)
);

CREATE TABLE Departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100)
);

CREATE TABLE Projects (
project_id INT PRIMARY KEY,
project_name VARCHAR(100),
dept_id INT
);

CREATE TABLE Timesheets (
timesheet_id INT PRIMARY KEY,
emp_id INT,
project_id INT,
hours_worked INT
);

INSERT INTO Departments (dept_id, dept_name) VALUES
(1, "HR"),
(2, "Finance"),
(3, "Engineering"),
(4, "Marketing");

INSERT INTO Employees (emp_id, emp_name, dept_id, salary) VALUES
(101, "Alice", 1, 50000),
(102, "Bob", 2, 60000),
(103, "Charlie", 3, 75000),
(104, "David", 3, 70000),
(105, "Eve", 2, 55000),
(106, "Frank", 4, 45000),
(107, "Grace", 3, 80000),
(108, "Heidi", 4, 47000),
(109, "Ivan", 3, 72000),
(110, "John", 1, 49000);

INSERT INTO Projects (project_id, project_name, dept_id) VALUES
(201, "Payroll System", 2),
(202, "Website Redesign", 4),
(203, "AI Model", 3),
(204, "HR Onboarding", 1),
(205, "Marketing Analytics", 4);

INSERT INTO Timesheets (timesheet_id, emp_id, project_id, hours_worked) VALUES
(1, 101, 204, 10),
(2, 102, 201, 15),
(3, 103, 203, 25),
(4, 104, 203, 20),
(5, 105, 201, 30),
(6, 106, 202, 12),
(7, 108, 205, 18),
(8, 109, 203, 22),
(9, 107, 203, 28),
(10, 101, 204, 5),
(11, 104, 201, 8),
(12, 102, 203, 12);

-- 1
select * from employees where salary > (select avg(salary) from employees);

-- 2
select * from departments where dept_id in 
(select dept_id from employees group by dept_id having avg(salary) > 50000);

-- 3
select * from employees where salary = (select max(salary) from employees);

-- 4
select * from employees where dept_id = (select dept_id from employees where emp_name = "John");
 
-- 5
select * from employees e where salary < 
(select max(salary) from employees where dept_id = e.dept_id);

-- 6 review
select dept_name from departments where dept_id not in 
(select dept_id from employees where salary > 60000);
 
-- 7
select emp_name from employees where emp_id in 
(select emp_id from timesheets where project_id in 
(select project_id from timesheets where emp_id = 101))
and emp_id <> 101;
 
-- 8
select dept_name from departments where dept_id = 
(select dept_id from employees where salary = (select min(salary) from employees));

-- 9
select project_name from projects where project_id in 
(select project_id from timesheets group by project_id having sum(hours_worked) = 
(select max(hour) from (select sum(hours_worked) as hour from timesheets group by project_id) as t));

-- 10
select * from employees where emp_id not in (select emp_id from timesheets);

-- 11
select dept_name, avg(salary) from departments d join employees e on d.dept_id = e.dept_id group by e.dept_id
having dept_id in (select dept_id from employees group by dept_id having count(emp_id) > 2);

-- 12
select d.dept_name, hr.total_hours from Departments d join 
(select e.dept_id, SUM(t.hours_worked) as total_hours from Employees e join Timesheets t 
on e.emp_id = t.emp_id group by e.dept_id) as hr on d.dept_id = hr.dept_id;

select d.dept_name, sum(t.hours_worked) as total_hours from Departments d join employees e on 
d.dept_id = e.dept_id join timesheets t on t.emp_id = e.emp_id group by dept_name;

-- 13
select * from employees where emp_id not in (select emp_id from timesheets);

-- 14
select * from departments where dept_id in ( select dept_id from employees where emp_id in 
(select emp_id from timesheets group by emp_id having sum(hours_worked) > 40));

-- 15
select * from projects where project_id not in
(select project_id from timesheets);

select * from projects where not exists
(select 1 from timesheets);

-- 16
select * from employees where dept_id in (select dept_id from departments where dept_id not in
(select dept_id from projects));

-- 17
select * from employees where dept_id in 
(select dept_id from employees group by dept_id having count(emp_id) = 1);

-- 18 doubt
select * from employees where emp_id in 
(select emp_id from timesheets group by emp_id having count(distinct project_id) =
(select count(project_id) from projects));

-- gpt's query
SELECT e.emp_name
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM Projects p
    WHERE NOT EXISTS (
        SELECT 1
        FROM Timesheets t
        WHERE t.emp_id = e.emp_id
          AND t.project_id = p.project_id
    )
);

-- 19
select * from employees e where salary > 
(select avg(salary) from employees where dept_id = e.dept_id);

-- 20
select * from projects where project_id in 
(select project_id from timesheets group by project_id having sum(hours_worked) > 
(select avg(total_hours) from 
(select sum(hours_worked) as total_hours from timesheets group by project_id) as th));

-- VIEW 

-- updatable view : bidirectional(changes in both table)

create view employee_view as
select lastname, employeenumber from employees where officecode = 1;

select * from employee_view;

select * from employees;

create view new_view as
(select * from employees where dept_id = 3);

drop view new_view;
select * from new_view;

-- nonupdatable view : unidirectional
use ecom;
select * from customers;

create algorithm = temptable view contactperson123 as
select customername, contactfirstname, contactlastname, phone from customers;

select * from contactperson123;

update customers set phone = 123 where customername = "Ateller graphique";
update contactperson123 set phone = 546 where customername = "Ateller graphique";