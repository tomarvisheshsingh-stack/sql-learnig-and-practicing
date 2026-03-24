use cybrom;
show tables;
show engines;

create table info2(id int not null unique, name varchar(30) not null, age int check(age>18));

insert into info2(id, name, age) values
(2, 'Rahul', 19),
(3, 'Ram', 22);

describe info2;

select * from info2;

create table info3(id int not null, name varchar(30) not null, age int check(age>18));
describe info3;

create table info4(id int not null, name varchar(30) not null, age int check(age>18), city varchar(30) default "Bhopal");
describe info4;
insert into info4(id, name, age) values
(2, 'Rahul', 19),
(3, 'Ram', 22);
select * from info4;
insert into info4(id, name, age, city) values
(1, 'Rahul', 19, null),
(5, 'Ram', 22, 'Bhopal');
