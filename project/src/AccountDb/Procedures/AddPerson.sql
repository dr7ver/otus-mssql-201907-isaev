CREATE PROCEDURE [site].[AddPerson]
	@Inn NCHAR(10),
	@FirstName NVARCHAR(100), 
	@LastName NVARCHAR(100), 
	@MiddleName NVARCHAR(100), 
	@OgrnIp NCHAR(15), 
	@ContactName NVARCHAR(100),
	@ContactPhone NVARCHAR(10),
	@ParentOrganizationId BIGINT = NULL,
	@State TINYINT = 0,
	@Id BIGINT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET XACT_ABORT ON

	BEGIN TRY
		BEGIN TRAN
		INSERT INTO [orgs].[Organizations]
			   ([RegistrationDate]
			   ,[State]
			   ,[ParentOrganizationId]
			   ,[ContactName]
			   ,[ContactPhone]
			   ,[Type])
			VALUES
			   (getDate()
			   ,@State
			   ,@ParentOrganizationId
			   ,@ContactName
			   ,@ContactPhone
			   ,0)
		SET @ID = SCOPE_IDENTITY()


		INSERT INTO [orgs].[PersonInfos]
				([OrganizationId]
				,[Inn]
				,[FirstName]
				,[LastName]
				,[MiddleName]
				,[OgrnIp])
			 VALUES
				(@ID
				,@Inn
				,@FirstName
				,@LastName
				,@MiddleName
				,@OgrnIp)

		commit tran

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	
	END CATCH
END