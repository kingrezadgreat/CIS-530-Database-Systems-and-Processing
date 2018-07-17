/*
CIS530– Lab Assignment 1 
Name: Reza Shisheie
ID: 2708062 
Object: Creating a Relational Database Schema Using SQL and SQL Server
*/


USE master;

-- define a data base called "COMPANY"
IF DB_ID('COMPANY') IS NULL
	CREATE DATABASE COMPANY;
GO

use COMPANY;
go


-- Create a Table EMPLOYEE in COMPANY database

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
	Dno INT
	);

-- Create a Table DEPARTMENT in COMPANY database

IF OBJECT_ID('dbo.DEPARTMENT') IS NULL
	CREATE TABLE dbo.DEPARTMENT(
	Dname VARCHAR(15) NOT NULL,
	Dnumber INT NOT NULL,
	Mgr_ssn CHAR(9) NOT NULL,
	Mgr_start_date DATE
); 


--Let’s insert data into EMPLOYEE
insert into EMPLOYEE values ( 'John', 'B' ,'Smith','123456789','9-Jan-55', '731 Fondren, Houston, TX', 'M', '30000', '987654321', '5');
insert into EMPLOYEE values ( 'Franklin', 'T' ,'Wong','333445555','08-Dec-45', '638 Voss, Houston, TX', 'M', '40000', '888665555', '5');
insert into EMPLOYEE values ( 'Joyce', 'A' ,'English','453453453','31-Jul-62', '5631 Rice, Houston, TX ', 'F', '25000', '333445555', '5');
insert into EMPLOYEE values ( 'Ramesh', 'K' ,'Narayan','666884444','15-Sep-52', '975 Fire Oak, Humble, TX', 'M', '38000', '333445555', '5');
insert into EMPLOYEE values ( 'James', 'E' ,'Borg','888665555','10-Nov-27', '450 Stone, Houston, TX ', 'M', '55000', '', '1');
insert into EMPLOYEE values ( 'Jennifer', 'S' ,'Wallace','987654321','20-Jun-31', '291 Berry, Bellaire, TX', 'F', '43000', '888665555', '4');
insert into EMPLOYEE values ( 'Ahmad', 'V' ,'Jabbar','987987987','29-Mar-59', '980 Dallas, Houston, TX', 'M', '25000', '987654321', '4');
insert into EMPLOYEE values ( 'Alicia', 'J' ,'Zelaya','999887777','19-Jul-58', '3321 Castle, SPring, TX', 'F', '25000', '987654321', '4');


--This Select Query will Show tables
select * from EMPLOYEE;


--Let’s insert data into DEPARTMENT
insert into DEPARTMENT values ( 'Headquarters', '1' ,'888665555','19-Jun-71');
insert into DEPARTMENT values ( 'Administration', '4' ,'987654321','01-Jan-85');
insert into DEPARTMENT values ( 'Research', '5' ,'333445555','22-May-78');
insert into DEPARTMENT values ( 'Automation', '7' ,'123456789','06-Oct-05');

--This Select Query will Show tables
select * from DEPARTMENT;



-- This will delete the whole table making it ready for next execution
drop table EMPLOYEE;
drop table DEPARTMENT;
