CREATE TABLE [sales].[Orders]
(
    [OrderId] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [PrefixNumber] NVARCHAR(5) NOT NULL, 
	[OrdinalNumber] nvarchar(6) NOT NULL,
	[Number] nvarchar(15) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL, 
    [UserId] BIGINT NOT NULL, 
	[CreateDate] datetime NOT NULL,
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - новый, 1 - в обработке, 2 - оплачен
	[SysStart] DATETIME2 (7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEnd] DATETIME2 (7) GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME ([SysStart], [SysEnd]),
    CONSTRAINT [FK_Orders_ToUsers] FOREIGN KEY ([UserId]) REFERENCES [orgs].[Users]([UserId])    
)
WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE=[sales].[Orders_HISTORY], DATA_CONSISTENCY_CHECK=ON))

GO

CREATE INDEX [IX_Order_UserId] ON [sales].[Orders] ([UserId])

GO 

CREATE UNIQUE NONCLUSTERED INDEX IX_Order_Number
ON [sales].[Orders] ([Number])
