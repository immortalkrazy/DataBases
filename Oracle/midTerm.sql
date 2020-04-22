-- /////-- TRUE/FALSE --///// --

-- 1    True
-- 2    True
-- 3    True
-- 4    True
-- 5    True

/* You want to have a table called J (for JellyBeans) with fields 
for the name of a person, the age of the person, the name of a color, 
and the number of jelly beans of that color the person ate. The fields
are called P (for the person’s name), A(for the person’s age), 
C (for the color’s name), and N (for the number eaten). 
A person can eat more than one color jelly bean, and a color can be 
eaten by more than one person. */

-- a
CREATE TABLE J (
    id NUMERIC(4)
        CONSTRAINT id_PK PRIMARY KEY,
    P VARCHAR2(20),
    A NUMERIC(2),
    C VARCHAR2(10),
    N NUMERIC(4)
);

CREATE SEQUENCE id MINVALUE 11 START WITH 11 CACHE 100;

INSERT INTO J
VALUES (101,'Marry', 19, 'Blue', 15);

DELETE FROM J
WHERE id = 101;

INSERT INTO J
VALUES (id.nextval,'James', 21, 'Black', 10);

INSERT INTO J
VALUES (id.nextval,'Ana', 18, 'Red', 15);

-- b
INSERT INTO J
VALUES (id.nextval, 'Marry', 19, 'Blue', 15);

INSERT INTO J
VALUES(id.nextval, 'Smith', 35, 'Graan', 12);

INSERT INTO J
VALUES(id.nextval, 'Harry', 19, 'Red', 10);

INSERT INTO J
VALUES(id.nextval, 'Potter', 32, 'Red', 10);

INSERT INTO J
VALUES(id.nextval, 'Potter', 32, 'White', 10);

SELECT *
FROM J;

UPDATE J
SET N = 15
WHERE P = 'Ana';

UPDATE J
SET A = 35
WHERE P = 'Smith';

INSERT INTO J
VALUES (id.nextval, 'Melissa', 23, 'Pink', 15);

INSERT INTO J
VALUES (id.nextval, 'Melissa', 23, 'Blue', 10);

INSERT INTO J
VALUES (id.nextval, 'Melissa', 23, 'Purle', 6);

INSERT INTO J
VALUES (id.nextval, 'Mark', 25, 'Purle', 18);

INSERT INTO J
VALUES (id.nextval, 'Thomas', 28, 'White', 20);

UPDATE J
SET C = 'Black'
WHERE P = 'Potter';

-- c
SELECT P, A
FROM J
WHERE C ='Black' 
AND N >=1 
AND P IN (SELECT DISTINCT P 
          FROM J
          WHERE C = 'White' 
          AND N >= 1)
ORDER BY P;

-- d 
DELETE
FROM J
WHERE C = 'Red';

-- e
UPDATE J
SET N = N + 3
WHERE A >= 30;

-- f
SELECT C, SUM(N) AS colorCount
FROM J
GROUP BY C
ORDER BY colorCount;

-- g1
SELECT DISTINCT P, COUNT(C) AS myCount
FROM J
GROUP BY P
HAVING P LIKE 'Melissa';

-- g2 (2nd way)
CREATE VIEW melissa
AS SELECT *
FROM J
WHERE P = 'Melissa';

SELECT COUNT(C) AS Melissa
FROM Melissa;

-- h
SELECT C, AVG(N)
FROM J
GROUP BY C
ORDER BY C;

-- i
SELECT A, MAX(N)
FROM J
GROUP BY A
ORDER BY A;

-- j
SELECT A, MIN(N)
FROM J
GROUP BY A
ORDER BY A;

-- k
SELECT A, SUM(N)
FROM J
GROUP BY A
ORDER BY A;

SELECT A, SUM(N)
FROM J
GROUP BY A;

-- l
CREATE VIEW greenJelly
AS SELECT P, A
    FROM J
    WHERE C = 'Green'
    ORDER BY A;

SELECT *
FROM greenJelly
ORDER BY P, A DESC;

UPDATE J
SET C = 'Green'
WHERE P = 'Smith';

INSERT INTO J
VALUES (id.nextval, 'Thomas', 28, 'Green', 20);

-- m
SELECT COUNT(O) AS Count_Of_DSs
FROM W
WHERE O = 'Data Scientist';

-- n
SELECT DISTINCT w.N, j.A
FROM W w, J j
WHERE (w.O IS NULL OR w.O IS NOT null)
AND w.N = j.P;

-- n2 (using left outer join)
SELECT DISTINCT w.N, j.A
FROM W w LEFT JOIN J j ON w.N = j.P;

-- o1
SELECT DISTINCT P
FROM J
WHERE N > (SELECT AVG(N)
            FROM J)
ORDER BY P;

-- o2
SELECT DISTINCT P, N
FROM J
WHERE N > (SELECT AVG(N)
FROM J)
ORDER BY P;

-- o3
SELECT DISTINCT P, N
FROM J
WHERE N > (SELECT AVG(N)
           FROM J)
ORDER BY N;

-- p
SELECT COUNT(A)
FROM greenJelly
WHERE A < 15;

-- q1
SELECT DISTINCT P
FROM J
WHERE P LIKE '%s';

-- q2
SELECT DISTINCT P
FROM J
WHERE P = '%s';

-- q3
SELECT DISTINCT P
FROM J
WHERE P = '____s';

-- r1
SELECT DISTINCT P
FROM J
WHERE P LIKE 'S%';

-- r2
SELECT DISTINCT P
FROM J
WHERE P LIKE 'S____';

-- r3
SELECT DISTINCT P
FROM J
WHERE P = 'S%';

/*
Assume you have a second TABLE, called W (FOR Workers)
WITH fields FOR the name OF a worker (N) AND the 
occupation OF a worker (O). This TABLE has already 
been created AND filled WITH VALUES. 
*/

CREATE TABLE W (
    empID CHAR(4)
    CONSTRAINT W_PK PRIMARY KEY,
    N VARCHAR2 (20),
    O VARCHAR2(20)
);

INSERT INTO W
VALUES ('EM01', 'Thomas', 'Lawyer');

INSERT INTO W 
VALUES ('EM02', 'james', 'Lawyer');

INSERT INTO W
VALUES ('EM03', 'Marry', 'Lawyer');

INSERT INTO W
VALUES ('EM04', 'Smith', 'Doctor');

INSERT INTO W
VALUES ('EM05', 'Potter', 'Doctor');

INSERT INTO W
VALUES ('EM06', 'Melissa', 'Doctor');

INSERT INTO W
VALUES ('EM07', 'Edison', 'Data Scientist');

UPDATE W
SET N = 'James'
WHERE empID = 'EM02';

-- s
SELECT j.P, j.A, w.O
FROM J j, W w
WHERE j.P = w.N AND j.N >= 1;
-- t
(SELECT P
FROM J
WHERE C IN ('Blue', 'Pink'))
INTERSECT
(SELECT N
FROM W
WHERE O IN ('Doctor', 'Lawyer'));

UPDATE W 
SET O = NULL
WHERE empID = 'EM02';

UPDATE W 
SET O = NULL
WHERE empID = 'EM05';

-- /////-- TRUE/FALSE --///// --

-- a    False (column p should be varchar2)
-- b    False (age is a number)
-- c    True  (color is varchar2)
-- d    True  (its a number)
-- e    True  (Occopation has to be varchar2)