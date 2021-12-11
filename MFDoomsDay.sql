USE [Master]
GO
CREATE DATABASE [DoomsDay]

GO

USE DoomsDay

GO

CREATE TABLE dbo.Members(
	MemberID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MembersFirstName VARCHAR(50) NOT NULL,
	MembersLastName VARCHAR(50) NOT NULL,
	Gender CHAR(1) NOT NULL
	CHECK (Gender = 'M' OR Gender = 'F'),
	DateJoined DATE NOT NULL,
	DateOfBirth DATE NOT NULL,
	DateOfDeath DATETIME,
	QuarterID INT NOT NULL, CONSTRAINT ch_Date_Joined CHECK( 
	(DateJoined !> DateOfDeath AND DateJoined !< DateOfBirth)), CONSTRAINT ck_Death_Date CHECK(
	(DateOfDeath !< DateOfBirth)) );


CREATE TABLE dbo.Units(
	UnitID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	UnitName VARCHAR (50) NOT NULL,
	Affiliation VARCHAR (50) NOT NULL );


CREATE TABLE dbo.Hostile(
	HostileID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	HostileName VARCHAR (50) NOT NULL,
	HostileThreatLevel INT NOT NULL
	CHECK (HostileThreatLevel = 1 OR HostileThreatLevel <= 5 ),
	HostileDescription VARCHAR (50) NOT NULL );


CREATE TABLE dbo.Zones(
	ZoneID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ZoneName VARCHAR (50) NOT NULL,
	ZoneDescription VARCHAR (50) NOT NULL );

CREATE TABLE dbo.LivingQuarters(
	QuartersID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ZoneID INT FOREIGN KEY REFERENCES Zones(ZoneID));

CREATE TABLE dbo.Inventory(
	ItemID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ItemDescription VARCHAR (50) NOT NULL,
	ItemType VARCHAR (50) NOT NULL,
	Quantity INT NOT NULL
	CHECK (Quantity !< 0),
	EquivalentValue INT NOT NULL,
	ZoneID INT FOREIGN KEY REFERENCES Zones(ZoneID) );


CREATE TABLE dbo.Jobs(
	JobsID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	JobsName VARCHAR(50) NOT NULL,
	JobsDescription VARCHAR (100) NOT NULL );




CREATE TABLE dbo.MembersJob(
	MembersID INT FOREIGN KEY REFERENCES Members(MemberID) ,
	JobsID INT FOREIGN KEY REFERENCES Jobs(JobsID)  );



CREATE TABLE dbo.UnitsMembers(
	MemberID INT FOREIGN KEY REFERENCES Members(MemberID) ,
	UnitID INT FOREIGN KEY REFERENCES Units(UnitID) );


CREATE TABLE dbo.Raid(
	RaidID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	RaidStartDate DATE NOT NULL,
	RaidEndDate DATE NOT NULL,
	UnitID INT FOREIGN KEY REFERENCES Units(UnitID), CONSTRAINT ch_Raid_Date CHECK (
	(RaidStartDate !> RaidEndDate)) );


CREATE TABLE dbo.PowerSources(
	PowerSourcesID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	SourceName VARCHAR (50) NOT NULL,
	SourceType VARCHAR (50) NOT NULL,
	ProductionCapacity VARCHAR (10),
	ZoneID INT FOREIGN KEY REFERENCES Zones(ZoneID) );


CREATE TABLE dbo.Locations(
	LocationID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
	HostileID INT FOREIGN KEY REFERENCES Hostile(HostileID),
	ZoneID INT FOREIGN KEY REFERENCES Zones(ZoneID),
	RaidID INT FOREIGN KEY REFERENCES Raid(RaidID),
	LocationType VARCHAR (50) NOT NULL,
	LocationName VARCHAR (50) NOT NULL );


