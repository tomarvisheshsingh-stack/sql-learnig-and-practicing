create database joins;

use joins;

create table table1(id varchar(5));

create table table2(ids varchar(5));

insert into table1(id) values (1), (2), (3), ('a'), ('b'), (null), (null);

insert into table2(ids) values (1), (1), (3), (3), ('b'), ('b'), (null), (null), (4);

select * from  table1 inner join table2 on table1.id = table2.ids;

select * from  table1 inner join table2 on table1.id = table2.ids;

select * from  table1 right join table2 on table1.id = table2.ids;

select * from  table1 left join table2 on table1.id = table2.ids;

select * from  table1 cross join table2;

select * from  table1 natural join table2;

-- full join :- use of union
select * from  table1 left join table2 on table1.id = table2.ids
union
select * from  table1 right join table2 on table1.id = table2.ids;

-- left outer join
select * from table1 left join table2 on table1.id = table2.ids where table2.ids is null;

-- right outer join
select * from table1 right join table2 on table1.id = table2.ids where table1.id is null;

use ecom;
select * from employees;
describe employees;

-- self join
select e1.firstname, e1.lastname, e2.firstname, e2.lastname from employees e1 
inner join employees e2 on e1.employeenumber = e2.reportsto;

select e1.employeenumber, e1.firstname, e2.employeenumber, e2.firstname from employees e1
join employees e2 on e1.reportsto = e2.employeenumber;