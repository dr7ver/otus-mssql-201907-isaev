CREATE TABLE [orgs].[Addresses]
(
    [AddressId] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
	[OrganizationId] BIGINT NOT NULL,
	[Type] TINYINT NOT NULL, -- 0 - Юридический адрес; 1 - фактический адрес
    [PostIndex] NCHAR(6) NULL, 
    [RegionCode] TINYINT NULL, 
    [AreaPrefix] NVARCHAR(16) NULL, 
    [Area] NVARCHAR(128) NULL, 
    [CityPrefix] NVARCHAR(16) NULL, 
    [City] NVARCHAR(128) NULL, 
    [StreetPrefix] NVARCHAR(16) NULL, 
    [Street] NVARCHAR(128) NULL, 
    [HousePrefix] NVARCHAR(16) NULL, 
    [House] NVARCHAR(64) NULL, 
    [StructurePrefix] NVARCHAR(16) NULL, 
    [Structure] NVARCHAR(64) NULL, 
    [ApartmentPrefix] NVARCHAR(16) NULL,
    [Apartment] NVARCHAR(64) NULL,
    CONSTRAINT [FK_Addresses_ToOrganizations] FOREIGN KEY ([OrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId]),

)
