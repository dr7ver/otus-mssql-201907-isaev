CREATE TABLE [sales].[OrderLines]
(
    [OrderLineId] BIGINT NOT NULL PRIMARY KEY IDENTITY, 
    [OrderId] BIGINT NOT NULL, 
    [PriceItemId] BIGINT NOT NULL, 
    [Count] INT NOT NULL, 
    [TotalPrice] DECIMAL(18, 2) NOT NULL, 
    [RelatedOrganizationId] BIGINT NULL, -- ссылка на связанную органзиацию, если покупается подписка
    CONSTRAINT [FK_OrderLine_ToPriceItems] FOREIGN KEY ([PriceItemId]) REFERENCES [sales].[PriceItems]([PriceItemId]), 
    CONSTRAINT [FK_OrderLine_ToOrders] FOREIGN KEY ([OrderId]) REFERENCES [sales].[Orders]([OrderId]), 
    CONSTRAINT [FK_OrderLine_ToOrganizations] FOREIGN KEY ([RelatedOrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId])
)

GO

CREATE INDEX [IX_OrderLines_OrderId] ON [sales].[OrderLines] ([OrderId])

GO

CREATE INDEX [IX_OrderLines_PriceItemId] ON [sales].[OrderLines] ([PriceItemId])

GO

CREATE INDEX [IX_OrderLines_RelatedOrganizationId] ON [sales].[OrderLines] ([RelatedOrganizationId])
