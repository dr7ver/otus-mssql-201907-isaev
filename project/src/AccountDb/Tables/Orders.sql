CREATE TABLE [sales].[Orders]
(
    [OrderId] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [Number] NVARCHAR(10) NOT NULL unique, 
    [Name] NVARCHAR(100) NOT NULL, 
    [PdfContent] VARBINARY(max) NOT NULL, 
    [UserId] BIGINT NOT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_Orders_ToUsers] FOREIGN KEY ([UserId]) REFERENCES [orgs].[Users]([UserId])
    
)
