CREATE TABLE [orgs].[Organizations]
(
	[OrganizationId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [RegistrationDate] DATETIME2 NOT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, 
    [ParentOrganizationId] BIGINT NULL, 
    [ContactName] NVARCHAR(100) NULL, 
    [ContactPhone] NVARCHAR(10) NULL, 	
    [LegalAddressId] BIGINT NOT NULL, 
    [ActualAddressId] BIGINT NULL, 
    CONSTRAINT [FK_Organizations_ToParentOrganizations] FOREIGN KEY ([ParentOrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId]), 
    CONSTRAINT [FK_Organizations_ToLegalAddress] FOREIGN KEY ([LegalAddressId]) REFERENCES [orgs].[Addresses]([AddressId]),
	CONSTRAINT [FK_Organizations_ToActualAddress] FOREIGN KEY ([ActualAddressId]) REFERENCES [orgs].[Addresses]([AddressId])
)
