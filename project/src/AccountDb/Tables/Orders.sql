CREATE TABLE [sales].[Orders]
(
    [OrderId] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [Number] NVARCHAR(10) NOT NULL unique, 
    [Name] NVARCHAR(100) NOT NULL, 
    [UserId] BIGINT NOT NULL, 
	[CreateDate] datetime NOT NULL,
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - новый, 1 - в обработке, 2 - оплачен
    CONSTRAINT [FK_Orders_ToUsers] FOREIGN KEY ([UserId]) REFERENCES [orgs].[Users]([UserId])    
)

GO

CREATE INDEX [IX_Order_UserId] ON [sales].[Orders] ([UserId])

