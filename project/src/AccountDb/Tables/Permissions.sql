CREATE TABLE [orgs].[Permissions]
(
    [PermissionId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [EmployeeId] BIGINT NOT NULL, 
    [ServiceId] BIGINT NOT NULL, 
    [AccessLevel] TINYINT NOT NULL DEFAULT 0, -- уровень доступа к сервису: 0 - нет доступа, 1 - обычный пользователь, - 2 - администратор
    CONSTRAINT [FK_Permissions_ToEmployees] FOREIGN KEY ([EmployeeId]) REFERENCES [orgs].[Employees]([EmployeeId]),
    CONSTRAINT [FK_Permissions_ToServices] FOREIGN KEY ([ServiceId]) REFERENCES [sales].[Services]([ServiceId])
)
