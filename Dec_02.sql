use practice;

create table employees(
email varchar(30),
age int,
salary decimal(7,2));

describe employees;

alter table employees add constraint u_email unique	(email);

alter table employees modify column email varchar(255);

alter table employees add constraint age_check check(age>22);

alter table employees add constraint s_default default 0;  #doesn't work

alter table employees modify column salary decimal(7,2) default 0;

alter table employees alter column salary set default 0;

alter table employees drop index u_email;

alter table employees drop check age_check;

alter table employees alter column salary drop default;

alter table employees add constraint Q_null not null(email);  #doesn't work

alter table employees modify column email varchar(255) not null;

alter table employees add column id int;

alter table employees add constraint primary key (id);
-- or
alter table employees add primary key;
alter table employees drop primary key;