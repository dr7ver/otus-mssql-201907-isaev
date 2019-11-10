CREATE TABLE [sales].[PriceItems]
(
	[PriceItemId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [CrmId] NVARCHAR(40) NOT NULL, 
    [Name] NVARCHAR(100) NOT NULL, 
    [ShortName] NVARCHAR(50) NOT NULL, 
    [Count] INT NULL, 
    [Month] INT NULL, 
    [Price] DECIMAL(18, 2) NOT NULL, 
    [RelatedServiceId] BIGINT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_PirceItems_ToServices] FOREIGN KEY ([RelatedServiceId]) REFERENCES [sales].[Services]([ServiceId]) 
)
