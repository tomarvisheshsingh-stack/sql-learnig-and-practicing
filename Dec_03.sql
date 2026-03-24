use practice;

create table random1(
id int primary key,
randomvalues varchar(30),
abcd int);


create table random2(id int primary key,
defg varchar(30), 
`random id` int,
foreign key(`random id`) references random1(id));

drop table random2;

alter table random2 drop foreign key f_id;
alter table random2 drop key `random id`;

alter table random2 add constraint f_id foreign key(`random id`) references random1(id);