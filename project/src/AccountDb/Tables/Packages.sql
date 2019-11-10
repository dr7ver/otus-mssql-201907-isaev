CREATE TABLE [orgs].[Packages]
(
    [PackageId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [OrganizationId] BIGINT NOT NULL, 
    [ServiceId] BIGINT NOT NULL, 
    [StartDate] DATETIME NOT NULL, 
    [EndDate] DATETIME NOT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_Packages_ToOrganizations] FOREIGN KEY ([OrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId]), 
    CONSTRAINT [FK_Packages_ToServices] FOREIGN KEY ([ServiceId]) REFERENCES [sales].[Services]([ServiceId]) 
)
