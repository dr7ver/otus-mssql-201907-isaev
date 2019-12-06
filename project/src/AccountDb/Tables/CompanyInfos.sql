CREATE TABLE [orgs].[CompanyInfos]
(
    [OrganizationId] BIGINT NOT NULL PRIMARY KEY, 
    [Inn] NCHAR(10) NOT NULL,
    [Kpp] NCHAR(9) NOT NULL,
    [FullName] NVARCHAR(500) NOT NULL, 
    [ShortName] NVARCHAR(50) NOT NULL, 
    [Ogrn] NCHAR(13) NOT NULL
    CONSTRAINT [FK_CompanyInfos_ToOrganizations] FOREIGN KEY ([OrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId])
)

GO

CREATE INDEX [IX_CompanyInfos_Inn] ON [orgs].[CompanyInfos] ([Inn], [Kpp])
