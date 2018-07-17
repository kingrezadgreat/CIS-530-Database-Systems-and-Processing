/*CIS530 - Lab Assignment 6 Extra
Name: Reza Shisheie
ID: 2708062
Object: Creating FriendBook social network
*/



-- creat database
CREATE DATABASE [FriendBook]
GO

--creating the USER table
use [FriendBook];
CREATE TABLE dbo.USERS (
	Fname varchar(15) not null,
	Minit char,
	Lname varchar(15) not null,
	UserID varchar(30) not null,	
	Email varchar(30),
	Phone char(12),		
	Address varchar(50),

	Constraint USERSPK primary key (UserId),
);

--creating the CONTACTS  table 
CREATE TABLE dbo.CONTACTS (
	UserID		varchar(30) not null,
	ContactId	varchar(30)	not null,
	
	Constraint CONTACTSPK primary key (UserID, ContactID),	
	Constraint USERIDFK foreign key (UserID) REFERENCES USERS(UserID) 
		ON DELETE CASCADE 
		ON UPDATE CASCADE,
	Constraint CONTACTFK foreign key (ContactID) REFERENCES USERS(UserID)
);
GO


-- ADDING

--PROCEDURE to add user to user list 
USE [FriendBook];
GO
CREATE PROCEDURE SP_Add_User(
	@Fname varchar(15),
	@Minit char,
	@Lname varchar(15),
	@UserID varchar(30),
	@Email varchar(30),
	@Phone char(12),
	@Address varchar(50))
AS
BEGIN
	INSERT INTO USERS (Fname, Minit, Lname, UserID, Email, Phone, Address)
	VALUES (@Fname, @Minit, @Lname, @UserID, @Email, @Phone, @Address)
END
GO

--PROCEDURE to add contacts to contact list
GO
CREATE PROCEDURE SP_Add_Contact
	@UserID	varchar(30),
	@ContactID varchar(30)
AS
BEGIN
	INSERT INTO CONTACTS (UserID, ContactID)
	VALUES (@UserID, @ContactID);
END
GO






-- **** RETREIVING 
--PROCEDURE to retrieve a user's information from UserID
GO
CREATE PROCEDURE SP_Retrieve_User(
	@UserID	varchar(30))
AS
BEGIN
	SELECT *
	FROM USERS U
	WHERE U.UserID = @UserID;
END
GO

--PROCEDURE to retrieve a UserID's friends 
GO
CREATE PROCEDURE SP_Retrieve_Contacts(
	@UserID	varchar(30))
AS
BEGIN
	SELECT U2.UserID AS ContactID, U2.Fname, U2.Lname
	FROM CONTACTS C, USERS U, USERS U2
	WHERE U.UserID = @UserID AND U.UserID = C.UserID AND C.ContactID = U2.UserID;
END
GO




-- **** UPDATING
--PROCEDURE to update User's info
GO
CREATE PROCEDURE SP_Update_User(
	@UserID varchar(30),
	@Fname varchar(15),
	@Minit char,
	@Lname varchar(15),
	@Email varchar(30),
	@Phone char(12),
	@Address varchar(50))
AS
BEGIN
	UPDATE USERS
	SET Fname = @Fname, Minit = @Minit, Lname = @Lname, Email = @Email, Phone = @Phone, Address = @Address
	WHERE UserID = @UserID;
END
GO



-- **** DELETING
-- PROCEDURE to delete contacts from contact list
GO
CREATE PROCEDURE SP_Delete_Contact
	@UserID	varchar(30),
	@ContactID varchar(30)
AS
BEGIN
	DELETE FROM CONTACTS
	WHERE UserID = @UserID AND ContactID = @ContactID;
END
GO

--PROCEDURE to delete user from the user list and consequently from contact list 
GO
CREATE PROCEDURE SP_Delete_User
	@UserID	varchar(30)
AS
BEGIN
	DELETE FROM CONTACTS
	WHERE UserID = @UserID OR ContactID = @UserID;
	DELETE FROM USERS 
	WHERE UserID = @UserID;
END
GO





-- **** CREATING AND ADDING 

--add Users using user SP
EXEC SP_Add_User @Fname = 'Reza', @Minit = null, @Lname = 'Shisheie', @UserID = 'rezashisheie',  @Email = 'rezashishei@gmail.com', @Phone = '1234567890', @Address = 'Cleveland';
EXEC SP_Add_User @Fname = 'Franklin', @Minit = 'T', @Lname = 'Wong', @UserID = 'fwong',  @Email = 'fwong@gmail.com', @Phone = '8886655555', @Address = '638 Voss, Houston, TX';
EXEC SP_Add_User @Fname = 'Joyce', @Minit = 'A', @Lname = 'English', @UserID = 'jenglish',  @Email = 'jenglish@gmail.com', @Phone = '4534534539', @Address = '5631 Rice, Houston, TX';
EXEC SP_Add_User @Fname = 'James', @Minit = 'E', @Lname = 'Borg', @UserID = 'jborge',  @Email = 'jborge@gmail.com', @Phone = '8808665555', @Address = '450 Stone, Las Vegas, NV';
EXEC SP_Add_User @Fname = 'Ramesh', @Minit = 'K', @Lname = 'Narayan', @UserID = 'rnarayan',  @Email = 'rnarayan@gmail.com', @Phone = '9516234870', @Address = '975 Fire Oak, Humble, TX';
EXEC SP_Add_User @Fname = 'Alicia', @Minit = 'J', @Lname = 'Zelaya', @UserID = 'azelaya',  @Email = 'azelaya@gmail.com', @Phone = '7418529635', @Address = '3321 Castle, SPring, TX';


-- adding to contacts using add SP
EXEC SP_Add_Contact @UserID = 'rezashisheie', @ContactID = 'fwong';
EXEC SP_Add_Contact @UserID = 'fwong', @ContactID = 'azelaya';
EXEC SP_Add_Contact @UserID = 'jborge', @ContactID = 'rezashisheie';
EXEC SP_Add_Contact @UserID = 'rezashisheie', @ContactID = 'azelaya';
EXEC SP_Add_Contact @UserID = 'rezashisheie', @ContactID = 'rnarayan';
EXEC SP_Add_Contact @UserID = 'azelaya', @ContactID = 'rezashisheie';

SELECT * FROM USERS;
SELECT * FROM CONTACTS;
GO





-- **** RETRIEVING
-- Retrieve friends of rezashisheie using Retrieve SP
USE [FriendBook];
EXEC SP_Retrieve_Contacts @UserID = 'rezashisheie';

-- Retrieve info of rezashisheie using Retrieve SP
EXEC SP_Retrieve_User @UserID = 'rezashisheie';
GO




-- **** UPDATING
--info of USER azelaya using Retrieve SP before update
USE [FriendBook];
EXEC SP_Retrieve_User @UserID = 'azelaya';

--Update the User information of User azelaya
EXEC SP_Update_User @UserID = 'azelaya', @Fname='Alicia', @Minit='J', @Lname='Zelaya', @Email = 'azelayaNEW@gmail.com', @Phone = '0000000000', @Address = 'homeless!';

--info of USER azelaya using Retrieve SP after update
USE [FriendBook];
EXEC SP_Retrieve_User @UserID = 'azelaya';
GO



-- **** DELETING
-- print before delete
SELECT * FROM USERS;
SELECT * FROM CONTACTS;
GO

--delete fwong from the user rezashisheie's Contacts List
EXEC SP_Delete_Contact @UserID='rezashisheie', @ContactID='fwong';

--delete azelaya from the user table and consequently from the contact list
EXEC SP_Delete_User @UserID = 'azelaya';
GO

--show modified  USER and CONTACTS list
SELECT * FROM USERS;
SELECT * FROM CONTACTS;
GO



-- DROP
USE master;
Drop DATABASE [FriendBook];

