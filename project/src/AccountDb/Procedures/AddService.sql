CREATE PROCEDURE [crm].[AddService]
    @Name NVARCHAR(100), 
    @Description NVARCHAR(1000), 
    @ShortName NVARCHAR(50), 
    @AuthPage NVARCHAR(200), 
    @LendingPage NVARCHAR(200),
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	INSERT INTO [sales].[Services]
			   ([Name]
			   ,[Description]
			   ,[ShortName]
			   ,[AuthPage]
			   ,[LendingPage])
		 VALUES
			   (@Name
			   ,@Description
			   ,@ShortName
			   ,@AuthPage
			   ,@LendingPage)
	
	SET @ID = SCOPE_IDENTITY()
	RETURN
END