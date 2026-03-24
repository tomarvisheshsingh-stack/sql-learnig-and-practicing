use foreign_key;

create table info23(id int primary key,
name varchar(20) primary key,
city varchar(30) default "Bhopal");


create table info23(id int,
name varchar(20),
city varchar(30) default "Bhopal",
primary key(id, name));

describe info23;


create table info24(id int not null unique,
name varchar(20) not null unique,
city varchar(30) default "Bhopal");

describe info24;
drop table info24;