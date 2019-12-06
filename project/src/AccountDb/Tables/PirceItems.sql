CREATE TABLE [sales].[PriceItems]
(
    [PriceItemId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [CrmId] NVARCHAR(40) NOT NULL, -- идентификатор тарифа в CRM
    [Name] NVARCHAR(100) NOT NULL, 
    [ShortName] NVARCHAR(50) NOT NULL, 
    [Count] INT NULL, -- количество, если продается несколько лицензий
    [Month] INT NULL, -- число месяцев, если это подписка на сервис
    [Price] DECIMAL(18, 2) NOT NULL, -- цена
    [RelatedServiceId] BIGINT NULL, -- ссылка на сервис, если это подписка
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - активный, 1 - новый, 2 - неактивный, 3 - удален
    [StartDate] DATETIME NOT NULL, 
    [EndDate] DATETIME NULL, 
    CONSTRAINT [FK_PirceItems_ToServices] FOREIGN KEY ([RelatedServiceId]) REFERENCES [sales].[Services]([ServiceId]) 
)

GO

CREATE INDEX [IX_PriceItems_RelatedServiceId] ON [sales].[PriceItems] ([RelatedServiceId])
