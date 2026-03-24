create database hospital;

use hospital;

create table departments(
department_id int primary key,
name varchar(30) not null,
description text);

create table doctors(
doctor_id int primary key,
first_name varchar(30) not null,
last_name varchar(20) not null,
specialization varchar(20) not null,
phone varchar(15) unique,
email varchar(40),
department_id int,
foreign key(department_id) references departments(department_id));

create table patients(
patient_id int primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
date_of_birth date not null,
gender ENUM("Male", "Female"),
phone varchar(15) unique not null,
address varchar(50) not null,
email varchar(30) not null,
emergency_contact varchar(15) not null,
created_at datetime);

create table appointments(
appointment_id int primary key auto_increment,
patient_id int,
doctor_id int,
appointment_date date not null,
appointment_time time not null,
status varchar(50) not null,
notes tinytext not null,
foreign key(patient_id) references patients(patient_id),
foreign key(doctor_id) references doctors(doctor_id));

create table medical_records(
record_id int primary key,
patient_id int,
doctor_id int,
diagnosis tinytext not null,
treatment tinytext not null,
date_created date not null,
foreign key(patient_id) references patients(patient_id),
foreign key(doctor_id) references doctors(doctor_id));

create table medications(
med_id int primary key,
name varchar(30) not null,
description tinytext not null,
price decimal(7,2));

create table prescriptions(
prescription_id int primary key,
record_id int,
med_id int,
dosage varchar(40) not null,
frequency varchar(20) not null,
duration varchar(15) not null,
foreign key(record_id) references medical_records(record_id),
foreign key(med_id) references medications(med_id));

create table rooms(
room_id int primary key,
room_number int unique,
room_type varchar(20),
availability_status varchar(20));

create table admissions(
admission_id int primary key,
patient_id int,
room_id int,
doctor_id int,
addmission_date date not null,
discharge_date date,
remarks tinytext,
foreign key(patient_id) references patients(patient_id),
foreign key(doctor_id) references doctors(doctor_id),
foreign key(room_id) references rooms(room_id));

create table Billing(
bill_id int primary key,
patient_id int,
admission_id int,
total_amount decimal(10,2),
payment_status varchar(20),
foreign key(patient_id) references patients(patient_id),
foreign key(admission_id) references admissions(admission_id));