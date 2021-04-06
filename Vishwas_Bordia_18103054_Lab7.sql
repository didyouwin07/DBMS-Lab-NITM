BEGIN TRANSACTION;

/* Create tables  */
CREATE TABLE Hostel(HId integer PRIMARY KEY, HName text, Htype text);
CREATE TABLE Warden(WId integer, Wname text, HId integer);
CREATE TABLE Student(SId integer, SName text, HId integer);
CREATE TABLE Menu(HId integer, Sunday text, Monday text, Tuesday text, Wed text, Thurs text, Fri text, Sat text);
/* Create few records in these table */
INSERT INTO Hostel VALUES(101,'BH-1','Boys');
INSERT INTO Hostel VALUES(102,'BH-2','Boys');
INSERT INTO Hostel VALUES(103,'GH-1','Girls');
INSERT INTO Warden VALUES(201,'W1',101);
INSERT INTO Warden VALUES(202,'W2',101);
INSERT INTO Warden VALUES(203,'W3',102);
INSERT INTO Warden VALUES(204,'W4',103);
INSERT INTO Warden VALUES(205,'W5',103);
INSERT INTO Student VALUES(301,'S1',101);
INSERT INTO Student VALUES(302,'S2',101);
INSERT INTO Student VALUES(303,'S3',101);
INSERT INTO Student VALUES(304,'S4',102);
INSERT INTO Student VALUES(305,'S5',102);
INSERT INTO Student VALUES(306,'S6',103);
INSERT INTO Student VALUES(307,'S7',103);
INSERT INTO Student VALUES(308,'S8',103);
INSERT INTO Student VALUES(309,'S9',103);
INSERT INTO Menu VALUES(101,'Sp1','Sp2','Sp3','Sp4','Sp5','Sp6','Sp7');
INSERT INTO Menu VALUES(102,'Sp8','Sp9','Sp10','Sp11','Sp12','Sp13','Sp14');
INSERT INTO Menu VALUES(103,'Sp15','Sp16','Sp17','Sp18','Sp19','Sp20','Sp21');
COMMIT;

/* Display the total number of girls and boys in the college */
Select H.Htype,count(*) from Student S, Hostel H
where S.HId=H.HId
group by H.Htype;

/*Display the menu in hostel BH-2 on Tuesday*/
Select M.Tuesday,H.HName from Menu M, Hostel H
where M.HId=H.HId and H.HName='BH-2';

/*Retrieve the number of wardens for each hostel*/
Select H.HName,count(*) from Hostel H,Warden W
where H.HId=W.HId
Group by H.HName;

/*Retrieve the total number of students residing in GH-1*/
Select H.HName, H.HId, count(*) from Hostel H, Student S
where H.HId=S.HId and H.HName='GH-1';

/*Change the breakfast of BH-2 to Noodles for Tuesday*/
Update Menu
Set Tuesday='Noodles'
where HId=(Select H.HId from Hostel H, Menu M where H.HName='BH-2' and H.HId=M.HId);

Select * from Menu M, Hostel H
where M.HId=H.HId and H.HName='BH-2';

/*Display the names of all hostels that are having more number of students than BH-2*/
Select H.HName,count(*) from Student S,Hostel H 
where H.HId=S.HId 
group by H.HName
having count(*)>(Select count(*) from Student S, Hostel H where S.HId=H.HId and H.HName='BH-2');
