CREATE PROCEDURE [site].[AddOrderLine]
    @OrderId BIGINT,
    @PriceItemId BIGINT,
    @Count INT,
    @TotalPrice DECIMAL(18, 2),
    @RelatedOrganizationId BIGINT,
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	INSERT INTO [sales].[OrderLines]
			   ([OrderId]
			   ,[PriceItemId]
			   ,[Count]
			   ,[TotalPrice]
			   ,[RelatedOrganizationId])
		 VALUES
			   (@OrderId
			   ,@PriceItemId
			   ,@Count
			   ,@TotalPrice
			   ,@RelatedOrganizationId)

	SET @ID = SCOPE_IDENTITY()
	RETURN
END