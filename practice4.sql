use practice;

show tables;

create table faculty(fac_id int primary key auto_increment,
fac_name varchar(30) not null,
fac_city char(20) default "Bhopal",
fac_experience tinyint not null);

create table student(std_id int primary key auto_increment,
std_name varchar(30),
std_age tinyint check(std_age>=18),
std_city varchar(10) default "Bhopal",
fac_id int,
course_id varchar(5),
foreign key(course_id) references courses(course_id),
foreign key(fac_id) references faculty(fac_id));

create table courses(course_id varchar(5) primary key,
course_name varchar(20) unique,
course_duration varchar(20) not null,
fac_id int,
foreign key(fac_id) references faculty(fac_id));

select * from faculty;
select * from student;