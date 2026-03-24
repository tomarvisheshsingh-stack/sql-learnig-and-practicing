create database practice;

use practice;

create table practice1(
id int not null unique, 
first_name varchar(30) not null, 
last_name varchar(30), 
city char(30) default "Bhopal", 
age int check(age>=18),
salary decimal(7,2) not null,
phone_no bigint not null,
qualification varchar(30) not null);

describe practice1;

insert into practice1(id, first_name, last_name, age, salary, phone_no, qualification) values
(1, 'Vishesh', 'Tomar', 20, 20000.56, 7894561230, 'Undergraduate'),
(2, 'Ram', 'Sharma', 23, 35466.78, 9845654456, 'BCA'),
(3, 'Priya', 'Roy', 25, 78945, 7896541123, 'B.Tech');

select * from practice1;
