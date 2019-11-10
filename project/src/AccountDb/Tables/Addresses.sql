CREATE TABLE [orgs].[Addresses]
(
	[AddressId] BIGINT NOT NULL PRIMARY KEY, 
    [PostIndex] NCHAR(6) NULL, 
    [RegionCode] TINYINT NULL, 
    [Area] NVARCHAR(128) NULL, 
    [City] NVARCHAR(128) NULL, 
    [Street] NVARCHAR(128) NULL, 
    [House] NVARCHAR(64) NULL, 
    [Structure] NVARCHAR(64) NULL, 
    [Apartment] NVARCHAR(64) NULL
)
