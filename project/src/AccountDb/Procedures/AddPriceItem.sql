CREATE PROCEDURE [crm].[AddPriceItem]
	@CrmId NVARCHAR(40),
	@Name NVARCHAR(100), 
	@ShortName NVARCHAR(50), 
	@Count INT,
	@Month INT,
	@Price DECIMAL(18, 2),
	@RelatedServiceId BIGINT,
	@State TINYINT,
	@StartDate DATETIME,
	@EndDate DATETIME,
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

INSERT INTO [sales].[PriceItems]
		   ([CrmId]
		   ,[Name]
		   ,[ShortName]
		   ,[Count]
		   ,[Month]
		   ,[Price]
		   ,[RelatedServiceId]
		   ,[State]
		   ,[StartDate]
		   ,[EndDate])
	 VALUES
		   (@CrmId
		   ,@Name
		   ,@ShortName
		   ,@Count
		   ,@Month
		   ,@Price
		   ,@RelatedServiceId
		   ,@State
		   ,@StartDate
		   ,@EndDate)
	
	SET @ID = SCOPE_IDENTITY()
	RETURN
END