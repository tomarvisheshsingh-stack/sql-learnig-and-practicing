create database db1;
use db1;

create table students(id int, name varchar(30), city char(30), age int);

select * from students;

describe students;

insert into students(id, name, city, age) values(1, 'Aryan', 'Bhopal', 25), (2, 'Vishesh', 'Indore', 20);