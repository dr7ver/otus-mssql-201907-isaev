CREATE TABLE [orgs].[Packages]
(
    [PackageId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [OrganizationId] BIGINT NOT NULL, 
    [PriceItemId] BIGINT NOT NULL, 
    [StartDate] DATETIME NOT NULL, 
    [EndDate] DATETIME NOT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - активный, 1 - новый, 2 - удален
    CONSTRAINT [FK_Packages_ToOrganizations] FOREIGN KEY ([OrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId]), 
    CONSTRAINT [FK_Packages_ToServices] FOREIGN KEY ([PriceItemId]) REFERENCES [sales].[PriceItems]([PriceItemId]) 
)

GO

CREATE INDEX [IX_Packages_OrganizationId] ON [orgs].[Packages] ([OrganizationId])

GO

CREATE INDEX [IX_Packages_PriceItemId] ON [orgs].[Packages] ([PriceItemId])
