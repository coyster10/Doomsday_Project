USE [DoomsDay]
GO
SET IDENTITY_INSERT [dbo].[Jobs] ON 

INSERT [dbo].[Jobs] ([JobsID], [JobsName], [JobsDescription]) VALUES (1, N'Solder', N'Apart of a military organization,')
INSERT [dbo].[Jobs] ([JobsID], [JobsName], [JobsDescription]) VALUES (2, N'electrician', N'zone electrician')
INSERT [dbo].[Jobs] ([JobsID], [JobsName], [JobsDescription]) VALUES (3, N'Construction', N'Zone Construction worker')
INSERT [dbo].[Jobs] ([JobsID], [JobsName], [JobsDescription]) VALUES (4, N'Police Officer', N'Zone police')
INSERT [dbo].[Jobs] ([JobsID], [JobsName], [JobsDescription]) VALUES (5, N'Farmer', N'Zone farmer')
INSERT [dbo].[Jobs] ([JobsID], [JobsName], [JobsDescription]) VALUES (6, N'Goverment Worker', N'outside goverment offcial')
INSERT [dbo].[Jobs] ([JobsID], [JobsName], [JobsDescription]) VALUES (7, N'Merchant', N'Traveling zone merchant')
INSERT [dbo].[Jobs] ([JobsID], [JobsName], [JobsDescription]) VALUES (8, N'Water Treatment', N'Treatment plant worker')
SET IDENTITY_INSERT [dbo].[Jobs] OFF
GO
SET IDENTITY_INSERT [dbo].[Units] ON 

INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (1, N'7th Impress Infantry Battalion ', N'I.M.P.R.E.S.S')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (2, N'34th Impress Tank Company', N'I.M.P.R.E.S.S')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (3, N'5th Zone Support Group', N'I.M.P.R.E.S.S')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (4, N'8th Zone Support Group', N'I.M.P.R.E.S.S')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (5, N'Zone 1 police Department', N'I.M.P.R.E.S.S')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (6, N'Zone 5 police Department', N'I.M.P.R.E.S.S')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (7, N'zone 1 farming union', N'Farm Hand Aces')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (8, N'99th aces Trading brigade', N'Farm Hand Aces ')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (9, N'zone 5 ace Engineers ', N'Farm Hand Aces')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (10, N'8th Gear Protection Group', N'Gear Corps')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (11, N'56th Gear Strike Unit', N'Gear Corps')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (12, N'6th Gear Protection Group', N'Gear Corps')
INSERT [dbo].[Units] ([UnitID], [UnitName], [Affiliation]) VALUES (13, N'99th Gear retrieval Company', N'Gear Corps')
SET IDENTITY_INSERT [dbo].[Units] OFF
GO
SET IDENTITY_INSERT [dbo].[Hostile] ON 

INSERT [dbo].[Hostile] ([HostileID], [HostileName], [HostileThreatLevel], [HostileDescription]) VALUES (1, N'Road Rats', 3, N'Active,')
INSERT [dbo].[Hostile] ([HostileID], [HostileName], [HostileThreatLevel], [HostileDescription]) VALUES (2, N'The New Land Order', 5, N'active')
INSERT [dbo].[Hostile] ([HostileID], [HostileName], [HostileThreatLevel], [HostileDescription]) VALUES (3, N'Isolation Court of the Pure', 1, N'Active')
INSERT [dbo].[Hostile] ([HostileID], [HostileName], [HostileThreatLevel], [HostileDescription]) VALUES (4, N'Southren Bandits', 1, N'Inactive')
INSERT [dbo].[Hostile] ([HostileID], [HostileName], [HostileThreatLevel], [HostileDescription]) VALUES (5, N'Northren Bandits', 3, N'Inactive.')
SET IDENTITY_INSERT [dbo].[Hostile] OFF
GO
SET IDENTITY_INSERT [dbo].[Zones] ON 

INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (1, N'Zone 1', N'Administrative')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (2, N'Zone 2', N'Forward base')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (3, N'Zone 3', N'Administrative')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (4, N'Zone 5', N'Administrative')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (5, N'Zone 6', N'food Production')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (6, N'Zone 7', N'Medical')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (7, N'Zone 11', N'Water Production')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (8, N'Zone 17', N'Enemy Territory')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (9, N'Zone 19', N'Enemy Territory')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (10, N'Zone 10', N'Allied Territory')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (11, N'Zone 12', N'Allied Territory')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (12, N'Zone 22', N'Allied Territory')
INSERT [dbo].[Zones] ([ZoneID], [ZoneName], [ZoneDescription]) VALUES (13, N'Zone 13', N'Material Production')
SET IDENTITY_INSERT [dbo].[Zones] OFF
GO
SET IDENTITY_INSERT [dbo].[LivingQuarters] ON 

INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (1, 1)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (2, 7)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (3, 10)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (4, 3)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (5, 2)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (6, 4)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (7, 5)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (8, 13)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (9, 12)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (10, 11)
INSERT [dbo].[LivingQuarters] ([QuartersID], [ZoneID]) VALUES (11, 6)
SET IDENTITY_INSERT [dbo].[LivingQuarters] OFF
GO
