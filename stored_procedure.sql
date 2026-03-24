-- Stored Procedure

create database stored_procedure;
use stored_procedure;

CREATE TABLE employees (
emp_id INT PRIMARY KEY,
name VARCHAR(50),
department VARCHAR(50),
salary INT
);

INSERT INTO employees VALUES
(1, "Rahul", "IT", 60000),
(2, "Anita", "HR", 45000),
(3, "Suresh", "IT", 80000),
(4, "Neha", "Sales",50000),
(5, "Amit", "IT", 70000);


delimiter $$
create procedure hello_world()
begin 
	select 'Hello, Stored Procedure!' as message;
end $$
delimiter ;

delimiter $$

call hello_world();


delimiter $$
create procedure emp_data()
begin
	select * from employees;
end $$
delimiter ;

call emp_data();

delimiter $$
create procedure emp_info()
begin
	select * from employees where department = "IT";
end $$
delimiter ;

call emp_info();


delimiter ^^
create procedure empinfo()
begin
	select * from employees where department = "IT";
end ^^
delimiter ;

call empinfo();

delimiter $$
create procedure empp()
begin
select *,
	case 
		when salary > 65000 then "High_Salary"
		else "Medium_Salary" end as salary_devision from employees;
end $$
delimiter ;

call empp();

delimiter $$
create procedure dept(in dept_name varchar(10))
begin
	select * from employees
    where department = dept_name;
end $$
delimiter ;

call dept("HR");
call dept("IT");

delimiter $$
create procedure dept1(in dept_name varchar(10), in sal int)
begin
	select * from employees
    where department = dept_name
    and salary > sal;
end $$
delimiter ;

call dept1("IT", 65000);