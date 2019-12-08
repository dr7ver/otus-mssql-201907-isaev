CREATE PROCEDURE [site].[AddUser]
    @FirstName NVARCHAR(100), 
    @LastName NVARCHAR(100), 
    @MiddleName NVARCHAR(100), 
    @MobilePhone NCHAR(10), 
    @Email NVARCHAR(400),
    @State INT = 0,
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	if exists (
		select 1
		from orgs.Users as u
		where u.MobilePhone = @MobilePhone and u.State in (0, 1)
	)
	begin
		print 'Mobile phone alredy registered';
		throw 60001, 'Mobile phone alredy registered', 1
	end

	if exists (
		select 1
		from orgs.Users as u
		where u.Email = @Email and u.State in (0, 1)
	)
	begin
		print 'Email alredy registered';
		throw 60002, 'Email alredy registered', 1
	end

	INSERT INTO [orgs].[Users]
           ([FirstName]
           ,[LastName]
           ,[MiddleName]
           ,[MobilePhone]
		   ,[Email]
           ,[State])
     VALUES
           (@FirstName
           ,@LastName
           ,@MiddleName
           ,@MobilePhone
           ,@Email
           ,@State)
	
	SET @ID = SCOPE_IDENTITY()
	RETURN
END