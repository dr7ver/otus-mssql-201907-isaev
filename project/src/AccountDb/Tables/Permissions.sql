CREATE TABLE [orgs].[Permissions]
(
    [PermissionId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [EmployeeId] BIGINT NOT NULL, 
    [ServiceId] BIGINT NOT NULL, 
    [AccessLevel] TINYINT NOT NULL DEFAULT 0, -- уровень доступа к сервису: 0 - нет доступа, 1 - обычный пользователь, - 2 - администратор
	[SysStart] DATETIME2 (7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SysEnd] DATETIME2 (7) GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME ([SysStart], [SysEnd]),
    CONSTRAINT [FK_Permissions_ToEmployees] FOREIGN KEY ([EmployeeId]) REFERENCES [orgs].[Employees]([EmployeeId]),
    CONSTRAINT [FK_Permissions_ToServices] FOREIGN KEY ([ServiceId]) REFERENCES [sales].[Services]([ServiceId])
)
WITH (SYSTEM_VERSIONING = ON(HISTORY_TABLE=[orgs].[Permissions_HISTORY], DATA_CONSISTENCY_CHECK=ON))

GO

CREATE INDEX [IX_Permissions_EmployeeId] ON [orgs].[Permissions] ([EmployeeId])

GO

CREATE INDEX [ServiceId] ON [orgs].[Permissions] ([ServiceId])
