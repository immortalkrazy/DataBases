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
WHERE C = 'Black' AND C != 'White' AND N > 1
ORDER BY P;

-- d 
DELETE
FROM J
WHERE C = 'Red';

-- e
UPDATE J
SET N = N + 3
WHERE A > 30;

-- f
SELECT C, SUM(N) AS colorCount
FROM J
GROUP BY C
ORDER BY colorCount;

-- g
SELECT P, COUNT(C) AS colorCount
FROM J
WHERE P = 'Melissa';