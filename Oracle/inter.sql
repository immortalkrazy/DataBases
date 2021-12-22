--1
SELECT * FROM Trade
WHERE ClintID = "ClientA";

--2
SELECT * FROM (
    SELECT * FROM Trade
    WHERE side=buy)
    AS A JOIN (
        SELECT * FROM Trade
        WHERE side=sell) 
        AS b ON
        a.price = b.price AND
        a.qty = b.qty
        WHERE a.transacttime BETWEEN
        b.transactime-2 AND b.transatime+2
--3

SELECT * FROM
(SELECT * FROM Trade
WHERE side=buy)
AS A JOIN
(SELECT * FROM Trade
WHERE side=sell)
AS b ON a.price = b.price AND
a.ClientID = b.ClientID
WHERE a.transatime between transactime-2 AND b.transactime+2;
