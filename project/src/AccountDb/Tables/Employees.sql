CREATE TABLE [orgs].[Employees]
(
    [EmployeeId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [OrganizationId] BIGINT NOT NULL, 
    [UserId] BIGINT NOT NULL, 
    [Post] NVARCHAR(50) NOT NULL, -- должность
    [State] TINYINT NOT NULL DEFAULT 0, -- 0 - активный, 1 - новый, 2 - неактивный, 3 - удален
	[AccessLevel] TINYINT NOT NULL DEFAULT 0 -- уровень доступа к организации (изменение данных, подключение сервисов): 0 - просмотр, 1 - есть доступ на изменение данных, 2 - есть доступ на подключение сервисов
    CONSTRAINT [FK_Employees_ToOrganizations] FOREIGN KEY ([OrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId]),
    CONSTRAINT [FK_Employees_ToUsers] FOREIGN KEY ([UserId]) REFERENCES [orgs].[Users]([UserId])
)
