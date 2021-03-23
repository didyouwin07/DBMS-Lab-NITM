BEGIN TRANSACTION;

/* Create few tables for bank database */
CREATE TABLE Branch(BId integer PRIMARY KEY, BName text);
CREATE TABLE Customer(CId integer Primary key, CName text, BranchId integer, Address text);
CREATE TABLE AccountDetails(AccNo text Primary key, Balance double, TDate date, AcType text,Cid integer);
CREATE TABLE TransactionDetails(AccNo text , Deposited text, UTRNo text PRIMARY KEY,Amount integer);

/* Create few records in these table */
INSERT INTO Branch VALUES(101,'Imphal');
INSERT INTO Branch VALUES(102,'Kohima');
INSERT INTO Branch VALUES(103,'Guwahati');
INSERT INTO Branch VALUES(104,'Shillong');

INSERT INTO Customer VALUES(201,'ABC',101,'Imphal Branch');
INSERT INTO Customer VALUES(202,'DEF',101,'Imphal Branch');
INSERT INTO Customer VALUES(203,'GHI',102,'Kohima Branch');
INSERT INTO Customer VALUES(204,'JKL',102,'Kohima Branch');
INSERT INTO Customer VALUES(205,'MNO',103,'Guwahati Branch');
INSERT INTO Customer VALUES(206,'PQR',103,'Guwahati Branch');
INSERT INTO Customer VALUES(207,'STU',104,'Shillong Branch');
INSERT INTO Customer VALUES(208,'VWX',104,'Shillong Branch');

INSERT INTO AccountDetails VALUES('IMP301',32000.5,2018-01-12,'Savings',201);
INSERT INTO AccountDetails VALUES('IMP302',42000.5,2017-02-14,'Current',201);
INSERT INTO AccountDetails VALUES('IMP303',35000.8,2019-08-05,'Savings',202);
INSERT INTO AccountDetails VALUES('KOH301',52000.5,2017-02-14,'Fixed Deposit',203);
INSERT INTO AccountDetails VALUES('KOH302',62000.0,2015-11-12,'Current',204);
INSERT INTO AccountDetails VALUES('GUW301',42000.5,2018-01-12,'Savings',205);
INSERT INTO AccountDetails VALUES('GUW302',20000.5,2019-02-14,'Recurring Deposit',206);
INSERT INTO AccountDetails VALUES('SHL301',3000.5,2020-01-11,'Savings',207);
INSERT INTO AccountDetails VALUES('SHL302',5000.5,2017-15-12,'Fixed Deposit',207);
INSERT INTO AccountDetails VALUES('SHL303',10000.5,2013-01-21,'Current',208);

INSERT INTO TransactionDetails VALUES('IMP301','Deposit','IMP301987',5000);
INSERT INTO TransactionDetails VALUES('IMP301','Withdraw','IMP301654',3000);
INSERT INTO TransactionDetails VALUES('IMP302','Deposit','IMP302987',9000);
INSERT INTO TransactionDetails VALUES('KOH301','Deposit','KOH301987',2000);
INSERT INTO TransactionDetails VALUES('KOH302','Deposit','KOH302987',4000);
INSERT INTO TransactionDetails VALUES('GUW301','Withdraw','GUW301987',5000);
INSERT INTO TransactionDetails VALUES('GUW302','Withdraw','GUH302987',6000);
INSERT INTO TransactionDetails VALUES('SHL301','Deposit','SHL301987',9000);
INSERT INTO TransactionDetails VALUES('SHL301','Withdraw','SHL301654',12000);
INSERT INTO TransactionDetails VALUES('SHL302','Deposit','SHL302987',3000);



/* Display the branch details with average balance greater than 10000 */
SELECT AVG(a.Balance)>10000 ,b.BId, b.BName FROM AccountDetails a, Customer c, Branch b
WHERE a.Cid=c.CId and b.BId=c.BranchId
Group by b.BId;

/*Display the branch details of the branch located in a city starting with letter S*/
SELECT BName, BId From Branch
WHERE BName LIKE 'S%';

/*Retrieve the number of depositors in each brach*/
SELECT COUNT(a.Cid),b.BName from Branch b, AccountDetails a, Customer c
where a.Cid=c.CId and c.BranchId=b.BId
group by b.BName;

/*Display the total account balance of customer "PQR"*/
SELECT a.Balance, c.CName, c.Address, c.CId from Customer c, AccountDetails a
where c.CName='PQR' and c.CId = a.Cid;

/*Display the account details of all customers whose account balance is between 30000 and 40000*/
SELECT c.CName, c.Address, a.Balance, b.BName from Customer c, AccountDetails a, Branch b
where c.CId=a.Cid and b.BId=c.BranchId and a.Balance>30000 and a.Balance<40000;

/*Retrieve customer details who did transaction on 14th Feb 2017 along with transaction details*/
SELECT c.CName, c.Address, b.BName, t.Deposited, a.TDate from Customer c, Branch b, TransactionDetails t, AccountDetails a 
WHERE a.TDate=2017-02-14 and b.BId=c.BranchId and c.CId=a.Cid and a.AccNo=t.AccNo;




