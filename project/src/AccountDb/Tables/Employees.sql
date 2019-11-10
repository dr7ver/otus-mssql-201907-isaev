CREATE TABLE [orgs].[Employees]
(
	[EmployeeId] BIGINT NOT NULL PRIMARY KEY IDENTITY , 
    [OrganizationId] BIGINT NOT NULL, 
    [UserId] BIGINT NOT NULL, 
    [Post] NVARCHAR(50) NOT NULL, 
    [State] TINYINT NOT NULL DEFAULT 0, 
    CONSTRAINT [FK_Employees_ToOrganizations] FOREIGN KEY ([OrganizationId]) REFERENCES [orgs].[Organizations]([OrganizationId]),
	CONSTRAINT [FK_Employees_ToUsers] FOREIGN KEY ([UserId]) REFERENCES [orgs].[Users]([UserId])
)
