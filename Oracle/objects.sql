--------------------------
-- Create schema objects
--------------------------

CREATE TABLE emp
(
    empno       NUMBER(10)
                CONSTRAINT emp_pk PRIMARY KEY,
    ename       VARCHAR2(20)
                CONSTRAINT emp_ename_not_null NOT NULL,
    job         VARCHAR2(20)
                CONSTRAINT emp_job_not_null NOT NULL,
    mgr         NUMBER(10),
    hiredate    DATE 
                CONSTRAINT emp_hiredate_not_null NOT NULL,
    sal         NUMBER(10)
                CONSTRAINT emp_sal_not_null NOT NULL,
    comm        NUMBER(10),
    deptno      NUMBER(10)
                CONSTRAINT emp_deptno_not_null NOT NULL
);

CREATE TABLE dept
(
    deptno      NUMBER(10)
                CONSTRAINT dept_pk PRIMARY KEY,
    dname       VARCHAR2(30)
                CONSTRAINT dept_dname_not_null NOT NULL,
    loc         VARCHAR2(30)
                CONSTRAINT detp_loc_not_null NOT NULL
);

---------------
-- Load data
---------------

INSERT INTO emp VALUES (7369, 'SMITH',  'CLERK',    7902, DATE '1980-12-17', 800,  NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN',  'SALESMAN', 7698, DATE '1981-02-02', 1600, 300,  30);
INSERT INTO emp VALUES (7521, 'WARD',   'SALESMAN', 7698, DATE '1981-02-22', 1250, 500,  30);
INSERT INTO emp VALUES (7566, 'JONES',  'MANAGER',  7839, DATE '1981-04-02', 2975, NULL, 20);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN', 7698, DATE '1981-09-28', 1250, 1400, 30);
INSERT INTO emp VALUES (7698, 'BLAKE',  'MANAGER',  7839, DATE '1981-05-01', 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK',  'MANAGER',  7839, DATE '1981-06-09', 2450, NULL, 10);
INSERT INTO emp VALUES (7788, 'SCOTT',  'ANALYST',  7566, DATE '1987-04-19', 3000, NULL, 20);
INSERT INTO emp VALUES (7839, 'KING',   'PRESIDENT',NULL, DATE '1981-11-17', 5000, NULL, 10);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN', 7698, DATE '1981-09-08', 1500, 0,    30);
INSERT INTO emp VALUES (7876, 'ADAMS',  'CLERK',    7788, DATE '1987-05-23', 1100, NULL, 20);
INSERT INTO emp VALUES (7900, 'JAMES',  'CLERK',    7698, DATE '1981-12-03', 950,  NULL, 30);
INSERT INTO emp VALUES (7902, 'FORD',   'ANALYST',  7566, DATE '1981-12-03', 3000, NULL, 20);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK',    7782, DATE '1982-01-23', 1300, NULL, 10);

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');