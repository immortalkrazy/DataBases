create table dept (
deptno number(2) PRIMARY KEY,
dname varchar2(20),
loc varchar2(20));
)

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