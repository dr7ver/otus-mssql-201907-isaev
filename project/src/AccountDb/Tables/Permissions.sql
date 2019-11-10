CREATE TABLE [orgs].[Permissions]
(
	[PermissionId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [EmployeeId] BIGINT NOT NULL, 
    [ServiceId] BIGINT NOT NULL, 
    [AccessLevel] TINYINT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_Permissions_ToEmployees] FOREIGN KEY ([EmployeeId]) REFERENCES [orgs].[Employees]([EmployeeId]),
	CONSTRAINT [FK_Permissions_ToServices] FOREIGN KEY ([ServiceId]) REFERENCES [sales].[Services]([ServiceId])
)
