use ecom;
show tables;

select * from customers; 

select customernumber, customername, city, country from customers; 

-- clauses
select * from customers where country = 'France';

select customernumber, customername, city, country from customers where country = 'USA'; 

select * from customers where country = 'France' or country = 'USA';

select * from customers where country = 'France' and creditlimit > 50000;

select * from customers where creditlimit > 50000;
select * from customers where creditlimit >= 50000;
select * from customers where creditlimit < 50000;
select * from customers where creditlimit <= 50000;
select * from customers where creditlimit <> 50000;
select * from customers where creditlimit != 50000;

select * from employees;

create table employees1(
employeeNumber int primary key,
lastname varchar(30) not null,
firstname varchar(30) not null,
extension varchar(5) not null,
email varchar(30) not null,
officecode varchar(10) not null,
reportsto int,
jobtitle varchar(40) not null,
foreign key(reportsto) references employees1(employeeNumber));

-- to add a column in existing table
alter table employees1 add column city varchar(40) not null;

-- to add a column in existing table after a specific column
alter table employees1 add column country varchar(20) after jobtitle;

-- to remove a column from existing table
alter table employees1 drop column city;

select * from employees2;
describe employees2;

-- to modify an existing table
alter table employees1 modify column lastname varchar(60) not null;

-- to change name of a column in table
alter table employees1 rename column email to emp_email;

-- to change the name of table
rename table employees1 to employees2;

-- to drop the foreign key from table
use foreign_key;
show tables;

select * from patient_info;
describe patient_info;

alter table patient_info drop foreign key patient_info_ibfk_1;
alter table patient_info drop key doct_id;

-- to add a foreign key in a table
alter table patient_info add
foreign key(doct_id) references doctor_info(id);


-- to copy a structure and values of a table into another table
create table doctor as select * from doctor_info;
describe doctor;
describe doctor_info;

use ecom;

-- arranging data in sequential manner/ asc/desc

select * from customers order by creditlimit; #by default asc

select * from customers order by creditlimit asc;

select * from customers order by creditlimit desc;

select customername, country, state, creditlimit from customers where country = "France" order by creditlimit;
