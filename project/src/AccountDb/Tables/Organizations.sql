CREATE TABLE [orgs].[Organizations]
(
    [OrganizationId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [RegistrationDate] DATETIME2 NOT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - активный, 1 - новый, 2 - неактивный, 3 - удален
    [ParentOrganizationId] BIGINT NULL, -- идентификатор головной органзиации
    [ContactName] NVARCHAR(100) NULL, -- имя контактного лица
    [ContactPhone] NVARCHAR(10) NULL, -- телефон контактного лица
    [Type] TINYINT NOT NULL DEFAULT 0, -- тип организации ИП ил ЮЛ
    CONSTRAINT [FK_Organizations_ToParentOrganizations] FOREIGN KEY ([ParentOrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId])
)
