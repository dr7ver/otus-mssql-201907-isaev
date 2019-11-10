CREATE TABLE [orgs].[Users]
(
    [UserId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [FirstName] NVARCHAR(100) NOT NULL, 
    [LastName] NVARCHAR(100) NOT NULL, 
    [MiddleName] NVARCHAR(100) NULL, 
    [MobilePhone] NCHAR(10) NULL, 
    [State] TINYINT NOT NULL DEFAULT 0
)
