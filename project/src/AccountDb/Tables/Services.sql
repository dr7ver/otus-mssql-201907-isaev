CREATE TABLE [sales].[Services]
(
    [ServiceId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [Name] NVARCHAR(100) NOT NULL, 
    [Description] NVARCHAR(1000) NULL, 
    [ShortName] NVARCHAR(50) NULL, 
    [AuthPage] NVARCHAR(200) NULL, 
    [LendingPage] NVARCHAR(200) NULL
)
