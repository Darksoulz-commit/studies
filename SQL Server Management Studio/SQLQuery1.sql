create database shoes;

use shoes;

-- product
create table product(
product_id varchar(20) primary key,
p_name varchar(23));

insert into product (product_id, p_name) 
values('P01', 'Nike'),
('P02', 'US Polo'),
('P03', 'Puma');

insert into product (product_id, p_name) 
values('P04', 'Paragon'),
('P05', 'Sparx'),
('P06', 'Bata');

select * from product;


--product price

create table price(
product_id varchar(20),
pricez decimal(7,2));

insert into price (product_id, pricez) 
values('P01',1000 ),
('P02', 2000),
('P01', 4000);

insert into price (product_id, pricez) 
values('P66',1000 ),
('P52', 2000),
('P21', 4000);


select * from price;



select p.*, pp.pricez from product as p
 join price as pp
on p.product_id = pp.product_id;

create table quantity(
product_id varchar(20),
quant int not null);

insert into quantity(product_id, quant) 
values('P01',10 ),
('P02', 20),
('P03', 40);

select p.*, pp.pricez, q.quant from product as p
join price as pp
on p.product_id = pp.product_id
join quantity as q
on pp.product_id=q.product_id;

select p.*, pp.pricez, q.quant from product as p
right join price as pp
on p.product_id = pp.product_id
right join quantity as q
on pp.product_id=q.product_id;


create table employee(
 emp_id tinyint,
 emp_name varchar(100),
 salary decimal(10,2),
 dept_id tinyint,
 manager_id tinyint);


 insert into employee (emp_id, emp_name, salary. dept_id, manager_id)values
 (1, 'Emma', 100,16),
 (2, 'Macho', 100,26),
 (3, 'Martin', 100,10),
 (4, 'tessa', 100,30),
 (5, 'korn', 100,25);