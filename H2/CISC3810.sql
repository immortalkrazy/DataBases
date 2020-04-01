select user();
show tables;
create table first_table;

-- 	select from the table*/
select distinct * from first_table
select * from first_table;

--	make changes in the table
alter table first_table add column(firstcolumn varchar(20));  /*upto 20 characters*/

-- 	adding items */
insert into first_table values('first_1st_item');
insert into first_table values('first_2nd_item');
insert into first_table values('first_3rd_item');

--	delete a row from the table */
delete from first_table where firstcolumn='first_1st_item';
delete from first_table;

-- 	delete data from table
truncate table first_table;
show tables;
-- 	delete the table itself
drop table first_table;
-- 	create a new table
create table workers(ID int primary key,
                                 Name varchar(50),
                                 Salary int);
insert into workers values(1,'john',10000);
select * from workers;
insert into workers values(2,'jack',20000);

primary key: is  akey which can be distictly idetified
			 must be unique.

select * from workers;

create table customers(cust_id int not null, --use as primary key
                                     customer_name varchar(100),
                                     cust_email text,
                                     constraint custPK  primary key(cust_id));

show columns from customers;

------------------------------9/12/19-------------------------------------

select * from customers;

-- 	insert multiple values at a time
insert into customers values (4, 'lisa', 'liss@gmail.com'), (6, 'mir', 'mir@cuny.edu');

-- 	insert multiple values providing the sequence of entry first
insert into customers (customer_name, cust_id , cust_email)
					  values ('lee', 5, 'lee@yahoo.com'),
					         ('bob', 7, 'lee@hotmail.com');

-- 	create a new table
create table playlist (filename varchar(50),
                                 location text,
                                 file_order int);


--	change the format of the table columns
-- 	change filename column to be not nullsince we want to use it as key
alter table playlist  alter column filename set not null;

--	change the location column to be varchar since text didnt work
alter table playlist  alter column location varchar(150);


// 	make a multifactor key for table "playlist"
alter table playlist add constraint plistPKey primary key (filename, location);

--	make "cust_id" foreign key for the table "orders" and for the column

create table orders (order_no int primary key,
                                cust_id int,
                                foreign key (cust_id) references
							   customers (cust_id));

---------------------------Homework 1---------------------------------------
create table products (product_no int,
                       company_name varchar(50),
                       model_no varchar(50) not null, --use as primary key
                       product_name varchar(50),
                       constraint prodPK primary key(model_no));
insert into products values (1, 'Sony', 'DVM60', 'Head Phone');
insert into products values (2, 'Samsung', 'GFR765', 'HD TV'),
                                           (3, 'LG', 'GFDT-98', 'HD TV');

insert into products (model_no, product_name, company_name, product_no)
                                values ('puht656g', 'earpiece', 'Toshiba', 4),
                                           ('tgh345', 'calculator', 'casio', 5);

show tables;
select * from products;



--------------------------09/17/201-----------------------------------------

select * from customers;
select * from customers where customer_name = 'faisal';
select * from orders where cust_id = 1;
select * from orders where cust_id = 1 and order_no = 137;
show databases;
show tables;
-- how to remove column from table
select * from customers c, orders o where c.cust_id=o.cust_id;

--------------------------09/19/201-----------------------------------------
select * from customers;
select * from orders;

-- if u delete something from parent table P>customer C>order
delete from customers where cust_id = 4;
-- I will get an error "referential integrity constraint violation"
-- constraints-->> h2 dosen't allow deletion of parent if

-- auto increment a value in the table
create table sales_purchase (sales_ordNo int primary key auto_increment,
                                               item_no int,
                                               quantity int,
                                                price real);
insert into sales_purchase values (default, 2184, 4, 35.75),
                                  (default, 616, 50, 25.99);
select * from sales_purchase;

-- run insert again with the same data */
insert into sales_purchase values (default, 2184, 4, 35.75),
                                  (default, 616, 50, 25.99);
select * from sales_purchase;

------------------------------------------------------------------
