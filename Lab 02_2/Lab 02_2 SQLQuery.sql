/*
CIS530– Lab Assignment 2_2
Name: Reza Shisheie
ID: 2708062
Object: Creating a Relational Database Schema from ER Diagram and Populating the Database
*/


USE master;
-- define a data base called "COMPANY"
IF DB_ID('COMPANY1') IS NULL
	CREATE DATABASE COMPANY1;
GO

use COMPANY1;
go





IF OBJECT_ID('dbo.EMPLOYEE') IS NULL

	create table EMPLOYEE (
	Fname VARCHAR(15) NOT NULL,
	Minit CHAR,
	Lname VARCHAR(15) NOT NULL,
	Ssn CHAR(9) NOT NULL,
	Bdate DATE,
	Address VARCHAR(30),
	Sex CHAR,
	Salary DECIMAL(10,2),
	Super_ssn CHAR(9),
	Dno INT NOT NULL,
	
	PRIMARY KEY (Ssn),
	);

-- Create a Table DEPARTMENT in COMPANY database

IF OBJECT_ID('dbo.DEPARTMENT') IS NULL
	CREATE TABLE dbo.DEPARTMENT(
	Dname VARCHAR(15) NOT NULL,
	Dnumber INT NOT NULL,
	Mgr_ssn CHAR(9) NOT NULL,
	Mgr_start_date DATE

	PRIMARY KEY (Dnumber),
	UNIQUE (Dname),
	); 

	ALTER TABLE EMPLOYEE
		ADD CONSTRAINT FKCONSTR1_1
			FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn);

	ALTER TABLE EMPLOYEE
		ADD CONSTRAINT FKCONSTR1_2
			FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber);

	ALTER TABLE DEPARTMENT
		ADD CONSTRAINT FKCONSTR2_1
			FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);



IF OBJECT_ID('dbo.DEPT_LOCATION') IS NULL
	CREATE TABLE dbo.DEPT_LOCATION(
	Dnumber INT NOT NULL,
	Dlocation VARCHAR(30),

	PRIMARY KEY (Dnumber, Dlocation),
	--FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber),
	);
	ALTER TABLE DEPT_LOCATION
		ADD CONSTRAINT FKCONSTR3_1
			FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber);

	


IF OBJECT_ID('dbo.PROJECT') IS NULL
	CREATE TABLE dbo.PROJECT(
	Pname VARCHAR(15) NOT NULL,
	Pnumber INT NOT NULL,
	Plocation VARCHAR(30),
	Dnum INT NOT NULL,

	PRIMARY KEY (Pnumber),
	--FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber), 
	);	
 	ALTER TABLE PROJECT
		ADD CONSTRAINT FKCONSTR4_1
			FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber);




 IF OBJECT_ID('dbo.WORKS_ON') IS NULL
	CREATE TABLE dbo.WORKS_ON(
	Essn CHAR(9) NOT NULL,
	Pno INT NOT NULL,
	Hours VARCHAR(5),

	PRIMARY KEY (Essn, Pno),
	--FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
	--FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber), 
 	);
 	ALTER TABLE WORKS_ON
		ADD CONSTRAINT FKCONSTR5_1
			FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn);
 	ALTER TABLE WORKS_ON
		ADD CONSTRAINT FKCONSTR5_2
			FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber);


 IF OBJECT_ID('dbo.DEPENDENT') IS NULL
	CREATE TABLE dbo.DEPENDENT(
	Essn CHAR(9) NOT NULL,
	Dependent_name VARCHAR(15) NOT NULL,
	Sex VARCHAR(5) NOT NULL,
	Bdate DATE,
	Relationship VARCHAR(15) NOT NULL,

	PRIMARY KEY (Essn,Dependent_name),
	--FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn), 
	);
	ALTER TABLE DEPENDENT
		ADD CONSTRAINT FKCONSTR6_1
			FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn);


--  disabling  FK with NOCHECK Option as below
ALTER TABLE COMPANY1.dbo.EMPLOYEE NOCHECK CONSTRAINT FKCONSTR1_1;
ALTER TABLE COMPANY1.dbo.EMPLOYEE NOCHECK CONSTRAINT FKCONSTR1_2;
ALTER TABLE COMPANY1.dbo.DEPARTMENT NOCHECK CONSTRAINT FKCONSTR2_1;
ALTER TABLE COMPANY1.dbo.DEPT_LOCATION NOCHECK CONSTRAINT FKCONSTR3_1;
ALTER TABLE COMPANY1.dbo.PROJECT NOCHECK CONSTRAINT FKCONSTR4_1;
ALTER TABLE COMPANY1.dbo.WORKS_ON NOCHECK CONSTRAINT FKCONSTR5_1;
ALTER TABLE COMPANY1.dbo.WORKS_ON NOCHECK CONSTRAINT FKCONSTR5_2;
ALTER TABLE COMPANY1.dbo.DEPENDENT NOCHECK CONSTRAINT FKCONSTR6_1;



--Let’s insert data into EMPLOYEE
insert into EMPLOYEE values ( 'John', 'B' ,'Smith','123456789','9-Jan-55', '731 Fondren, Houston, TX', 'M', '30000', '987654321', '5');
insert into EMPLOYEE values ( 'Franklin', 'T' ,'Wong','333445555','08-Dec-45', '638 Voss, Houston, TX', 'M', '40000', '888665555', '5');
insert into EMPLOYEE values ( 'Joyce', 'A' ,'English','453453453','31-Jul-62', '5631 Rice, Houston, TX ', 'F', '25000', '333445555', '5');
insert into EMPLOYEE values ( 'Ramesh', 'K' ,'Narayan','666884444','15-Sep-52', '975 Fire Oak, Humble, TX', 'M', 38000, '333445555', 5);
insert into EMPLOYEE values ( 'James', 'E' ,'Borg','888665555','10-Nov-27', '450 Stone, Houston, TX ', 'M', 55000, '', '1');
insert into EMPLOYEE values ( 'Jennifer', 'S' ,'Wallace','987654321','20-Jun-31', '291 Berry, Bellaire, TX', 'F', 43000, '888665555', 4);
insert into EMPLOYEE values ( 'Ahmad', 'V' ,'Jabbar','987987987','29-Mar-59', '980 Dallas, Houston, TX', 'M', 25000, '987654321', 4);
insert into EMPLOYEE values ( 'Alicia', 'J' ,'Zelaya','999887777','19-Jul-58', '3321 Castle, SPring, TX', 'F', 25000, '987654321', 4);

--This Select Query will Show tables
select * from EMPLOYEE;


--Let’s insert data into DEPARTMENT
insert into DEPARTMENT values ( 'Headquarters', '1' ,'888665555','19-Jun-71');
insert into DEPARTMENT values ( 'Administration', '4' ,'987654321','01-Jan-85');
insert into DEPARTMENT values ( 'Research', '5' ,'333445555','22-May-78');
insert into DEPARTMENT values ( 'Automation', '7' ,'123456789','06-Oct-05');

--This Select Query will Show tables
select * from DEPARTMENT;

--Let’s insert data into DEPENDENT
insert into DEPENDENT values ( '123456789', 'Alice' ,'F','31-Dec-78','Daughter');
insert into DEPENDENT values ( '123456789', 'Elizabeth' ,'F','05-May-57','Spouse');
insert into DEPENDENT values ( '123456789', 'Michael' ,'M','01-Jan-78','Son');
insert into DEPENDENT values ( '333445555', 'Alice' ,'F','05-Apr-76','Daughter');
insert into DEPENDENT values ( '333445555', 'Joy' ,'F','03-May-48','Spouce');
insert into DEPENDENT values ( '333445555', 'Theodore' ,'M','25-Oct-73','Son');
insert into DEPENDENT values ( '987654321', 'Abner' ,'M','29-Feb-32','Spouce');



--This Select Query will Show tables
select * from DEPENDENT;


--Let’s insert data into DEPT_LOCATION
insert into DEPT_LOCATION values ( '1', 'Houston');
insert into DEPT_LOCATION values ( '4', 'Stafford');
insert into DEPT_LOCATION values ( '5', 'Bellaire');
insert into DEPT_LOCATION values ( '5', 'Sugarland');
insert into DEPT_LOCATION values ( '5', 'Houston');


--This Select Query will Show tables
select * from DEPT_LOCATION;


--Let’s insert data into PROJECT
insert into PROJECT values ( 'ProductX', '1', 'Bellaire', '5');
insert into PROJECT values ( 'ProductY', '2', 'Sugarland', '5');
insert into PROJECT values ( 'ProductZ', '3', 'Houston', '5');
insert into PROJECT values ( 'Computerization', '10', 'Stafford', '4');
insert into PROJECT values ( 'Reorganization', '20', 'Houston', '1');
insert into PROJECT values ( 'Newbenefits', '30', 'Stafford', '4');


--This Select Query will Show tables
select * from PROJECT;


--Let’s insert data into WORKS_ON
insert into WORKS_ON values ( '123456789', '1', '32.5');
insert into WORKS_ON values ( '123456789', '2', '7.5');

insert into WORKS_ON values ( '333445555', '2', '10');
insert into WORKS_ON values ( '333445555', '3', '10');
insert into WORKS_ON values ( '333445555', '10', '10');
insert into WORKS_ON values ( '333445555', '20', '10');
insert into WORKS_ON values ( '453453453', '1', '20');
insert into WORKS_ON values ( '453453453', '2', '20');
insert into WORKS_ON values ( '666884444', '3', '40');
insert into WORKS_ON values ( '888665555', '20', null);
insert into WORKS_ON values ( '987654321', '20', '15');
insert into WORKS_ON values ( '987654321', '30', '20');
insert into WORKS_ON values ( '987987987', '10', '35');
insert into WORKS_ON values ( '987987987', '30', '5');
insert into WORKS_ON values ( '999887777', '10', '10');
insert into WORKS_ON values ( '999887777', '30', '30');


--This Select Query will Show tables
select * from WORKS_ON;





-- droping all dependencies and constrainsts

ALTER TABLE EMPLOYEE DROP CONSTRAINT FKCONSTR1_1;
ALTER TABLE EMPLOYEE DROP CONSTRAINT FKCONSTR1_2;
ALTER TABLE DEPARTMENT DROP CONSTRAINT FKCONSTR2_1;
ALTER TABLE DEPT_LOCATION DROP CONSTRAINT FKCONSTR3_1;
ALTER TABLE PROJECT DROP CONSTRAINT FKCONSTR4_1;
ALTER TABLE WORKS_ON DROP CONSTRAINT FKCONSTR5_1;
ALTER TABLE WORKS_ON DROP CONSTRAINT FKCONSTR5_2;
ALTER TABLE DEPENDENT DROP CONSTRAINT FKCONSTR6_1;

-- droping and removing all tables
drop table DEPARTMENT;
drop table EMPLOYEE;
drop table DEPT_LOCATION
drop table PROJECT
drop table WORKS_ON
drop table DEPENDENT

--drop DATABASE compnay1