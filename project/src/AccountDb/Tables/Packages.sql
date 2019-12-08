CREATE TABLE [orgs].[Packages]
(
    [PackageId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [OrganizationId] BIGINT NOT NULL, 
    [PriceItemId] BIGINT NOT NULL, 
    [StartDate] DATETIME NOT NULL, 
    [EndDate] DATETIME NOT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - активный, 1 - новый, 2 - удален
	[SysStart] DATETIME2 (7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEnd] DATETIME2 (7) GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME ([SysStart], [SysEnd]),
    CONSTRAINT [FK_Packages_ToOrganizations] FOREIGN KEY ([OrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId]), 
    CONSTRAINT [FK_Packages_ToServices] FOREIGN KEY ([PriceItemId]) REFERENCES [sales].[PriceItems]([PriceItemId]) 
)
WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE=[orgs].[Packages_HISTORY], DATA_CONSISTENCY_CHECK=ON))

GO

CREATE INDEX [IX_Packages_OrganizationId] ON [orgs].[Packages] ([OrganizationId])

GO

CREATE INDEX [IX_Packages_PriceItemId] ON [orgs].[Packages] ([PriceItemId])
