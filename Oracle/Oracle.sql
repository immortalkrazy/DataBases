/*
            TABLES
            
    No      Book                Other           Total
    1                           dept           
    2                           emp
    3       staff           
    4       branch
    5       privateOwner          
    6       propertyForRent
    7       client
    8                           room
    9                           booking
    10                          guest
    11                          remarks
    12      lease
    13      viewing
    14      registration
*/

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
VALUE(7369,'Smith','clerk',7902,171280,800,NULL,20
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

CREATE TABLE staff
(
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
	branchNo CHAR(4)
);
/*creation of branch table*/
CREATE TABLE branch
(
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
    ADD CONSTRAINT staff_gender_check CHECK(sex IN ('M', 'F', 'O'));
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

CREATE TABLE PrivateOwner
(
	ownerNo CHAR(4)
		CONSTRAINT owner_PK PRIMARY KEY,
	fName VARCHAR2(20)
		CONSTRAINT ownerFN_not_null NOT NULL,
	lName VARCHAR2(20)
		CONSTRAINT ownerLN_notnull NOT NULL,
	address VARCHAR2(50),
	telNo CHAR(13)
);
CREATE TABLE PropertyForRent
(
	propertyNo CHAR(4)
		CONSTRAINT pfr_PK PRIMARY KEY,
	street VARCHAR2(30),
	city VARCHAR(20),
	postcode CHAR(7),
	typeU VARCHAR2(20),
	rooms CHAR(2),
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

SELECT constraint_name, constraint_type, status
FROM user_constraints
WHERE table_name='PROPERTYFORRENT';

DESC PropertyForRent;

CREATE TABLE client
(
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
VALUES
	('&clientNo', '&fName', '&lName', '&address', '&telNo');

INSERT INTO branch
VALUES('B005', '22 Deer Rd', 'London', 'SW1 4EH');
INSERT INTO branch
VALUES('B003', '163 main St', 'Glasgow', 'GI1 9QX');
INSERT INTO branch
VALUES('B002', '56 Clover Dr', 'London', 'NW10 6EU');

DELETE FROM branch
WHERE postcode='NW1 6EU';

ALTER TABLE branch
MODIFY postcode CHAR
(12);

INSERT INTO staff
VALUES
	('SL21', 'John', 'White', 'Manager', 'M', '01-Oct-45', 30000, 'B005');

COLUMN staffNo FORMAT a10;
COLUMN fName FORMAT a10;
COLUMN lName FORMAT a10;

INSERT INTO staff
VALUES
	('&staffNo', '&fName', '&lName', '&position', '&sex', '&DOB',  &salary, '&branchNo');

INSERT INTO branch
VALUES
	('B007', '1170 Broadway', 'Glasgow', 'GI1 11QY');

INSERT INTO staff
VALUES
	('SA9', 'Mary', 'Howe', 'Assistant', 'F', '19-Feb-70', 9000, 'B007');

ALTER TABLE propertyForRent
DROP COLUMN ownerNo;
ALTER TABLE propertyForRent
DROP COLUMN staffNo;
ALTER TABLE propertyForRent
DROP COLUMN branchNo;

ALTER TABLE propertyForRent
MODIFY rent NUMERIC
(5);

INSERT INTO propertyForRent
VALUES
	('&propertyNo', '&street', '&city', '&postcode', '&typeU', '&rooms',  &rent);

UPDATE staff
SET postcode
= 'G32 4QX'
WHERE propertyNo = 'PG36';

CREATE TABLE hotel
(
	hotelID CHAR(4)
		CONSTRAINT hotel_PK PRIMARY KEY,
	hotelName VARCHAR2(20),
	street VARCHAR2(30),
	hotelCity VARCHAR(20)
);
CREATE TABLE guest
(
	guestID CHAR(4)
		CONSTRAINT guest_PK PRIMARY KEY,
	fName VARCHAR(20),
	lName VARCHAR(20),
	street VARCHAR(30),
	city VARCHAR(20)
);
CREATE TABLE room
(
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
VALUES
	('1001', 'Family', 300, 'H002');
INSERT INTO room
VALUES
	('1002', 'Double', 250, 'H004');
INSERT INTO room
VALUES
	('1003', 'Single', 300, 'H005');

CREATE TABLE booking
(
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
VALUES
	('H001', 'Double Tree', '165 Main St', 'London');
INSERT INTO hotel
VALUES
	('H002', 'Hinton Hotel', '76 Thomas Rd', 'London');
INSERT INTO hotel
VALUES
	('H003', 'Plaza Hotel', '78 Horris Av', 'Glasgow');
INSERT INTO hotel
VALUES
	('H004', 'Broadway Hotel', '17 Main St', 'Glasgow');
INSERT INTO hotel
VALUES
	('H005', 'Grosvenor Hotel', '90 High St', 'London');

ALTER TABLE guest
ADD remarks VARCHAR(50);

ALTER TABLE guest
DROP COLUMN remarks;

CREATE TABLE remarks
(
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
WHERE dateTo IS NULL;

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
FROM hotel h, room r
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
FROM room r
WHERE roomID NOT IN (SELECT roomNo
FROM booking b, hotel hotel
WHERE checkInDate <= SYSDATE AND checkOutDate >= SYSDATE)
GROUP BY hotel;

/* 6.27 */

INSERT INTO client
VALUES
	('&clientNo', '&fName', '&lName', '&address', '&telNo');
INSERT INTO branch
VALUES
	('B005', '22 Deer Rd', 'London', 'SW1 4EH');
INSERT INTO propertyForRent
VALUES
	('&propertyNo', '&street', '&city', '&postcode', '&typeU', '&rooms',   &rent);
INSERT INTO room
VALUES
	('1001', 'Family', 300, 'H002');

/* 6.28 */
UPDATE room
SET price = price * 1.05;


employee
(empNo, fName, lName, address, DOB, sex, position, deptNo)
department
(deptNo, deptName, mgrEmpNo)
project
(projNo, projName, deptNo)
worksON
(empNo, projNo, dateWorked, hoursWorked)

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
WHERE e.fName = 'James' AND e.lName = 'Adams'
	AND e.empNo = d.mgrEmpNo AND d.deptNo = e.empNo;

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

/*************************************************/

/*How many databases are there in the system*/
SELECT name, created, dbid
FROM V$database;

ALTER TABLE propertyForRent
ADD ownerNo CHAR(4);

ALTER TABLE propertyForRent
ADD CONSTRAINT property_owner_FK FOREIGN KEY(ownerNo)
REFERENCES PrivateOwner(ownerNo) ON DELETE SET NULL;

INSERT INTO PrivateOwner
VALUES
	('&ownerNo', '&fName', '&lName', '&address', '&telNo');

UPDATE propertyForRent
SET ownerNo = 'CO46'
WHERE propertyNo = 'PG16';

UPDATE propertyForRent
SET ownerNo = 'CO93'
WHERE propertyNo = 'PG36';

UPDATE PropertyForRent
SET ownerNo = 'CO87'
WHERE propertyNo = 'PG21';

UPDATE propertyForRent
SET
    street = '6 Argyll St',
    city = 'London',
    postcode = 'NW2',
    typeU = 'Flat',
    rooms = 4,
    rent = 400,
    ownerNo = 'CO87'
WHERE propertyNo = 'PL94';

UPDATE PropertyForRent
SET
    street = '6 lawrence St',
    city = 'Glasgow',
    postcode = 'G11 9QX',
    typeU = 'Flat',
    rooms = 3,
    rent = 350,
    ownerNo = 'CO40'
WHERE propertyNo = 'PG4';

UPDATE PropertyForRent
SET
    street = '16 Holhead Rd',
    city = 'Aberdeen',
    postcode = 'AB7 3SU',
    typeU = 'House',
    rooms = 6,
    rent = 650,
    ownerNo = 'CO46'
WHERE propertyNo = 'PA14';

ALTER TABLE propertyForRent
ADD staffNo CHAR(4);

ALTER TABLE propertyForRent
ADD branchNo CHAR(4);

ALTER TABLE propertyForRent
ADD CONSTRAINT pfr_stf_FK FOREIGN KEY(staffNo)
REFERENCES staff(StaffNo) ON DELETE SET NULL;

ALTER TABLE propertyForRent
ADD CONSTRAINT pfr_brc_FK FOREIGN KEY(branchNo)
REFERENCES branch(branchNo) ON DELETE SET NULL;

UPDATE propertyForRent
SET staffNo = 'SA9', branchNo = 'B007'
WHERE propertyNo = 'PA14';

UPDATE propertyForRent
SET staffNo = 'SL41', branchNo = 'B005'
WHERE propertyNo = 'PL94';

UPDATE propertyForRent
SET staffNo = NULL, branchNo = 'B003'
WHERE propertyNo = 'PG4';

UPDATE propertyForRent
SET staffNo = 'SG37', branchNo = 'B003'
WHERE propertyNo = 'PG36';

UPDATE propertyForRent
SET staffNo = 'SG37', branchNo = 'B003'
WHERE propertyNo = 'PG21';

UPDATE propertyForRent
SET staffNo = 'SG14', branchNo = 'B003'
WHERE propertyNo = 'PG16';

ALTER TABLE client
ADD prefType VARCHAR2(10);

ALTER TABLE client
ADD maxRent NUMERIC(5);

UPDATE client
SET
    address = '64 Fern Dr, Glasgow G42 0BL',
    telNo = '0141-848-1825',
    prefType = 'Flat',
    maxrent = 350
WHERE clientNo = 'CR56';

UPDATE client
SET
    address = '5 Tarbot Rd, Aberdeen AB9 3ST',
    telNo = '01224-196720',
    prefType = 'Flat',
    maxRent = 600
WHERE clientNo = 'CR62';

UPDATE client
SET
    address = '56 High St, London SW1 4EH',
    telNo = '0207-774-5632',
    prefType = 'Flat',
    maxRent = 425
WHERE clientNo = 'CR76';

INSERT INTO client
VALUES
	('CR74', 'Mike', 'Ritchie', '18 Tain St, Paig 1YQ', '01475-392178', 'House', 750);

CREATE TABLE lease
(
	leaseNo NUMERIC(5)
		CONSTRAINT lease_pk PRIMARY KEY,
	propertyNo CHAR(4)
		CONSTRAINT p_no_NN NOT NULL,
	clientNo CHAR(4)
		CONSTRAINT c_no_NN NOT NULL,
	rent NUMERIC(5),
	paymentMethod VARCHAR2(10),
	deposit NUMERIC(5),
	paid CHAR(1),
	rentStart DATE,
	rentFinish DATE,
	duration NUMERIC(3)
);

ALTER TABLE lease
ADD CONSTRAINT paid_yn_check CHECK (paid IN('Y', 'N'));

ALTER TABLE lease
ADD CONSTRAINT lease_pNo_FK FOREIGN KEY (propertyNo)
REFERENCES PropertyForRent(propertyNo) ON DELETE SET NULL;

ALTER TABLE lease
ADD CONSTRAINT lease_client_FK FOREIGN KEY (clientNo)
REFERENCES client(clientNo) ON DELETE SET NULL;

INSERT INTO lease
VALUES
	(10024, 'PA14', 'CR62', 650, 'Visa', 1300, 'Y', '1-Jun-13', '31-may-14', 12);

INSERT INTO lease
VALUES
	(10075, 'PL94', 'CR76', 400, 'Cash', 800, 'N', '1-Aug-13', '31-Jan-14', 12);

INSERT INTO lease
VALUES
	(10012, 'PG21', 'CR74', 600, 'Cheque', 1200, 'Y', '1-Jul-13', '30-Jun-14', 12);

UPDATE lease
SET
    duration = 6,
    rentFinish = '31-May-14'
WHERE leaseNo = 10024;

ALTER TABLE PropertyForRent
MODIFY typeU VARCHAR2
(8);

ALTER TABLE PropertyForRent
MODIFY city VARCHAR2
(10);

ALTER TABLE PropertyForRent
MODIFY street VARCHAR2
(20);

ALTER TABLE client
MODIFY fName VARCHAR2
(8);

ALTER TABLE client
MODIFY lName VARCHAR2
(8);

ALTER TABLE client
MODIFY address VARCHAR2
(30);

ALTER TABLE client
MODIFY prefType VARCHAR2
(8);

ALTER TABLE privateOwner
MODIFY fName VARCHAR2
(8);

ALTER TABLE privateOwner
MODIFY lName VARCHAR2
(8);

ALTER TABLE privateOwner
MODIFY address VARCHAR2
(30);

ALTER TABLE privateOwner
ADD eMail VARCHAR2(20);

ALTER TABLE privateOwner
ADD password CHAR(8);

UPDATE privateOwner
SET
    eMail = 'jkoegh@lhh.com',
    password = '********'
WHERE ownerNo = 'CO46';

UPDATE privateOwner
SET
    eMail = 'cfarrel@gmail.com',
    password = '********'
WHERE ownerNo = 'CO87';

UPDATE privateOwner
SET
    eMail = 'tinam@hotmail.com',
    password = '********'
WHERE ownerNo = 'CO40';

UPDATE privateOwner
SET
    eMail = 'tony.shaw@ark.com',
    password = '********'
WHERE ownerNo = 'CO93';

UPDATE branch
SET
    street = '16 Argyl St',
    city = 'Aberdeen',
    postcode = 'AB2 3SU'
WHERE branchNo = 'B007';

INSERT INTO branch
VALUES('B004', '32 Manse Rd', 'Bristol', 'BS99 1NZ');

ALTER TABLE staff
MODIFY fName VARCHAR2
(8);

ALTER TABLE staff
MODIFY lName VARCHAR2
(8);

ALTER TABLE staff
MODIFY position VARCHAR2
(10);

CREATE TABLE viewing
(
	clientNo CHAR(4),
	propertyNo CHAR(4),
	viewDate DATE,
	clientComment VARCHAR2(30)
);

ALTER TABLE viewing
ADD CONSTRAINT view_client_FK FOREIGN KEY(clientNo)
REFERENCES client(clientNo) ON DELETE SET NULL;

ALTER TABLE viewing
ADD CONSTRAINT view_prop4rent_FK FOREIGN KEY(propertyNo)
REFERENCES propertyForRent(propertyNo) ON DELETE SET NULL;

INSERT INTO viewing
VALUES('&clientNo', '&propertyNo', '&viewDate', '&clientComment');

CREATE TABLE registration
(
	clientNo CHAR(4),
	branchNo CHAR(4),
	staffNo CHAR(4),
	dateJoined DATE
);

ALTER TABLE registration
ADD CONSTRAINT reg_client_FK FOREIGN KEY(clientNo)
REFERENCES client(clientNo) ON DELETE SET NULL;

ALTER TABLE registration
ADD CONSTRAINT reg_branch_FK FOREIGN KEY(branchNo)
REFERENCES branch(branchNo) ON DELETE SET NULL;

ALTER TABLE registration
ADD CONSTRAINT reg_staff_FK FOREIGN KEY(staffNo)
REFERENCES staff(staffNo) ON DELETE SET NULL;

INSERT INTO registration
VALUES('&clientNo', '&branchNo', '&staffNo', '&dateJoined');

/*---------chapter 6 EXAMPLES----------------*/
SELECT *
FROM staff;

SELECT staffNo, fName || ' ' || lName AS Full_Name, salary
FROM staff;

SELECT DISTINCT propertyNo
FROM viewing;

/*6.4*/
SELECT staffNo, lName, salary/12 AS Monthly_Salaary
FROM staff;

SELECT staffNo, fName, lName, position, salary
FROM staff
WHERE salary > 10000;

/*6.6*/
SELECT *
FROM branch
WHERE city = 'London' OR city = 'Glasgow';

/*6.7*/
SELECT *
FROM staff
WHERE salary BETWEEN 20000 AND 30000;

/*6.8*/
SELECT *
FROM staff
WHERE position = 'Manager' OR position = 'Supervisor';

SELECT *
FROM staff
WHERE position IN ('Manager', 'Supervisor');

SELECT staffNo, fName || ' ' || lName AS Name, POSITION
FROM staff
WHERE position IN ('Manager', 'Supervisor');

/*6.9*/
SELECT *
FROM privateOwner
WHERE address LIKE '%Glasgow%';

SELECT ownerNo, fName, lName, telNo
FROM privateOwner
WHERE address LIKE '%Glasgow%';

/*6.10*/
SELECT clientNo, viewDate
FROM viewing
WHERE propertyNo = 'PG4' AND clientComment IS NULL;

/*6.11*/
SELECT staffNo, fName, lName, salary
FROM staff
ORDER BY salary DESC;

SELECT staffNo, fName, lName, salary
FROM staff
ORDER BY salary ASC;

/*6.12*/
SELECT propertyNo, typeU, rooms, rent
FROM propertyForRent
ORDER BY typeU;

/*6.13*/
SELECT COUNT(*) AS My_Count
FROM propertyForRent
WHERE rent > 350;

/*6.14*/
SELECT COUNT (DISTINCT propertyNo) AS My_Count
FROM viewing
WHERE viewDate BETWEEN '1-May-13' AND '31-May-13';

/*6.15*/
SELECT COUNT(staffNo) AS My_Count, SUM(salary) AS My_Sum
FROM staff
WHERE position = 'Manager';

/*6.16*/
SELECT MIN(salary) AS myMin, MAX(salary) AS myMax, AVG(salary) AS myAvg
FROM staff;

/*6.17*/
SELECT branchNO, COUNT(staffNo) AS stf_Count, SUM(salary) AS My_Sum
FROM staff
GROUP BY branchNo
ORDER BY branchNo;

SELECT branchNO, COUNT(staffNo) AS stf_Count, SUM(salary) AS My_Sum
FROM staff
GROUP BY branchNo
ORDER BY My_Sum;

/*6.18*/
SELECT branchNo, COUNT(staffNo) AS stf_Count, SUM(salary) AS My_Sum
FROM staff
GROUP BY branchNo
HAVING COUNT(staffNo) > 1
ORDER BY branchNo;

/*6.19*/
SELECT staffNo, fName, lName, salary
FROM staff
WHERE branchNo = (SELECT branchNo
				  FROM branch
				  WHERE street = '163 Main St');

/*6.20*/
SELECT staffNo, salary - (SELECT AVG(salary)
						  FROM staff) AS salDiff
FROM staff
WHERE salary > (SELECT AVG(salary)
			 FROM staff)
ORDER BY salDiff;

/*6.21*/
SELECT *
FROM propertyForRent
WHERE staffNo IN (SELECT staffNo
				  FROM staff
				  WHERE branchNo = (SELECT branchNo
				  					FROM branch
									WHERE street = '163 Main St'));

/*6.22*/
SELECT *
FROM staff
WHERE salary > SOME (SELECT salary
					 FROM staff
					 WHERE branchNo = 'B003');

/*6.23*/
SELECT staffNo, fName, lName, position, salary
FROM staff
WHERE salary > ALL (SELECT salary
					FROM staff
					WHERE branchNO = 'B003');

/*6.24*/
