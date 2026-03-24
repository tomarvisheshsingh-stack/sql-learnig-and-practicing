create database exam_question;
use exam_question;

CREATE TABLE Employee 
    (Empid INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(20),
    ContactNo VARCHAR(15),
    EmailId VARCHAR(100),
    EmpHeadID INT);
    
    
INSERT INTO Employee VALUES
(101, 'Isha', 'E-101', '1234567890', 'isha@gmail.com', 105),
(102, 'Priya', 'E-104', '1234567890', 'priya@yahoo.com', 103),
(103, 'Neha', 'E-101', '1234567890', 'neha@gmail.com', 101),
(104, 'Rahul', 'E-102', '1234567890', 'rahul@yahoo.com', 105),
(105, 'Abhishek', 'E-101', '1234567890', 'abhishek@gmail.com', 102);


CREATE TABLE EmpDept 
    (DeptId VARCHAR(10) PRIMARY KEY,
    DeptName VARCHAR(50),
    Dept_off VARCHAR(20),
    DeptHead INT);
    
    
INSERT INTO EmpDept VALUES
('E-101', 'HR', 'Monday', 105),
('E-102', 'Development', 'Tuesday', 101),
('E-103', 'Hous Keeping', 'Saturday', 103),
('E-104', 'Sales', 'Sunday', 104),
('E-105', 'Purchage', 'Tuesday', 104);


CREATE TABLE EmpSalary 
    (EmpId INT PRIMARY KEY,
    Salary DECIMAL(10,2),
    IsPermanent VARCHAR(5));
    
    
INSERT INTO EmpSalary VALUES
(101, 2000, 'Yes'),
(102, 10000, 'Yes'),
(103, 5000, 'No'),
(104, 1900, 'Yes'),
(105, 2300, 'Yes');


CREATE TABLE Project 
    (ProjectId VARCHAR(10) PRIMARY KEY,
    Duration INT);
    
    
INSERT INTO Project VALUES
('p-1', 23),
('p-2', 15),
('p-3', 45),
('p-4', 2),
('p-5', 30);


CREATE TABLE Country 
    (cid VARCHAR(5) PRIMARY KEY,
    cname VARCHAR(50));
    
    
INSERT INTO Country VALUES
('c-1', 'India'),
('c-2', 'USA'),
('c-3', 'China'),
('c-4', 'Pakistan'),
('c-5', 'Russia');


CREATE TABLE ClientTable 
    (ClientId VARCHAR(10) PRIMARY KEY,
    ClientName VARCHAR(100),
    cid VARCHAR(5),
    FOREIGN KEY (cid) REFERENCES Country(cid));
    

INSERT INTO ClientTable VALUES
('cl-1', 'ABC Group', 'c-1'),
('cl-2', 'PQR', 'c-1'),
('cl-3', 'XYZ', 'c-2'),
('cl-4', 'tech altum', 'c-3'),
('cl-5', 'mnp', 'c-5');


CREATE TABLE EmpProject 
	(EmpId INT,
    ProjectId VARCHAR(10),
    ClientId VARCHAR(10),
    StartYear INT,
    EndYear INT,
    FOREIGN KEY (EmpId) REFERENCES Employee(Empid),
    FOREIGN KEY (ClientId) REFERENCES ClientTable(ClientId));
    
    
INSERT INTO EmpProject VALUES
(101, 'p-1', 'cl-1', 2010, 2010),
(102, 'p-2', 'cl-2', 2010, 2012),
(103, 'p-1', 'cl-3', 2013, NULL),
(104, 'p-4', 'cl-1', 2014, 2015),
(105, 'p-4', 'cl-5', 2015, NULL);

-- 1
select deptname from empdept d join employee e on d.deptid = e.department
where e.empid > 103;

-- by subquery
select deptname from empdept where deptid in (select department from employee where empid > 103);

-- 2
select e2.empname from employee e1 join employee e2 on e1.empid = e2.empheadid
where e1.empname = "Abhishek";

-- by subquery
select empname from employee where empheadid = (select empid from employee where empname = "Abhishek");

-- 3
select empname from employee e join empdept d on e.empid = d.depthead where d.deptname = "HR";

-- by subquery
select empname from employee where empid in (select depthead from empdept where deptname = "HR");

--  4
select empname from employee e join empsalary s 
on e.empheadid = s.empid where s.ispermanent = "Yes";

-- by subquery
select empname from employee where empheadid in (select empid from empsalary where ispermanent = "Yes");

-- 5
select e.empname, e.emailid from empdept d join employee e on d.depthead = e.empid
join empsalary s on e.empid = s.empid where s.ispermanent = "No";

-- by subquery
select empname, emailid from employee where empid in (select depthead from empdept where
depthead in (select empid from empsalary where ispermanent = "No"));

-- 6
select empname from employee e join empdept d on e.department = d.deptid where d.dept_off = "Monday";

-- by subquery 
select * from employee where department in (select deptid from empdept where dept_off = "Monday");

-- 7
select c.* from clienttable c join country ct on c.cid = ct.cid where cname = "India";

-- by subquery
select * from clienttable where cid in (select cid from country where cname = "India");

-- 8
select e.* from employee e join empdept d on e.department = d.deptid where d.deptname = "Development";

-- by subquery
select * from employee where department in (select deptid from empdept where deptname = "Development");

-- 9
select salary from empsalary order by salary desc limit 1 offset 1;

-- by subquery
select max(salary) from empsalary where salary < (select max(salary) from empsalary);

-- 10
select * from clienttable where clientname like "%g";