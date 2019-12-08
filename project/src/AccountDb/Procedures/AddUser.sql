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