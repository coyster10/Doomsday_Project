USE [IMPRESS]
GO

--Create an audit table to record changes in Members table
CREATE TABLE Members_Audits
(
  MemberID INT,
  MembersFirstName varchar(50),
  MembersLastName varchar(50),
  Gender char(1),
  DateJoined date,
  DateOfBirth date,
  DateOfDeath date,
  QuarterID INT,
  Audit_Action varchar(100),
  Audit_Timestamp datetime
)

SELECT* FROM Members_Audits
GO

--Create an audit table to record changes in Inventory table
CREATE TABLE Inventory_Depleted 
(
  ItemID INT,
  ItemDescription varchar(50),
  ItemType varchar(50),
  Quantity INT,
  EquivalentValue INT,
  SafeHouseID INT,
  Audit_Action varchar(100),
  Audit_Timestamp datetime
)

SELECT* FROM Inventory_Depleted
GO

--Create a table to keep track of retired units (due to lack of personnel)
CREATE TABLE Units_Retired
(
	UnitID INT,
	UnitName varchar(50),
	Affiliation varchar(50),
	Audit_Action varchar(100),
	Audit_Timestamp datetime
)
GO

-- 1. Instead of DELETE trigger  - Items are not to be deleted if quantity is not 0, deleted itmes are recorded on Inventory_Depleted table
CREATE TRIGGER trgInsteadOfDeleteInventory ON Inventory INSTEAD OF DELETE
AS 
	DECLARE @invItemID INT;
	DECLARE @invItemDescription varchar(50);
	DECLARE @invItemType varchar(50);
	DECLARE @invQuantity INT;
	DECLARE @invEquivalentValue INT;
	DECLARE @invSafeHouseID INT;


	SELECT @invItemID = d.ItemID FROM deleted AS d;
	SELECT @invItemDescription = d.ItemDescription FROM deleted AS d;
	SELECT @invItemType = d.ItemType FROM deleted AS d;
	SELECT @invQuantity = d.Quantity FROM deleted AS d;
	SELECT @invEquivalentValue = d.EquivalentValue FROM deleted AS d;
	SELECT @invSafeHouseID = d.SafeHouseID FROM deleted AS d;

	BEGIN 
		IF (@invQuantity = 0)
		BEGIN
			DELETE FROM Inventory WHERE ItemID = @invItemID;
			COMMIT;
			INSERT INTO Inventory_Depleted(ItemID, ItemDescription, ItemType, Quantity, EquivalentValue, SafeHouseID,  Audit_Action, Audit_Timestamp)
			VALUES (@invItemID, @invItemDescription, @invItemType, @invQuantity, @invEquivalentValue, @invSafeHouseID, 'Deleted -- Instead Of Delete Trigger.', GETDATE());

			PRINT 'AFTER INSTEAD DELETE trigger fired.'
		END
		ELSE
		BEGIN
			RAISERROR('Cannot delete Item where Quantity is not 0', 14, 1);
			ROLLBACK;
		END
	END
GO

DELETE
FROM Inventory
WHERE ItemID = 10002
GO

-- 2. Instead of DELETE trigger - Dead members cannot be removed
CREATE TRIGGER trgInsteadOfDeleteMembers ON Members INSTEAD OF DELETE
AS 
	DECLARE @memID INT;
	DECLARE @memMembersFirstName varchar(50);
	DECLARE @memMembersLastName varchar(50);
	DECLARE @memGender char(1);
	DECLARE @memDateJoined date;
	DECLARE @memDateOfBirth date;
	DECLARE @memDateOfDeath date;
	DECLARE @memQuarterID INT;
	DECLARE @Audit_Action varchar(100);

	SELECT @memID = d.MemberID FROM deleted AS d;
	SELECT @memMembersFirstName = d.MembersFirstName FROM deleted AS d;
	SELECT @memMembersLastName = d.MembersLastName FROM deleted AS d;
	SELECT @memGender = d.Gender FROM deleted AS d;
	SELECT @memDateJoined = d.DateJoined FROM deleted AS d;
	SELECT @memDateOfBirth = d.DateOfBirth FROM deleted AS d;
	SELECT @memDateOfDeath = d.DateOfDeath FROM deleted AS d;
	SELECT @memQuarterID = d.QuarterID FROM deleted AS d;

	BEGIN 
		IF (@memDateOfDeath != NULL)
		BEGIN
			DELETE FROM Members WHERE MemberID = @memID;
			COMMIT;
			INSERT INTO Members_Audits(MemberID, MembersFirstName, MembersLastName, Gender, DateJoined, DateOfBirth, DateOfDeath, QuarterID, Audit_Action, Audit_Timestamp)
			VALUES (@memID, @memMembersFirstName, @memMembersLastName, @memGender, @memDateJoined, @memDateOfBirth, @memDateOfDeath, @memQuarterID, 'Deleted -- Instead Of Delete Trigger.', GETDATE());

			PRINT 'AFTER INSTEAD DELETE trigger fired.'
		END
		ELSE
		BEGIN
			RAISERROR('Cannot delete Member where DateOfDeath is not NULL', 14, 1);
			ROLLBACK;
		END
	END
GO

-- 2. Delete from dbo.UnitsMembers first
DELETE
FROM UnitsMembers
WHERE MemberID = 1053
GO

-- 2. Delete from dbo.Members
DELETE
FROM Members
WHERE MemberID = 1053
GO
SELECT* FROM Members_Audits
GO

-- 3. Instead of INSERT trigger - Members younger than 16 years old will not be given a job
CREATE TRIGGER trgInsteadInsertMembersJob ON MembersJob INSTEAD OF INSERT
AS
	DECLARE @jobMembersID INT;
	DECLARE @jobJobsID INT;
	DECLARE @Audit_Action varchar(100);

	SELECT @jobMembersID = i.MembersID FROM inserted AS i;
	SELECT @jobJobsID = i.JobsID FROM inserted AS i;

	BEGIN
		IF ((SELECT DateOfBirth FROM Members WHERE @jobMembersID = MemberID)  < '2005-12-17')
		BEGIN
			INSERT INTO MembersJob(MembersID) SELECT Members.MemberID FROM Members WHERE @jobMembersID = MemberID;
			COMMIT;
		END
		ELSE
		BEGIN
			RAISERROR('Cannot INSERT member WHERE DateOfBirth is before 2005-12-17', 14, 1);
			ROLLBACK;
		END
	END
GO

-- 3. Inserts member on MembersJob table
INSERT INTO MembersJob (MembersID)
SELECT MemberID FROM Members
WHERE MemberID = 1047
GO

--4. Instead of INSERT trigger - No member youger than 18 should be assigned to a Unit
CREATE TRIGGER trgInsteadInsertUnitsMembers ON UnitsMembers INSTEAD OF INSERT
AS
	DECLARE @unitMemberID INT;
	DECLARE @unitUnitID INT;

	SELECT @unitMemberID = i.MemberID FROM inserted AS i;
	SELECT @unitUnitID = i.UnitID FROM inserted AS i;

	BEGIN
		IF ((SELECT DateOfBirth FROM Members WHERE @unitMemberID = MemberID)  < '2007-12-17')
		BEGIN
			INSERT INTO UnitsMembers(MemberID) SELECT Members.MemberID FROM Members WHERE @unitMemberID = MemberID;
			COMMIT;
		END
		ELSE
		BEGIN
			RAISERROR('Cannot INSERT member WHERE DateOfBirth is before 2007-12-17', 14, 1);
			ROLLBACK;
		END
	END
GO

--5. Creates a record of deleted units on Units_Retired table
CREATE TRIGGER trgAfterDeleteUnits ON Units AFTER DELETE
AS
	DECLARE @unitsUnitID INT;
	DECLARE @unitsUnitName varchar(50);
	DECLARE @unitsAffiliation varchar(50);
	DECLARE @AuditAction varchar(100);

	SELECT @unitsUnitID = d.UnitID FROM deleted AS d;
	SELECT @unitsUnitName = d.UnitName FROM deleted AS d;
	SELECT @unitsAffiliation = d.Affiliation FROM deleted AS d;
	SET @AuditAction ='Deleted -- After Delete Trigger.';

	INSERT INTO Units_Retired(UnitID, UnitName, Affiliation, Audit_Action, Audit_Timestamp)
	VALUES(@unitsUnitID, @unitsUnitName, @unitsAffiliation, @AuditAction, GETDATE());

	SELECT* FROM deleted
	PRINT 'AFTER DELETE trigger fired.'
GO
