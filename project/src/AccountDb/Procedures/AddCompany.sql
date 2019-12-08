CREATE PROCEDURE [site].[AddCompany]
	@Inn NCHAR(10),
    @Kpp NCHAR(9),
    @FullName NVARCHAR(500), 
    @ShortName NVARCHAR(50), 
    @Ogrn NCHAR(13),
    @ContactName NVARCHAR(100),
    @ContactPhone NVARCHAR(10),
	@ParentOrganizationId BIGINT = NULL,
	@State TINYINT = 0,
	@Id BIGINT OUTPUT
AS
BEGIN

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


		INSERT INTO [orgs].[CompanyInfos]
				   ([OrganizationId]
				   ,[Inn]
				   ,[Kpp]
				   ,[FullName]
				   ,[ShortName]
				   ,[Ogrn])
			 VALUES
				   (@ID
				   ,@Inn
				   ,@Kpp
				   ,@FullName
				   ,@ShortName
				   ,@Ogrn)

		commit tran

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
    
	END CATCH
END
