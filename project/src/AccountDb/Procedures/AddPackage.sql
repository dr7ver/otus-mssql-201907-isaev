CREATE PROCEDURE [crm].[AddPackage]
    @OrganizationId BIGINT,
    @PriceItemId BIGINT,
    @StartDate DATETIME,
    @EndDate DATETIME,
    @State TINYINT,
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	INSERT INTO [orgs].[Packages]
			   ([OrganizationId]
			   ,[PriceItemId]
			   ,[StartDate]
			   ,[EndDate]
			   ,[State])
		 VALUES
			   (@OrganizationId
			   ,@PriceItemId
			   ,@StartDate
			   ,@EndDate
			   ,@State)

	SET @ID = SCOPE_IDENTITY()
	RETURN
END