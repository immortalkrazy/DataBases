create table dept
(
	deptno number(2)
	constraint dp_key primary key,
	dname varchar2(20)
	constraint dn_notnull not null,
	loc varchar2(20)
);

create table emp
(
	empno   	number(4)
				constraint emp_key primary key,
	ename 		varchar2(10)
				constraint name_notnull not null,
	job 		varchar2(20),
	mgr 		number(4),
	hiredate 	date
				constraint date_notnull not null,
	sal 		number(10),
	comm 		number(10),
	deptno 		number(2)
);
