CREATE PROCEDURE [dbo].[GetUserOrganizations]
	@userId bigint,
	@startIndex int = 0,
	@batchCount int = 10
AS
BEGIN
	select c.Inn,
		c.Kpp,
		c.FullName,
		c.ShortName,
		p.Inn,
		p.LastName,
		p.FirstName,
		p.MiddleName,
		o.ContactName,
		o.ContactPhone
	from orgs.Employees as e
	join orgs.Organizations as o on e.OrganizationId = o.OrganizationId
	left join orgs.CompanyInfos as c on o.OrganizationId = c.OrganizationId and o.Type = 0
	left join orgs.PersonInfos as p on o.OrganizationId = p.OrganizationId and o.type = 1
	where e.UserId = @userId
	order by o.RegistrationDate
	offset @startIndex rows fetch first @batchCount rows only
RETURN 0
END
