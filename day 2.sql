create database cybrom;

use cybrom;

create table info(id int, name varchar(30), city char(10), DoB date, salary decimal(5,2));

insert into info(id, name, city, DoB, salary) values
(4, 'Vish', 'Gwalior', "2000-07-04", 210.50),
(5, 'Priyal', 'Bhopal', "2004-12-01", 259.50),
(6, 'Ramu', 'Indore', "2002-03-12", 310.90);

select * from info;

-- constraints
-- unique, not null, check, default

create table info1(id int unique not null, name varchar(30), city char(10), DoB date, salary decimal(5,2) not null);

describe info1;

insert into info1(id, name, city, DoB, salary) values
(1, 'Vish', 'Gwalior', "2000-07-04", 210.50),
(2, 'Priyal', 'Bhopal', "2004-12-01", 259.50),
(3, 'Ramu', 'Indore', "2002-03-12", 310.90);

select * from info1;