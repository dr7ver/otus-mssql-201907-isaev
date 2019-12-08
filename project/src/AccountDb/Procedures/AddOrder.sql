CREATE PROCEDURE [site].[AddOrder]
    @PrefixNumber NVARCHAR(10),
    @Name NVARCHAR(100), 
    @UserId BIGINT, 
	@CreateDate datetime,
    @State TINYINT,
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	declare @ordinalNumber int
	declare @number nvarchar(15)
	set @ordinalNumber = (
		select
			isnull(max([OrdinalNumber]),0)+1
		from sales.orders as o 
		where year(o.createdate) = year(@createdate) and o.[PrefixNumber] = @PrefixNumber
	)
	set @number = (Concat(@PrefixNumber, format(@CreateDate, 'yy'), RIGHT(Concat('000000', @OrdinalNumber), 6)))

	INSERT INTO [sales].[Orders]
			   ([PrefixNumber]
			   ,[OrdinalNumber]
			   ,[Number]
			   ,[Name]
			   ,[UserId]
			   ,[CreateDate]
			   ,[State])
		 VALUES
			   (@PrefixNumber
			   ,@ordinalNumber
			   ,@number
			   ,@Name
			   ,@UserId
			   ,@CreateDate
			   ,@State)


	SET @ID = SCOPE_IDENTITY()
	RETURN
END