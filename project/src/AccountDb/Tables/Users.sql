CREATE TABLE [orgs].[Users]
(
    [UserId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [FirstName] NVARCHAR(100) NOT NULL, 
    [LastName] NVARCHAR(100) NOT NULL, 
    [MiddleName] NVARCHAR(100) NULL, 
    [MobilePhone] NCHAR(10) NOT NULL, 
    [Email] NVARCHAR(400) NOT NULL,
    [State] TINYINT NOT NULL DEFAULT 0 -- 0 - активный, 1 - новый, 2 - неактивный, 3 - удален
)

GO

CREATE INDEX [IX_Users_MobilePhone] ON [orgs].[Users] ([MobilePhone])

GO

CREATE INDEX [IX_Users_Email] ON [orgs].[Users] ([Email])
