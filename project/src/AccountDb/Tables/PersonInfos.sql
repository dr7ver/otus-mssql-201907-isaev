CREATE TABLE [orgs].[PersonInfos]
(
    [OrganizationId] BIGINT NOT NULL PRIMARY KEY, 
    [Inn] NCHAR(12) NOT NULL,
    [FirstName] NVARCHAR(100) NOT NULL, 
    [LastName] NVARCHAR(100) NOT NULL, 
    [MiddleName] NVARCHAR(100) NULL, 
    [OgrnIp] NCHAR(15) NOT NULL, 
    CONSTRAINT [FK_PersonInfos_Toorganizations] FOREIGN KEY ([OrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId])
)

GO

CREATE INDEX [IX_PersonInfos_Inn] ON [orgs].[PersonInfos] ([Inn])
