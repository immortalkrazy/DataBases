create table dept (
deptno number(2) PRIMARY KEY,
dname varchar2(20),
loc varchar2(20)
);

desc dept;

select *
from dept;

insert into dept values (10, 'ACCOUNTING', 'ARIZONA');

select *
from dept;

select ename, job
from   emp; 

select ename, job
from   emp
where  sal > 2000;

select ename, job, sal 
from   emp
where  sal > 2000;

select ename, job, sal 
from   emp
where  sal > 2000
order by  sal;

select ename, job, sal 
from   emp
where  sal > 2000
order by  sal asc;

select ename, job, sal 
from   emp
where  sal > 2000
order by  sal desc;

select ename, job, sal 
from   emp
where  sal > 2000
order by  ename, job; 

select ename, job, sal 
from   emp
where  sal > 2000
order by 1, 2;


select deptno, sum(sal)
from   emp
group by deptno; 


select deptno, sum(sal)
from   emp
group by deptno
having  sum(sal) > 10000;


select deptno, avg(sal)
from   emp
group by deptno; 

select deptno, max(sal)
from   emp
group by deptno;

select deptno, min(sal)
from   emp
group by deptno;

select empno, ename, comm
from   emp
where  comm is NULL; 

select empno, ename, comm
from   emp
where  comm is NOT NULL; 


select empno, ename
from   emp
where  deptno = 10 or deptno = 20;

select empno, ename, deptno 
from   emp
where  deptno = 10 or deptno = 20; 

select empno, ename, deptno 
from   emp
where  deptno = 10 and deptno = 20; 

select empno, ename, deptno 
from   emp
where  deptno = 10 or deptno = 20 or deptno = 30;

select count(*)
from   emp;

select  count(empno)
from    emp;

select  count(deptno)
from    emp;

select  distinct deptno
from    emp;


select  deptno
from    emp;

select (2+4)
from   dual;

select  sysdate
from    dual;
 
select mod(7,2)
from   dual;

select trunc(7.5657,2)
from   dual;


select trunc(7.5687,2)
from   dual;


select round(7.5687,2)
from   dual;


select INITCAP('hi  there')
from   dual;

select LENGTH('hi  there')
from   dual;


select SUBSTR('Oracle Substring', 1, 6 )
from   dual; 


select SUBSTR(ename, 2,3) 
from   emp; 

select ename, SUBSTR(ename, 2,3) 
from   emp; 


select ename
from   emp
where  substr(ename,0, -1 ) = 'S'; 

select ename
from   emp
where  substr(ename,-1, 1 ) = 'D';


select empno, ename, deptno 
from   emp
where  deptno = 10 or deptno = 20
order by deptno, ename;


SELECT EMPNO, ENAME, JOB, HIREDATE,DEPTNO
FROM EMP
WHERE JOB IN ( 'CLERK', 'ANALYST') AND HIREDATE >= '01-
JAN-82' AND DEPTNO = 20;

-- ClassWork 05/07/2020 --

CREATE TABLE customers (
    customerID NUMERIC(3) PRIMARY KEY,
    customerName VARCHAR2(20),
    customerCity VARCHAR2 (20),
    customerState CHAR(2)
);

CREATE TABLE orders (
    orderNum CHAR(4) PRIMARY KEY,
    customerID NUMERIC(3),
    orderDate DATE,
    orderAmount NUMERIC(8,2),
    hasItBeenPaid CHAR(1)
);

ALTER TABLE orders
ADD CONSTRAINT order_cust_FK FOREIGN KEY(customerID)
REFERENCES customers(customerID) ON DELETE SET NULL;

INSERT INTO customers
VALUES ('&customerID', '&customerName', '&customerCity', '&customerState');

INSERT INTO orders
VALUES ('&orderNum', '&customerID', '&orderDate', '&orderAmount', '&hasItBeenPaid');

-- a
SELECT c.customerName, COUNT(o.orderNum)
FROM customers c JOIN orders o
ON c.customerID = o.customerID
GROUP BY c.customerName;

-- b
SELECT a.customerID, a.customerName
FROM customers a
LEFT OUTER JOIN ORDERS b ON (a.customerID = b.customerID)
WHERE b.orderNum IS null;

-- c
SELECT a.customerID, a.customerName,
SUM (b.orderAmount) AS unpaidamount
FROM customers a
JOIN ORDERS b ON(a.customerID = b.customerID)
WHERE hasItBeenPaid = 'N'
GROUP BY a.customerID, a.customerName;

-- d
SELECT a.customerID, a.customerName, a.customerCity, a.customerState
FROM customers A
WHERE customerCity IN (SELECT customerCity
                       FROM customers
                       GROUP BY customerCity
                       HAVING COUNT(customerID) >= 2);

-- e
SELECT c1.customerName, c2.customerName, c1.customerCity, c1.customerState
FROM customers c1, customers c2
WHERE c1.customerID = c2.customerID
AND   c1.customerCity = c2.customerCity
AND   c1.customerState = c2.customerState;

-- f
SELECT COUNT(*)
FROM orders
GROUP BY hasItBeenPaid;

-- g
UPDATE orders
SET orderAmount = orderAmount + 314.15
WHERE orderDate = '12-Feb-2013';

SELECT SYSDATE
FROM dual;


-- ClassWork 05/14/2020 --

-- Views
-- 
