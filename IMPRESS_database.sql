USE [Master]
GO
CREATE DATABASE [IMPRESS]

GO

USE [IMPRESS]

GO



CREATE TABLE dbo.Units(
	UnitID INT IDENTITY(2000,1) NOT NULL PRIMARY KEY,
	UnitName VARCHAR (50) UNIQUE NOT NULL,
	Affiliation VARCHAR (50) NOT NULL );


CREATE TABLE dbo.Hostile(
	HostileID INT IDENTITY(3000,1) NOT NULL PRIMARY KEY,
	HostileName VARCHAR (50) UNIQUE NOT NULL,
	HostileThreatLevel INT NOT NULL
	CHECK (HostileThreatLevel = 1 OR HostileThreatLevel <= 5 ),
	HostileDescription VARCHAR (50) NOT NULL );


CREATE TABLE dbo.SafeHouses(
	SafeHouseID INT IDENTITY(8000,1) NOT NULL PRIMARY KEY,
	SafeHouseName VARCHAR (50) UNIQUE NOT NULL,
	SafeHouseType VARCHAR (50) NOT NULL,
	SafeHouseDescription VARCHAR (50));

CREATE TABLE dbo.LivingQuarters(
	QuarterID INT IDENTITY(7000,1) NOT NULL PRIMARY KEY,
	SafeHouseID INT FOREIGN KEY REFERENCES SafeHouses(SafeHouseID));

CREATE TABLE dbo.Members(
	MemberID INT IDENTITY(1000,1) NOT NULL PRIMARY KEY,
	MembersFirstName VARCHAR(50) NOT NULL,
	MembersLastName VARCHAR(50) NOT NULL,
	Gender CHAR(1) NOT NULL
	CHECK (Gender = 'M' OR Gender = 'F'),
	DateJoined DATE NOT NULL,
	DateOfBirth DATE NOT NULL,
	DateOfDeath DATE,
	QuarterID INT FOREIGN KEY REFERENCES LivingQuarters(QuarterID) , 
	CONSTRAINT ch_Date_Joined CHECK( 
	(DateJoined !> DateOfDeath AND DateJoined !< DateOfBirth)), CONSTRAINT ck_Death_Date CHECK(
	(DateOfDeath !< DateOfBirth)) );


CREATE TABLE dbo.Inventory(
	ItemID INT IDENTITY(10000,1) NOT NULL PRIMARY KEY,
	ItemDescription VARCHAR (50) NOT NULL,
	ItemType VARCHAR (50) NOT NULL,
	Quantity INT NOT NULL
	CHECK (Quantity !< 0),
	EquivalentValue INT NOT NULL,
	SafeHouseID INT FOREIGN KEY REFERENCES SafeHouses(SafeHouseID) );


CREATE TABLE dbo.Jobs(
	JobsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	JobsName VARCHAR(50) UNIQUE NOT NULL,
	JobsDescription VARCHAR (100) NOT NULL );




CREATE TABLE dbo.MembersJob(
	MemberID INT FOREIGN KEY REFERENCES Members(MemberID) ,
	JobsID INT FOREIGN KEY REFERENCES Jobs(JobsID)  );



CREATE TABLE dbo.UnitsMembers(
	MemberID INT FOREIGN KEY REFERENCES Members(MemberID) ,
	UnitID INT FOREIGN KEY REFERENCES Units(UnitID) );


CREATE TABLE dbo.Raid(
	RaidID INT IDENTITY(5000,1) NOT NULL PRIMARY KEY,
	RaidStartDate DATE NOT NULL,
	RaidEndDate DATE NOT NULL,
	UnitID INT FOREIGN KEY REFERENCES Units(UnitID), CONSTRAINT ch_Raid_Date CHECK (
	(RaidStartDate !> RaidEndDate)) );


CREATE TABLE dbo.PowerSources(
	PowerSourcesID INT IDENTITY(4000,1) NOT NULL PRIMARY KEY,
	SourceName VARCHAR (50) NOT NULL,
	SourceType VARCHAR (50) NOT NULL,
	ProductionCapacity VARCHAR (10),
	SafeHouseID INT FOREIGN KEY REFERENCES SafeHouses(SafeHouseID) );


CREATE TABLE dbo.Locations(
	LocationID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	HostileID INT FOREIGN KEY REFERENCES Hostile(HostileID),	
	LocationType VARCHAR (50) NOT NULL,
	LocationName VARCHAR (50) NOT NULL,
	LocationStreet VARCHAR (50) NOT NULL,
	LocationCityState VARCHAR (50) NOT NULL);


CREATE TABLE dbo.RaidLocations(
	LocationID INT FOREIGN KEY REFERENCES Locations(LocationID),
	RaidID INT FOREIGN KEY REFERENCES Raid(RaidID));


CREATE TABLE dbo.SafeHouseLocations(
	LocationID INT FOREIGN KEY REFERENCES Locations(LocationID),
	SafehouseID INT FOREIGN KEY REFERENCES SafeHouses(SafeHouseID)); 

CREATE TABLE dbo.UnitLocations(
	LocationID INT FOREIGN KEY REFERENCES Locations(LocationID),
	UnitID INT FOREIGN KEY REFERENCES Units(UnitID));

