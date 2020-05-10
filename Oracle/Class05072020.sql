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
SELECT c.customerName, COUNT(o.orderNum) AS NumberOfOrders
FROM customers c JOIN orders o
ON c.customerID = o.customerID
GROUP BY c.customerName;

-- a/2
SELECT customerName, COUNT(orderNum)
FROM customers c, orders o
WHERE c.customerID = o.customerID
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

-- h
DELETE FROM customers
WHERE customerID = 123;

INSERT INTO customers
VALUES(123, "Alpine Corp", "Brooklyn", "NY");

UPDATE orders
SET customerID = 123
WHERE orderNum = 'A211';

DELETE FROM customers orders
USING customers
WHERE customerID = 123;

DELETE c, o
FROM customers c, orders o
WHERE c.customerID = 123
AND c.customerID = o.custometrID; 

DELETE a.*, b.*  
FROM customers AS a, orderrs AS b  
WHERE a.customerID = 123
AND b.customerID = o.CustomerID;
