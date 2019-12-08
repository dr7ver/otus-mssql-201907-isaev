CREATE PROCEDURE [site].[AddPermission]
    @EmployeeId BIGINT,
    @ServiceId BIGINT,
    @AccessLevel TINYINT,
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	INSERT INTO [orgs].[Permissions]
			   ([EmployeeId]
			   ,[ServiceId]
			   ,[AccessLevel])
		 VALUES
			   (@EmployeeId
			   ,@ServiceId
			   ,@AccessLevel)

	SET @ID = SCOPE_IDENTITY()
	RETURN
END