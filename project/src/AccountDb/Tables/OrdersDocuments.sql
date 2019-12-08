CREATE TABLE [sales].[OrdersDocuments]
(
	[OrderId] BIGINT NOT NULL PRIMARY KEY,
	[OrderPdf] VARBINARY(max) NOT NULL,
	CONSTRAINT [FK_OrdersDocuments_ToOrders] FOREIGN KEY ([OrderId]) REFERENCES [sales].[Orders]([OrderId])
)
