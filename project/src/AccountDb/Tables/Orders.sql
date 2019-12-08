CREATE TABLE [sales].[Orders]
(
    [OrderId] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [PrefixNumber] NVARCHAR(5) NOT NULL, -- Префикс уникального номера. Обозначает систему в которой генерируется заказ
	[OrdinalNumber] NVARCHAR(7) NOT NULL, -- Порядковый номер указанного префикса в одном календарном годе
	[Number] NVARCHAR(15) NOT NULL, --Уникальный номер заказа вида <Префикс><Год (YY)><Порядковый номер> Нарпимер AA190001234
    [Name] NVARCHAR(100) NOT NULL, 
    [UserId] BIGINT NOT NULL, 
	[CreateDate] datetime NOT NULL,
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - новый, 1 - в обработке, 2 - оплачен
    CONSTRAINT [FK_Orders_ToUsers] FOREIGN KEY ([UserId]) REFERENCES [orgs].[Users]([UserId])    
)

GO

CREATE INDEX [IX_Order_UserId] ON [sales].[Orders] ([UserId])

GO 

CREATE UNIQUE NONCLUSTERED INDEX IX_Order_Number
ON [sales].[Orders] ([Number])
