USE [DoomsDay]
GO

CREATE PROCEDURE hostile_lookup


@hostileName AS VARCHAR(20) = NULL,
@hostileThreatLevel AS int = NULL

AS

SELECT Hostile.HostileID, Hostile.HostileName, Hostile.HostileThreatLevel, Hostile.HostileDescription, Locations.LocationName, Locations.LocationType, Units.UnitName, Units.Affiliation, Raid.RaidStartDate, Raid.RaidEndDate
FROM  Hostile INNER JOIN
         Locations ON Hostile.HostileID = Locations.HostileID INNER JOIN
         RaidLocations ON Locations.LocationID = RaidLocations.LocationID INNER JOIN
         Raid ON RaidLocations.RaidID = Raid.RaidID INNER JOIN
         Units ON Raid.UnitID = Units.UnitID
WHERE Hostile.HostileName LIKE '%' + @hostileName + '%' OR Hostile.HostileThreatLevel = @hostileThreatLevel;

GO

USE [DoomsDay]

GO

CREATE PROCEDURE raid_lookup

@raidID AS int = NULL,
@raidStart AS VARCHAR(15) = NULL,
@raidEnd AS VARCHAR(15) = NULL,
@unitID AS int = NULL,
@unitAffiliation AS VARCHAR = NULL

AS

IF @raidStart = NULL
	SET @raidStart = '2021-01-01';

IF @raidEnd = NULL
	SET @raidEnd = CONVERT(varchar, getdate(), 23);

DECLARE @s AS DATE
SET @s = CAST(@raidStart AS DATE);
DECLARE @e AS DATE
SET @e = CAST(@raidEnd AS DATE);

SELECT Raid.RaidID, Raid.RaidStartDate, Raid.RaidEndDate, Hostile.HostileName, Locations.LocationName, Locations.LocationType, Units.UnitName, Units.Affiliation
FROM  Raid INNER JOIN
         RaidLocations ON Raid.RaidID = RaidLocations.RaidID INNER JOIN
         Locations ON RaidLocations.LocationID = Locations.LocationID INNER JOIN
         Units ON Raid.UnitID = Units.UnitID INNER JOIN
         UnitsMembers ON Units.UnitID = UnitsMembers.UnitID INNER JOIN
         Hostile ON Locations.HostileID = Hostile.HostileID
WHERE Raid.RaidID = @raidID OR ((Raid.RaidStartDate > @s) AND (Raid.RaidEndDate < @e)) OR Units.UnitID = @unitID OR Units.Affiliation = @unitAffiliation;

GO

USE [DoomsDay]
GO

CREATE PROCEDURE unit_members_lookup

@unitName AS VARCHAR(50) = NULL,
@unitID AS int = NULL

AS

SELECT Units.UnitID, Units.UnitName, Units.Affiliation, Members.MembersFirstName, Members.MembersLastName, Members.Gender
FROM  Units INNER JOIN
         UnitsMembers ON Units.UnitID = UnitsMembers.UnitID INNER JOIN
         Members ON UnitsMembers.MemberID = Members.MemberID
WHERE Units.UnitName LIKE '%' + @unitName + '%' OR Units.UnitID = @unitID;

GO

USE [DoomsDay]
GO

CREATE PROCEDURE safehouse_location_lookup

@shName AS VARCHAR(20) = NULL,
@shType AS VARCHAR(2) = NULL

AS

SELECT SafeHouses.SafeHouseName, SafeHouses.SafehouseType, SafeHouses.SafeHouseDescription, Locations.LocationType, Locations.LocationName, Locations.LocationStreet, Locations.LocationCityState
FROM  SafeHouses INNER JOIN
         SafeHouseLocations ON SafeHouses.SafehouseID = SafeHouseLocations.SafehouseID INNER JOIN
         Locations ON SafeHouseLocations.LocationID = Locations.LocationID
WHERE SafeHouses.SafeHouseName LIKE '%' + @shName + '%' OR SafeHouses.SafehouseType LIKE '%' + @shType + '%';

GO

USE [DoomsDay]
GO

CREATE PROCEDURE member_job_lookup

@memberFirstName AS VARCHAR(20),
@memberLastName AS VARCHAR(20)

AS

SELECT Members.MembersFirstName, Members.MembersLastName, Jobs.JobsName, Jobs.JobsDescription, SafeHouses.SafeHouseName, SafeHouses.SafehouseType
FROM  Members INNER JOIN
         MembersJob ON Members.MemberID = MembersJob.MemberID INNER JOIN
         Jobs ON MembersJob.JobsID = Jobs.JobsID INNER JOIN
         LivingQuarters ON Members.QuarterID = LivingQuarters.QuarterID INNER JOIN
         SafeHouses ON LivingQuarters.SafeHouseID = SafeHouses.SafehouseID
WHERE Members.MembersFirstName LIKE '%' + @memberFirstName + '%' AND Members.MembersLastName LIKE '%' + @memberLastName + '%';

GO