
CREATE TABLE actor (
    ActID CHAR(4) NOT NULL,
    ActName VARCHAR2(20),
    ActSex CHAR(8) NOT NULL,
    CHECK (ActSex IN ('Male', 'Female')),
    PRIMARY KEY (ActID)
);

INSERT INTO actor
VALUES('M61', 'Marilyn Monroe', 'Female');
INSERT INTO actor
VALUES('H876', 'Tom hanks', 'Male');
INSERT INTO actor
VALUES('W323', 'John wayne', 'Male');

-- test null
INSERT INTO actor
VALUES('W333', 'Harry Potter', NULL);

-- test unknown
INSERT INTO actor
VALUES('W333', 'Harry Potter', 'unknown');

CREATE TABLE movie (
    MovieID CHAR(4) NOT NULL,
    MovieName VARCHAR(40),
    MovieYR INT,
    MovieRating VARCHAR(4) NOT NULL,
    CHECK(MovieRating IN ('G', 'PG', 'PG13', 'R')),
    PRIMARY KEY(MovieID)
);

INSERT INTO movie
VALUES ('M654', 'Godfather', 1995, 'PG');

INSERT INTO movie
VALUES ('R321', 'The Rock', 2003, 'PG13');

INSERT INTO movie
VALUES ('S876', 'Skyfall', 2011, 'R');

INSERT INTO movie
VALUES ('SN12', 'SnowWhite', 1944, 'G');

INSERT INTO movie
VALUES ('MM12', 'Mickey Mouse', 1938, 'G');

-- test rating
INSERT INTO movie
VALUES ('M666', 'Test', 2020, 'PG4');

-- test null
INSERT INTO movie
VALUES ('M666', 'Test', 2020, NULL);

CREATE TABLE salary (
    MovieID CHAR(4),
    ActID CHAR(4),
    SalaryPaid DECIMAL(8,2),
    FOREIGN KEY (MovieID) REFERENCES movie(MovieID)
    ON DELETE CASCADE,
    FOREIGN KEY (ActID) REFERENCES actor(ActID)
    ON DELETE CASCADE
);

INSERT INTO salary
VALUES ('S876', 'W323', 500000);

-- test 
INSERT INTO salary
VALUES ('S876', 'K323', 500000);

-- for Q3 test 

INSERT ALL
INTO actor (ActID, ActName, ActSex)
VALUES ('H333', 'Harry Potter', 'Male')
INTO movie (MovieID, MovieName, MovieYR, MovieRating)
VALUES ('HP34', 'Prisoner of Azkaban', 2016, 'G')
INTO salary (MovieID, ActID, SalaryPaid)
VALUES ('HP34', 'H333', 300000)
SELECT * FROM dual;

-- for Q6 test 

INSERT ALL 
INTO actor (ActID, ActName, ActSex)
VALUES ('H444', 'Angelina Julie', 'Female')
INTO movie (MovieID, MovieName, MovieYR, MovieRating)
VALUES ('HP44', 'Spy 2016', 2016, 'R')
INTO salary (MovieID, ActID, SalaryPaid)
VALUES ('HP44', 'H444', 300000)
SELECT * FROM dual;

-- for Q7 test 

INSERT ALL
INTO actor (ActID, ActName, ActSex)
VALUES ('T007', 'Danial Craig', 'Male')
INTO movie (MovieID, MovieName, MovieYR, MovieRating)
VALUES ('M123', 'Casino Royale', 2016, 'R')
INTO salary (MovieID, ActID, SalaryPaid)
VALUES ('M123', 'T007', 700000)
SELECT * FROM dual;

-- ------------------------FINAL --------------------------------

-- Q1:

CREATE TABLE actor
(
    ActID CHAR(4) NOT NULL,
    ActName VARCHAR2(20),
    ActSex CHAR(8) NOT NULL,
    CHECK (ActSex IN ('Male', 'Female')),
    PRIMARY KEY (ActID)
);

CREATE TABLE movie
(
    MovieID CHAR(4) NOT NULL,
    MovieName VARCHAR(40),
    MovieYR INT,
    MovieRating VARCHAR(4) NOT NULL,
    CHECK(MovieRating IN ('G', 'PG', 'PG13', 'R')),
    PRIMARY KEY(MovieID)
);

CREATE TABLE salary
(
    MovieID CHAR(4),
    ActID CHAR(4),
    SalaryPaid DECIMAL(8,2),
    FOREIGN KEY (MovieID) REFERENCES movie(MovieID)
    ON DELETE CASCADE,
    FOREIGN KEY (ActID) REFERENCES actor(ActID)
    ON DELETE CASCADE
);

-- Q2:

INSERT ALL
INTO actor (ActID, ActName, ActSex)
VALUES ('W323', 'John Wayne', 'Male')
INTO movie (MovieID, MovieName, MovieYR, MovieRating)
VALUES ('R34', 'Rio Grande', 1954, 'G')
INTO salary (MovieID, ActID, SalaryPaid)
VALUES ('R34', 'W323', 200000)
SELECT * FROM dual;

-- Q3:

SELECT AVG(SalaryPaid) AS Male_salary_2016
FROM actor INNER JOIN salary ON actor.ActID = salary.ActID
INNER JOIN movie ON salary.MovieID = movie.MovieID
WHERE ActSex = 'Male' AND movie.MovieYR = 2016;

-- Q4:

SELECT ActName
FROM actor
WHERE ActID NOT IN (SELECT ActID
                        FROM salary
                        INNER JOIN movie ON salary.movieID = movie.movieID
                        WHERE movie.MovieYR = 2016); 

-- Q5:

SELECT MovieRating, COUNT(MovieRating) AS Movies_2016
FROM movie
WHERE movieYr = 2016
GROUP BY movieRating;

-- Q6:

-- a

WITH T AS (SELECT a.actName, sum(s.SalaryPaid) AS chart
FROM actor a
JOIN salary s ON a.ActID = s.ActID
JOIN movie m ON m.movieID = s.movieID
WHERE a.ActSex = 'Female'
AND m.MovieYr = 2016
GROUP BY a.ActName
)
SELECT ActName, chart
FROM T
WHERE chart IN (SELECT MAX(chart)
                FROM T);

-- b

CREATE VIEW myView
AS
    SELECT DISTINCT ActName, SUM(SalaryPaid) AS SALARY_EARNED
    FROM ((salary
        LEFT OUTER JOIN actor ON salary.ActID = actor.ActID)
        LEFT OUTER JOIN movie ON salary.MovieID = movie.MovieID)
    WHERE movie.movieYr = 2016
        AND actor.ActSex = 'F'
    GROUP BY ActName;
--  then query view

-- Q7:
-- NOTE: My referential integrity is set to ON DELETE CASCADE
--       For me just simple delete command should work.

DELETE
FROM movie
WHERE movieID = 'M123';

-- Another way is to delete from child first and then from parent

DELETE
FROM salary
WHERE movieID = 'M123';
DELETE
FROM movie
WHERE movieID = 'M123';
COMMIT;

--  a way to do it in mySQL
DELETE movie, salary
FROM movie
INNER JOIN salary ON movie.movieID = salary.movieID
WHERE movieID = 'M123'; 

-- Q8:

ALTER TABLE movie
DROP COLUMN MovieRating;

-- Q9:

SELECT COUNT(m.MovieID) AS Number_0f_Movies,
SUM(s.SalaryPaid) AS Total_Paid
FROM movie m
JOIN salary s ON m.movieID = s.movieID
JOIN actor a ON s.ActID = a.ActID
WHERE ActName = 'Marilyn Monroe';

-- Q10:

CREATE VIEW MM AS
SELECT m.MovieName, m.movieYr, s.SalaryPaid
FROM SYSTEM.movie m
    JOIN salary s ON m.movieID = s.movieID
    JOIN actor a ON s.ActID = a.ActID
WHERE a.ActID = 'M61';

SELECT SalaryPaid, MovieName
FROM MM
ORDER BY MovieYr;

-- Q11:
-- Answer:  b) Primary Key may contain duplicate values

-- Q12:
-- Answer:  d) STDDEV

-- Q13:
-- Answer:  C)

SELECT AVG(SalaryPaid)
FROM salary
GROUP BY ActID;

-- Q14:
-- Answer:  d) other
-- Comment: 'a' works on my db somewhat but the question is confusing for me
        --: if I just think of movie table then a should be fine
        --: but I think you are asking about a particular actor to check for
        --: so in that case d) other is right

SELECT movieID, LAST_VALUE(MovieYR)
OVER (PARTITION BY movieID ORDER BY MovieYR)
FROM movie;

-- Q15:
-- Answer:  d) other

-- Q16:
-- Answer:  d) other
