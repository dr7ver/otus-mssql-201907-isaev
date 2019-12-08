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

	SET NOCOUNT ON;
	SET XACT_ABORT ON

	if exists (
		select 1
		from orgs.organizations as o
		join orgs.PersonInfos as p on o.OrganizationId = p.OrganizationId
		where p.Inn = @inn  and o.State in (0, 1)
	)
	begin
		print 'Organization alredy registered';
		throw 60003, 'Organization alredy registered', 1
	end


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

END