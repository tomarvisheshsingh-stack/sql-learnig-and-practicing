use practice;

create table kuchbhi(
id int,
name char(40),
email varchar(40),
age int,
city varchar(30));

describe kuchbhi;
 
-- adding constraints first
alter table kuchbhi add primary key(id);

alter table kuchbhi modify column name varchar(30) not null;

alter table kuchbhi add constraint u_email unique(email);

alter table kuchbhi add constraint c_age check(age>22);

alter table kuchbhi alter column city set default "Delhi";

-- removing the constraints 
alter table kuchbhi drop primary key;

alter table kuchbhi modify column name varchar(30) null;

alter table kuchbhi drop index u_email;

alter table kuchbhi drop check c_age;

alter table kuchbhi alter column city drop default;