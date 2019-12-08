CREATE PROCEDURE [site].[AddAddress]
	@OrganizationId BIGINT,
	@Type TINYINT,
    @PostIndex NCHAR(6),
    @RegionCode TINYINT,
    @AreaPrefix NVARCHAR(16), 
    @Area NVARCHAR(128), 
    @CityPrefix NVARCHAR(16), 
    @City NVARCHAR(128), 
    @StreetPrefix NVARCHAR(16), 
    @Street NVARCHAR(128), 
    @HousePrefix NVARCHAR(16), 
    @House NVARCHAR(64), 
    @StructurePrefix NVARCHAR(16), 
    @Structure NVARCHAR(64), 
    @ApartmentPrefix NVARCHAR(16),
    @Apartment NVARCHAR(64),
	@Id BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET XACT_ABORT ON

	INSERT INTO [orgs].[Addresses]
			   ([OrganizationId],
				[Type],
				[PostIndex],
				[RegionCode],
				[AreaPrefix],
				[Area],
				[CityPrefix],
				[City],
				[StreetPrefix],
				[Street],
				[HousePrefix],
				[House],
				[StructurePrefix],
				[Structure],
				[ApartmentPrefix],
				[Apartment])
		 VALUES
			   (@OrganizationId,
				@Type,
				@PostIndex,
				@RegionCode,
				@AreaPrefix,
				@Area,
				@CityPrefix,
				@City,
				@StreetPrefix,
				@Street,
				@HousePrefix,
				@House,
				@StructurePrefix,
				@Structure,
				@ApartmentPrefix,
				@Apartment)
	
	SET @ID = SCOPE_IDENTITY()
	RETURN
END