-- when case questions

create database case_statement;
use case_statement;

CREATE TABLE Employees 
(Emp_ID INT PRIMARY KEY,
Emp_Name VARCHAR(50),
Salary INT,
Dept VARCHAR(50),
Experience INT);

INSERT INTO Employees (Emp_ID, Emp_Name, Salary, Dept, Experience) VALUES
(1, 'Alice', 60000, 'HR', 5),
(2, 'Bob', 85000, 'IT', 10),
(3, 'Charlie', 40000, 'Finance', 3),
(4, 'David', 75000, 'IT', 8),
(5, 'Emma', 30000, 'Finance', 2);

-- question 1
select *, 
	case
		when salary > 75000 then "High Salary"
		when salary > 40000 then "Medium Salary"
        else "Low Salary" 
	end as `Salary Category`
from employees;

-- question 2
select *,
	case
		 when experience > 6 then "Expert"
         when experience > 3 then "Intermediate"
         else "Beginner"
	end as `Employee Experience`
from employees;

-- question 3
select *,
	case
		 when dept = "IT" then "Information Technology"
         when dept = "HR" then "Human Resources"
         when dept = "Finance" then "Financial Services"
	end as `Dept new name`
from employees;

-- question 4
select *, 
	case
		when salary > 80000 then (salary * 1.15)
        when salary > 50000 then (salary * 1.10)
        else (salary * 1.05)
	end as `Salary with bonus`
from employees;

-- question 5
select *,
	case
		when salary > 80000 then 'High'
        when salary > 50000 then 'Mid'
        else 'Low'
	end as `Tax Slab`
from employees;

-- question 6
select *,
	case
		when dept = Null then 'Department Not Assigned'
	end as dept_info
from employees;

#7.Classify Students Based on Marks
CREATE TABLE Students 
    (ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Marks INT);

INSERT INTO Students (ID, Name, Marks) VALUES
(1, 'Alex', 90),
(2, 'Brian', 70),
(3, 'Chris', 45);

select *,
	case
		when marks >= 85 then "A"
        when marks >= 60 then "B"
        else "C"
	end as Grades
from students;

#8.Determine Account Status
CREATE TABLE Users 
    (User_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Status VARCHAR(20));

INSERT INTO Users (User_ID, Name, Status) VALUES
(1, 'John', 'Active'),
(2, 'Mike', 'Suspended'),
(3, 'Emma', 'Inactive');

select *,
	case
		when status = "Active" then "Account is Active"
        when status = "Suspended" then "Account is Suspended"
        else "Account is Inactive"
	end as `Account Status`
from users;

#9.Calculate Discounts Based on Order Value
CREATE TABLE Orders 
    (Order_ID INT PRIMARY KEY,
    Customer VARCHAR(50),
    Amount INT);

INSERT INTO Orders (Order_ID, Customer, Amount) VALUES
(1, 'John', 1200),
(2, 'Mike', 600),
(3, 'Emma', 400);

select *,
	case
		when amount > 1000 then "10%"
        when amount > 500 then "5%"
        else "0%"
	end as `Discount Purchases`
from Orders;

#10.Identify Late Shipments
CREATE TABLE Shipments 
    (Order_ID INT PRIMARY KEY,
    Customer VARCHAR(50),
    Order_Date DATE,
    Expected_Ship_Date DATE,
    Actual_Ship_Date DATE);
    
INSERT INTO Shipments (Order_ID, Customer, Order_Date, Expected_Ship_Date, Actual_Ship_Date) VALUES
(1, 'John', '2026-01-01', '2026-01-05', '2026-01-06'),   
(2, 'Mike', '2026-01-02', '2026-01-07', '2026-01-07'),   
(3, 'Emma', '2026-01-03', '2026-01-08', '2026-01-10');

select *,
	case
		when Actual_Ship_Date > Expected_Ship_Date then "Order is Late"
        else "Order is on time"
	end as `Delivery Status`
from Shipments;

#11.Determine Loan Eligibility
CREATE TABLE Applicants 
    (App_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    Experience INT);
    
INSERT INTO Applicants (App_ID, Name, Salary, Experience) VALUES
(1, 'Alice', 60000, 5),
(2, 'Bob', 30000, 2),
(3, 'Charlie', 45000, 4);

select *,
	case	
		when salary > 50000 and Experience > 4 then "Eligible"
        else "Not Eligible"
	end as `Loan Eligibility`
from Applicants;

#12.Assign Age Groups
CREATE TABLE Persons
    (ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT);

INSERT INTO Persons (ID, Name, Age) VALUES
(1, 'Alex', 15),
(2, 'Brian', 28),
(3, 'Chris', 42),
(4, 'Emma', 65);

select *,
	case 
		when age > 60 then "Old"
        when age > 40 then "Middle-Aged"
        when age > 18 then "Adult"
        else "Minor"
	end as `Age Group`
from Persons;

