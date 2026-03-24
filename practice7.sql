use practice;

create table random_(id int primary key,
name varchar(20) not null,
`last name` varchar(20) unique,
`age` int check(age>18),
city varchar(10) default "Bhopal");

describe random_;

-- drop primary key
alter table random_ drop primary key;

-- drop not null constraint
alter table random_ drop not null; #doesn't work like this
-- have to use modify command
alter table random_ modify column name varchar(20) null;

-- drop unique constraint
alter table random_ drop index `last name`;

-- drop check constraint
alter table random_ drop check random__chk_1;

-- drop default constraint
alter table random_ alter column city drop default;