use ecom;

# limit - shows the no. of rows set as limit
# offset - shows the no. of rows set on limit after dropping the number of rows set at offset

select * from customers where country = "USA" order by creditlimit asc limit 5;

select * from customers where country = "USA" order by creditlimit asc limit 5 offset 4;

select * from customers c inner join orders o 
on c.customernumber = o.customernumber
order by creditlimit desc limit 10;

select * from customers c inner join orders o 
on c.customernumber = o.customernumber
order by creditlimit desc limit 1 offset 26;

select c.customernumber, o.ordernumber, c.customername, c.phone, c.creditlimit  from customers 
c inner join orders o 
on c.customernumber = o.customernumber
where country = "USA"
order by creditlimit desc limit 5;

-- Joins for multiple table

select * from customers c inner join orders o on c.customernumber = o.customernumber 
inner join orderdetails od on o.ordernumber = od.ordernumber;

select c.customernumber, c.customername, c.creditlimit, o.ordernumber, 
o.orderdate, o.status, od.quantityordered, od.priceeach, 
(od.quantityordered * od.priceeach) as total_price from customers c
inner join orders o on c.customernumber = o.customernumber 
inner join orderdetails od on o.ordernumber = od.ordernumber;

-- orderby, limit, offset, in, not in, where 