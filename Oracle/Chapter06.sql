/*********************CLASSWORK STUFF************************************/
CREATE TABLE dept
(
    deptNo NUMERIC(2)
        CONSTRAINT dept_PK PRIMARY KEY,
    dName VARCHAR2(20)
        CONSTRAINT dname_NN NOT NULL,
    loc VARCHAR2(20)
);

CREATE TABLE emp
(
    empNo NUMERIC(4)
        CONSTRAINT emp_PK PRIMARY KEY,
    eName VARCHAR2(20)
        CONSTRAINT eName_NN NOT NULL,
    job VARCHAR2(20),
    mgr NUMERIC(4),
    hireDate DATE
        CONSTRAINT hire_date_NN NOT NULL,
    sal NUMERIC (6),
    comm NUMERIC (6),
    deptNo NUMERIC(2)
);

ALTER TABLE emp
    ADD CONSTRAINT emp_dept_RL FOREIGN KEY(deptNO)
    REFERENCES dept(deptNo) ON DELETE SET NULL;

INSERT INTO dept
VALUES
    ('&deptNO', '&dName', '&loc');

INSERT INTO emp
VALUE(7369,
'Smith',
'clerk',
7902,
171280,
800,
NULL,20
);

INSERT INTO emp
VALUES
    ('&empNo', '&eName', '&job', '&mgr', '&hireDate', '&sal', '&comm', '&deptNo');

COLUMN  empNo FORMAT 999999;
COLUMN eName FORMAT a15;
COLUMN job FORMAT a15;
COLUMN  mgr FORMAT 9999;
COLUMN sal FORMAT 999999;
COLUMN comm FORMAT 999999;
COLUMN deptNo FORMAT 999999;

UPDATE dept
SET dName = 'OPERATIONS',
    loc = 'BOSTON'
WHERE deptNo = 40;

/***************************CHAPTER 06 STUFF**************************************/

CREATE TABLE staff(
    staffNo CHAR(4)
    CONSTRAINT staff_pk PRIMARY KEY,
    fName VARCHAR2 (20)
    CONSTRAINT staff_fn_notnull NOT NULL,
    lName VARCHAR2(20)
    CONSTRAINT staff_ln_notnull NOT NULL,
    position VARCHAR(20),
    sex CHAR(1),
    dob DATE,
    salary NUMERIC(7,2),
    branchNo char(4)
);
/*creation of branch table*/
CREATE TABLE branch (
    branchNo CHAR(4)
    CONSTRAINT branch_pk PRIMARY KEY,
    street VARCHAR2(30)
    CONSTRAINT street_notnull NOT NULL,
    city VARCHAR2(20)
    CONSTRAINT city_notnull NOT NULL,
    postcode CHAR(7)
    CONSTRAINT postcode_notnull NOT NULL
);
/* adding a foreign kay in staff table */
ALTER TABLE staff 
    ADD CONSTRAINT staff_gender_check CHECK(sex in ('M', 'F', 'O'));
ALTER TABLE staff
    ADD CONSTRAINT staff_branch_FK FOREIGN KEY(branchNo)
    REFERENCES branch(branchNo) ON DELETE SET NULL;

/*  viewing CONSTRAINTS */
DESC USER_CONSTRAINTS;

/*COLUMN column_name FORMAT model*/
COLUMN conststraint_name FORMAT A40

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name='STAFF';

CREATE TABLE PrivateOwner (
    ownerNo CHAR(4)
    CONSTRAINT owner_PK PRIMARY KEY,
    fName VARCHAR2(20)
    CONSTRAINT ownerFN_not_null NOT NULL,
    lName VARCHAR2(20)
    CONSTRAINT ownerLN_notnull NOT NULL,
    address VARCHAR2(50),
    telNo CHAR(13)
);
CREATE TABLE PropertyForRent (
    propertyNo CHAR(4)
    CONSTRAINT pfr_PK PRIMARY KEY,
    street VARCHAR2(30),
    city VARCHAR(20),
    postcode CHAR(7),
    typeU VARCHAR2(20),
    rooms char(2),
    rent NUMERIC(7, 2),
    ownerNo CHAR(4),
    staffNo CHAR(4),
    branchNo CHAR(4)
);
ALTER TABLE propertyForRent
ADD CONSTRAINT property_owner_FK FOREIGN KEY(ownerNo)
REFERENCES PrivateOwner(ownerNo) ON DELETE SET NULL;

ALTER TABLE propertyForRent
ADD CONSTRAINT property_staff_FK FOREIGN KEY(staffNo)
REFERENCES staff(staffNo) ON DELETE SET NULL;

ALTER TABLE propertyForRent
ADD CONSTRAINT property_branch_FK FOREIGN KEY(branchNo)
REFERENCES branch(branchNo) ON DELETE SET NULL;

SELECT constraint_name, constraint_type,status
FROM user_constraints
WHERE table_name='PROPERTYFORRENT';

DESC PropertyForRent;

CREATE TABLE client (
    clientNo CHAR(4)
    CONSTRAINT client_PK PRIMARY KEY,
    fName VARCHAR2(20)
    CONSTRAINT client_fName_notnull NOT NULL,
    lName VARCHAR2(20)
    CONSTRAINT client_lName_notnull NOT NULL,
    address VARCHAR2(50),
    telNo CHAR(13)
);

INSERT INTO client
VALUES ('&clientNo', '&fName', '&lName', '&address', '&telNo');

INSERT INTO branch 
VALUES('B005', '22 Deer Rd', 'London', 'SW1 4EH');
INSERT INTO branch
VALUES('B003', '163 main St', 'Glasgow', 'GI1 9QX');
INSERT INTO branch
VALUES('B002', '56 Clover Dr', 'London', 'NW10 6EU');

DELETE FROM branch
WHERE postcode='NW1 6EU';

ALTER TABLE branch
MODIFY postcode CHAR(12); 

INSERT INTO staff
VALUES ('SL21', 'John', 'White', 'Manager', 'M', '01-Oct-45', 30000, 'B005');

COLUMN staffNo FORMAT a10;
COLUMN fName FORMAT a10;
COLUMN lName FORMAT a10;

INSERT INTO staff
VALUES ('&staffNo', '&fName', '&lName', '&position', '&sex', '&DOB', &salary, '&branchNo');

INSERT INTO branch
VALUES ('B007', '1170 Broadway', 'Glasgow', 'GI1 11QY');

INSERT INTO staff
VALUES ('SA9', 'Mary', 'Howe', 'Assistant', 'F', '19-Feb-70', 9000, 'B007');

ALTER TABLE propertyForRent
DROP COLUMN ownerNo;
ALTER TABLE propertyForRent
DROP COLUMN staffNo;
ALTER TABLE propertyForRent
DROP COLUMN branchNo;

ALTER TABLE propertyForRent
MODIFY rent NUMERIC(5);

INSERT INTO propertyForRent
VALUES ('&propertyNo', '&street', '&city', '&postcode', '&typeU', '&rooms', &rent);

UPDATE TABLE staff
SET postcode = 'G32 4QX'
WHERE propertyNo = 'PG36';

CREATE TABLE hotel (
    hotelID CHAR(4)
    CONSTRAINT hotel_PK PRIMARY KEY,
    hotelName VARCHAR2(20),
    street VARCHAR2(30),
    hotelCity VARCHAR(20)
);
CREATE TABLE guest (
    guestID CHAR(4)
    CONSTRAINT guest_PK PRIMARY KEY,
    fName VARCHAR(20),
    lName VARCHAR(20),
    street VARCHAR(30),
    city VARCHAR(20)
);
CREATE TABLE room (
    roomID CHAR(4)
    CONSTRAINT room_PK PRIMARY KEY,
    roomType VARCHAR(20),
    price NUMERIC(4)
);

ALTER TABLE room
ADD hotel CHAR(4);

ALTER TABLE room
ADD CONSTRAINT hotel_RL FOREIGN KEY(hotel)
REFERENCES hotel(hotelID) ON DELETE SET NULL;

INSERT INTO room
VALUES ('1001', 'Family', 300, 'H002');
INSERT INTO room
VALUES ('1002', 'Double', 250, 'H004');
INSERT INTO room
VALUES ('1003', 'Single', 300, 'H005');

CREATE TABLE booking (
    bookingID CHAR(4)
    CONSTRAINT booking_PK PRIMARY KEY,
    guestID CHAR(4),
    roomNo CHAR(4),
    checkInDate DATE,
    checkOutDate DATE,
    price NUMERIC (4)
);
ALTER TABLE booking
ADD CONSTRAINT room_RL FOREIGN KEY(roomNo)
REFERENCES room(roomID) ON DELETE SET NULL;

ALTER TABLE booking    
ADD CONSTRAINT guest_RL FOREIGN KEY(guestID)
REFERENCES guest(guestID) ON DELETE SET NULL;

ALTER TABLE booking
ADD hotelID CHAR(4);

ALTER TABLE booking    
ADD CONSTRAINT hotel_book_RL FOREIGN KEY(hotelID)
REFERENCES hotel(hotelID) ON DELETE SET NULL;

INSERT INTO hotel
VALUES ('H001', 'Double Tree', '165 Main St', 'London');
INSERT INTO hotel
VALUES ('H002', 'Hinton Hotel', '76 Thomas Rd', 'London');
INSERT INTO hotel
VALUEs ('H003', 'Plaza Hotel', '78 Horris Av', 'Glasgow');
INSERT INTO hotel
VALUES ('H004', 'Broadway Hotel', '17 Main St', 'Glasgow');
INSERT INTO hotel
VALUES ('H005', 'Grosvenor Hotel', '90 High St', 'London');

ALTER TABLE guest
ADD remarks VARCHAR(50);

ALTER TABLE guest
DROP COLUMN remarks;

CREATE TABLE remarks (
    remarkID CHAR(4)
    CONSTRAINT remark_PK PRIMARY KEY,
    byClient CHAR(4)
    CONSTRAINT client_NN NOT NULL,
    forProperty CHAR(4)
    CONSTRAINT property_NN NOT NULL,
    remarks VARCHAR(50)
);

ALTER TABLE remarks
ADD CONSTRAINT client_RL FOREIGN KEY(byClient)
REFERENCES client(clientNo) ON DELETE SET NULL;

ALTER TABLE remarks
ADD CONSTRAINT property_RL FOREIGN KEY(forProperty)
REFERENCES PropertyForRent(propertyNo) ON DELETE SET NULL;
/*                REVIEW                   */
/* 6.1 */
/* DML statement is data manipulation language. It is used to change the data.
Examples are:
            INSERT: to add data into the table
            UPDATE: to make change into the data
            SELECT: to choose from data table
            DELETE: to delete data from table
*/

/* 6.2 */
/* WHERE is very important. If we use DELETE or UPDATE without it, the whole
will be deleted or changed.
*/

/* 6.3 */
/* SELECT
        FROM:       tells which table to use
        WHERE:      (is a search condition)
        GROUP BY:   put the data collected together
        ORDER BY:   kind of sorting and display in the desired sequence
*/

/* 6.4 */
/*  - Aggregate function cannot be used in where clause
    - It can only be used with HAVING and SELECT clause statement
    - Is select statemnt is used with aggregate function GROUP BY cannot be used
*/

/* 6.5 */
/*  GROUP BY brings the data together into the required format from query
    Query which uses GROUP BY is called grouped query
    WHERE clause checks for the condition to put the data into the output table
    WHERE is used where a condition is checked
    Aggregate function is only used in HAVING
    HAVING filters the groups which are going into result table
*/

/* 6.6 */
/*  In subquery the output from one SELECT statemnt is used as an input for
    outer SELECT statement. Whereas join is like getting certain columns from 
    two or more different tables and putting them together with each other in
    an output table.

*/

/*               EXERCISES                 */

/* 6.7 */
SELECT *
FROM branch;

/* 6.8 */
SELECT *
FROM branch
WHERE city = 'London';

/* 6.9 */
SELECT fName || ' ' || lName AS Guest_Name, address
FROM client
WHERE address LIKE '%London%'
ORDER BY Guest_Name;

/* 6.10 */
SELECT *
FROM propertyForRent
WHERE rent < 400 AND typeU IN ('double', 'family')
ORDER BY rent;

/* 6.11 */
SELECT *
FROM booking
WHERE dateTo IS null;

/* 6.12 */
SELECT COUNT(*) AS No_of_Hotels
FROM branch;

/* 6.13 */
SELECT AVG (rent) AS Average_Price
FROM propertyForRent;

/* 6.14 */
SELECT SUM (rent) AS Rev_Per_Night_From_Double
FROM propertyForRent
WHERE typeU = 'double';

/* 6.15 */
SELECT COUNT (DISTINCT clientNo) AS No_Of_Guests
FROM booking
WHERE (dateFrom = '%August%');

/* 6.16 */
SELECT price, roomType
FROM room
WHERE hotel = (SELECT hotelID
                FROM hotel
                WHERE hotelName = 'Grosvenor Hotel');

/* 6.17 */
SELECT fName || ' ' || lName AS Guests_Staying
FROM guest
WHERE guestID = (SELECT guestID
                 FROM booking
                 WHERE hotelID = (SELECT hotelID
                                  FROM hotel
                                  WHERE hotelName = 'Grosvenor Hotel'));

/* 6.18 */
SELECT r.roomID, r.roomType, r.price, r.hotel, g.fName || g.lName AS Guest_Name
FROM room r, guest g
WHERE r.hotel = (SELECT hotelID
                    FROM hotel
                    WHERE hotelName = 'Grosvenor Hotel')
                    AND g.guestID = (SELECT guestID
                                        FROM booking
                                        WHERE checkInDate <= SYSDATE AND checkOutDate >= SYSDATE);

/* 6.19 */
SELECT SUM (price) AS Today_Income
FROM room 
WHERE hotel = (SELECT hotelID
                FROM booking
                WHERE checkInDate = SYSDATE);

/* 6.20 */
SELECT roomID
FROM room
WHERE hotel = (SELECT hotelID
                FROM hotel
                WHERE hotelName = 'Grosvenor Hotel')
                AND roomNo NOT IN (SELECT roomNo
                                    FROM booking b, hotel h
                                    WHERE (checkInDate <= SYSDATE AND checkOutDate >= SYSDATE)
                                    AND b.hotelID = (SELECT hotelID
                                                        FROM hotel
                                                        WHERE hotelName = 'Grosvenor Hotel'));

/* 6.21 */
SELECT SUM (price) AS Lost_Income
FROM room
WHERE roomID NOT IN (SELECT roomNo
                        FROM booking
                        WHERE hotelID = (SELECT hotelID
                                            FROM hotel
                                            WHERE hotelName = 'Grosvenor Hotel'));

/* 6.22 */
SELECT hotel, COUNT (roomID) AS Number_of_Rooms
FROM room
GROUP BY hotel;

/* 6.23 */
SELECT h.hotelID, COUNT (r.roomID) AS Rooms_in_London
from hotel h, room r
WHERE r.hotel = h.hotelID AND hotelCity = 'London'
GROUP BY h.hotelID;

/* 6.24 */
SELECT AVG (cnt) AS Avg_Booking
FROM (SELECT hotelID, COUNT(hotelID) AS cnt
        FROM booking b
        WHERE (b.checkInDate >= '01-AUG%' AND b.checkOutDate <= '31-AUG%')
GROUP BY hotelID);
/* 6.25 */
SELECT roomType AS Mostly_Booked, MAX (cnt) AS No_of_Times_Booked
FROM (SELECT roomType, COUNT (roomType) AS cnt
        FROM booking b, hotel h, room r
        WHERE r.roomID = b.roomNo AND b.hotelID = h.hotelID AND h.hotelCity LIKE '%London%'
        GROUP BY roomType)
        GROUP BY roomType;

/* 6.26 */
SELECT hotel, SUM (price) AS Lost_income
from room r
WHERE roomID NOT IN (SELECT roomNo
                        FROM booking b, hotel hotel
                        WHERE checkInDate <= SYSDATE AND checkOutDate >= SYSDATE)
GROUP BY hotel;

/* 6.27 */

INSERT INTO client
VALUES ('&clientNo', '&fName', '&lName', '&address', '&telNo');
INSERT INTO branch
VALUES ('B005', '22 Deer Rd', 'London', 'SW1 4EH');
INSERT INTO propertyForRent
VALUES ('&propertyNo', '&street', '&city', '&postcode', '&typeU', '&rooms',  &rent);
INSERT INTO room
VALUES ('1001', 'Family', 300, 'H002');

/* 6.28 */
UPDATE room
SET price = price * 1.05;


employee    (empNo, fName, lName, address, DOB, sex, position, deptNo)
department  (deptNo, deptName, mgrEmpNo)
project     (projNo, projName, deptNo)
worksON     (empNo, projNo, dateWorked, hoursWorked)

/* 6.32 */
SELECT *
FROM employee
ORDER BY surname;

/* 6.33 */
SELECT *
FROM employee
WHERE dob BETWEEN 1980 AND 1990;

/* 6.34 */
SELECT *
FROM emplyee
WHERE rank = 'Manager' AND sex = 'F'
ORDER BY surname, firstName;

/* 6.35 */
DELETE FROM projects
WHERE deptName = 'planning';

/* 6.36 */
SELECT lName, dateDiff(year, DOB, SYSDATE) AS Age
FROM employee
WHERE dateDiff(year, DOB, SYSDATE) > 60;
/* 6.37 */

SELECT COUNT(*)
FROM employee e, department d
WHERE e.fName = 'James' and e.lName = 'Adams'
AND e.empNo = d.mgrEmpNo and d.deptNo = e.empNo;

/* 6.38 */
SELECT e.lName, e.fName, hoursWorked, e.deptNo
FROM worksOn w, employees e, department d
WHERE e.deptNo = d.deptNo
AND e.empNo = w.empNo
ORDER BY d,deptNo, e.lName;

/* 6.39 */
SELECT p.projNo, p.projName, COUNT (w.empNo) AS No_of_Employees
FROM project p, worksOn w
WHERE p.projNo = w.projNo
GROUP BY p.projName, p.projNo
HAVING COUNT(w.empNo) > 2;

/* 6.40 */
SELECT deptNo, COUNT(empNo) AS No_of_Employees
FROM employee
GROUP BY deptNo
HAVING COUNT(empNo) > 10;

/* testing */
/* Visual Studio*/