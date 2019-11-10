CREATE TABLE [sales].[OrderLines]
(
	[OrderLineId] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [OrderId] BIGINT NOT NULL, 
    [PriceItemId] BIGINT NOT NULL, 
    [Count] INT NOT NULL, 
    [TotalPrice] DECIMAL(18, 2) NOT NULL, 
    [RelatedOrganizationId] BIGINT NULL, 
    CONSTRAINT [FK_OrderLine_ToPriceItems] FOREIGN KEY ([PriceItemId]) REFERENCES [sales].[PriceItems]([PriceItemId]), 
    CONSTRAINT [FK_OrderLine_ToOrders] FOREIGN KEY ([OrderId]) REFERENCES [sales].[Orders]([OrderId]), 
    CONSTRAINT [FK_OrderLine_ToOrganizations] FOREIGN KEY ([RelatedOrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId])
)
