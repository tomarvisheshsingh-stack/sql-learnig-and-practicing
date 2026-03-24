use cybrom;

create table faculty(`faculty id` int primary key auto_increment,
`faculty name` varchar(30),
`faculty city` varchar(20) default "Bhopal");

create table courses(course_id int primary key,
course_name varchar(30),
course_duration varchar(10));

create table students(`student id` int primary key,
`student name` varchar(30),
`student age` int,
fac_id int,
course_id int,
foreign key(fac_id) references faculty(`faculty id`),
foreign key(course_id) references courses(course_id));

select * from faculty;
select * from courses;
select * from students;

describe students;