CREATE PROCEDURE [site].[AddEmployee]
    @OrganizationId BIGINT, 
    @UserId BIGINT, 
    @Post NVARCHAR(50),
    @State TINYINT,
	@AccessLevel TINYINT,
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	INSERT INTO [orgs].[Employees]
			   ([OrganizationId]
			   ,[UserId]
			   ,[Post]
			   ,[State]
			   ,[AccessLevel])
		 VALUES
			   (@OrganizationId
			   ,@UserId
			   ,@Post
			   ,@State
			   ,@AccessLevel)
	
	SET @ID = SCOPE_IDENTITY()
	RETURN
END