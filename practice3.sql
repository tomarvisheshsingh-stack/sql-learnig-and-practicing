use practice;

create table teachers(
teach_id int,
teach_name varchar(30),
subject varchar(20),
`teaching experience` tinyint not null,
gender ENUM("Male", "Female"),
primary key(teach_id, teach_name));

create table subjects(
sub_id varchar(10),
sub_name varchar(20),
teach_id int,
primary key(sub_id),
foreign key(teach_id) references teachers(teach_id));

create table students(
`student id` int primary key,
`student name` varchar(20) not null,
student_age tinyint,
teach_id int not null,
subject_id varchar(10) not null,
foreign key(teach_id) references teachers(teach_id),
foreign key(subject_id) references subjects(sub_id));

