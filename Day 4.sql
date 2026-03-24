--  Primary Key and Foreign Key

create database foreign_key;

use foreign_key;

create table doctor_info(
id int primary key, 
doct_name varchar(30) not null,
doct_city varchar(30) default "Bhopal");

create table patient_info(
id int primary key,
patient_name varchar(30) not null,
patient_age int,
doct_id int not null,
foreign key(doct_id) references doctor_info(id));

describe doctor_info;
describe patient_info;