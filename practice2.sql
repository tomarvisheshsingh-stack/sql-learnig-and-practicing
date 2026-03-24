use practice;

create table doc_info(
doc_id int primary key auto_increment,
doc_name varchar(30),
doc_age int check(doc_age>=25),
specialization varchar(20),
doc_city varchar(20) default 'Bhopal');

insert into doc_info(doc_name, doc_age, specialization) values
('Vishal', 26, 'Family Medicine'),
('Rahul', 34, 'Cardiologist'),
('Geeta', 46, 'Neurologist'),
('John', 55, 'Dermatologist'),
( 'Joseph', 31, 'General Surgeon'),
( 'Priya', 26, 'Gynecalogist'),
( 'Waqar', 51, 'Orthopedic Surgeon');

drop table patient_info;
drop table doc_info;
select * from doc_info;

create table patient_info(
id int primary key,
first_name varchar(30) not null,
last_name varchar(30),
doc_id int not null,
age int not null,
illness varchar(30) not null,
treatment_status varchar(20) not null,
nurse_id varchar(4) not null,
foreign key(nurse_id) references nurse_info(nurse_id),
foreign key(doc_id) references doc_info(doc_id));

describe patient_info;

insert into patient_info(id, first_name, last_name, doc_id, age, illness, treatment_status, nurse_id) values
(1, 'Ram', 'Goyal', 102, 67, 'Cardiac Attack', 'Ongoing', 'N10'),
(2, 'Ramesh', 'Verma', 104, 23, 'Accident scars on face', 'Completed', 'N09'),
(3, 'Renu', 'Parmar', 107, 56, 'Hip replacement surgery', 'Scheduled', 'N05'),
(4, 'Aditya', 'Rathore', 101, 14, 'Viral fever', 'First visit', 'N01'),
(5, 'Komal', 'Rathore', 101, 11, 'Viral fever', 'First visit', 'N02'),
(6, 'Rina', 'Agarwal', 106, 29, 'Pregrency', 'Ongoing', 'N03'),
(7, 'Mahesh', 'Verma', 103, 71, 'Brain Hemorrhage', 'Completed', 'N08'),
(8, 'Ramakant', 'Shivhare', 105, 45, 'Gallbladder removal', 'Scheduled', 'N06'),
(9, 'Aarav', 'Singh', 101, 19, 'Common Cold', 'Completed', 'N01'),
(10, 'Tejaswini', 'Dua', 101, 23, 'Malaria', 'Ongoing', 'N04'),
(11, 'Ram', 'Sharma', 107, 77, 'Spinal fusion', 'Completed', 'N07'),
(12, 'Avni', 'Mehra', 102, 42, 'Arota Blockage', 'Completed', 'N10'),
(13, 'Sachin', 'Jadeja', 107, 33, 'ACL Tear', 'Ongoing', 'N06'),
(14, 'Ravindra', 'Tendulakar', 105, 45, 'Hernia', 'Ongoing', 'N07'),
(15, 'Ken', 'Shelby', 104, 63, 'Wrinkles', 'Ongoing', 'N09');

select*from patient_info;

create table nurse_info(
nurse_id varchar(4) primary key,
name varchar(30) not null, 
gender ENUM('Male', 'Female') not null,
age int check(age>=21),
department varchar(50) not null,
years_of_experience int);

insert into nurse_info(nurse_id, name, gender, age, department, years_of_experience) values
('N01', 'Rahul Dev', 'Male', 24, 'OPD', 2),
('N02', 'Rena Ben', 'Female', 33, 'OPD', 11),
('N03', 'Priya Roy', 'Female', 42, 'Obstetrica and Gynaecology', 20),
('N04', 'Riya Biswas', 'Female', 26, 'OPD', 3),
('N05', 'Prem Sharma', 'Male', 28, 'Department of Surgury', 5),
('N06', 'Gloria Raymond', 'Female', 31, 'Department of Surgury', 8),
('N07', 'Aditya Tanwar', 'Male', 29, 'Departmetn of Surgury', 6),
('N08', 'Donald Love', 'Male', 34, 'Neurology Department', 12),
('N09', 'Falguni Pathak', 'Female', 36, 'Dermatology Department', 14),
('N10', 'Sadia Malik', 'Female', 30, 'Cardiology Department', 7);

describe doc_info;

select * from doc_info;

update doc_info set doc_city = "Delhi" where doc_id >= 4;

alter table doc_info add column city varchar(40) not null;

insert into doc_info(city) values
('Bhopal'),
("REwa");

set sql_safe_updates = 0;
set sql_safe_updates = 1;

delete from doc_info where city = "REwa";