CREATE TABLE [orgs].[Organizations]
(
    [OrganizationId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [RegistrationDate] DATETIME2 NOT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - активный, 1 - новый, 2 - неактивный, 3 - удален
    [ParentOrganizationId] BIGINT NULL, -- идентификатор головной органзиации
    [ContactName] NVARCHAR(100) NULL, -- имя контактного лица
    [ContactPhone] NVARCHAR(10) NULL, -- телефон контактного лица
    [LegalAddressId] BIGINT NOT NULL, -- юридический адрес
    [ActualAddressId] BIGINT NULL, -- фактический адрес
    [Type] TINYINT NOT NULL DEFAULT 0, -- тип организации ИП ил ЮЛ
    CONSTRAINT [FK_Organizations_ToParentOrganizations] FOREIGN KEY ([ParentOrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId]), 
    CONSTRAINT [FK_Organizations_ToLegalAddress] FOREIGN KEY ([LegalAddressId]) REFERENCES [orgs].[Addresses]([AddressId]),
    CONSTRAINT [FK_Organizations_ToActualAddress] FOREIGN KEY ([ActualAddressId]) REFERENCES [orgs].[Addresses]([AddressId])
)
