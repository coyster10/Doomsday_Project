CREATE VIEW Members_List_Alive_View AS
SELECT
	MembersFirstName,
	MembersLastName
FROM
	Members
WHERE
	DateOFDeath is null;

GO
CREATE VIEW Members_Assigned_Jobs_View AS 
SELECT
	Members.MembersFirstName,
	Members.MembersLastName,
	Jobs.JobsName
FROM
	Members INNER JOIN
    MembersJob ON Members.MemberID = MembersJob.MemberID INNER JOIN
    Jobs ON MembersJob.JobsID = Jobs.JobsID
WHERE
	DateOFDeath is null;

GO
CREATE VIEW Active_Engagements_View AS
SELECT
	Units.UnitName,
	Units.Affiliation,
	Locations.LocationName,
	Hostile.HostileName,
	Hostile.HostileThreatLevel
FROM
	UnitLocations INNER JOIN
	Units ON UnitLocations.UnitID = Units.UnitID INNER JOIN
	Locations ON UnitLocations.LocationID = Locations.LocationID INNER JOIN
	Hostile ON Locations.HostileID = Hostile.HostileID;

GO
CREATE VIEW Inventory_Item_Location_View AS
SELECT
	Inventory.ItemDescription,
	Inventory.Quantity,
	Locations.LocationName,
	SafeHouses.SafeHouseName
FROM
	Inventory INNER JOIN
	SafeHouses ON Inventory.SafeHouseID = SafeHouses.SafehouseID INNER JOIN
	SafeHouseLocations ON SafeHouses.SafehouseID = SafeHouseLocations.SafehouseID INNER JOIN
	Locations ON SafeHouseLocations.LocationID = Locations.LocationID;

GO
CREATE VIEW Unit_Raid_Engagements_View AS 
SELECT
	Units.UnitName,
	Raid.RaidStartDate,
	Raid.RaidEndDate,
	Locations.LocationName,
	Hostile.HostileName
FROM
	Locations INNER JOIN
	Hostile ON Locations.HostileID = Hostile.HostileID INNER JOIN
	RaidLocations ON Locations.LocationID = RaidLocations.LocationID INNER JOIN
	Raid INNER JOIN
	Units ON Raid.UnitID = Units.UnitID ON RaidLocations.RaidID = Raid.RaidID;
