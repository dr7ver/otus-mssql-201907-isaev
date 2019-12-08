--/*
--Post-Deployment Script Template							
----------------------------------------------------------------------------------------
-- This file contains SQL statements that will be appended to the build script.		
-- Use SQLCMD syntax to include a file in the post-deployment script.			
-- Example:      :r .\myfile.sql								
-- Use SQLCMD syntax to reference a variable in the post-deployment script.		
-- Example:      :setvar TableName MyTable							
--               SELECT * FROM [$(TableName)]					
----------------------------------------------------------------------------------------
--*/

--INSERT INTO [orgs].[Users]
--           ([FirstName]
--           ,[LastName]
--           ,[MiddleName]
--           ,[MobilePhone]
--		   ,[Email]
--           ,[State])
--     VALUES
--           (N'Бабенок'
--           ,N'Илья'
--           ,N'Викторович'
--           ,N'8923548965'
--           ,N'astronavt@gmail.com'
--           ,0),
--           (N'Климов'
--           ,N'Марсель'
--           ,N'Эльдарович'
--           ,N'9232523522'
--           ,N'clish@gmail.com'
--           ,0),
--           (N'Муровая'
--           ,N'Анна'
--           ,N'Петровна'
--           ,N'9223235223'
--           ,N'anna_n@gmail.com'
--           ,0),
--           (N'Щуров'
--           ,N'Остап'
--           ,N'Сергеевич'
--           ,N'9552352322'
--           ,N'osstap@gmail.com'
--           ,1),
--           (N'Ворошилов'
--           ,N'Петр'
--           ,N'Сергеевич'
--           ,N'3424234235'
--           ,N'strelok#mail.ru'
--           ,0)
--GO


--INSERT INTO [orgs].[Addresses]
--           ([PostIndex]
--           ,[RegionCode]
--           ,[Area]
--           ,[City]
--           ,[Street]
--           ,[House]
--           ,[Structure]
--           ,[Apartment])
--     VALUES
--           ('107497'
--           ,77
--           ,NULL
--           ,N'Москва'
--           ,N'ул. Глиняная'
--           ,N'д. 20'
--           ,NULL
--           ,N'оф. 475'),
--           ('107495'
--           ,77
--           ,NULL
--           ,N'Москва'
--           ,N'ул. Шейнкмана'
--           ,N'д. 14'
--           ,NULL
--           ,N'оф. 234'),
--           ('420015'
--           ,16
--           ,NULL
--           ,N'г. Казань'
--           ,N'ул. Покрышкина'
--           ,N'д. 52'
--           ,NULL
--           ,N'оф. 4'),
--           ('420013'
--           ,16
--           ,NULL
--           ,N'г. Казань'
--           ,N'ул. Карла Маркса'
--           ,N'д. 23'
--           ,N'кор. 1'
--           ,N'кв. 114'),
--           ('192102'
--           ,78
--           ,NULL
--           ,N'Санкт-Петербург'
--           ,N'ул. Заставская'
--           ,N'д. 37Е'
--           ,N'пом. 2'
--           ,NULL),
--           ('192102'
--           ,77
--           ,N'Войковский'
--           ,N'Москва'
--           ,N'ул. Мира'
--           ,N'д. 234'
--           ,N'кор. 1 литер а'
--           ,NULL),
--           ('192102'
--           ,77
--           ,N'Войковский'
--           ,N'Москва'
--           ,N'ул. Мира'
--           ,N'д. 24'
--           ,N'кор. 2'
--           ,NULL),
--           ('299038'
--           ,92
--           ,NULL
--           ,N'Севастополь'
--           ,N'ул. Колобова'
--           ,N'д. 18'
--           ,NULL
--           ,N'кв. 31')
--GO


--USE [AccountDb]
--GO

--INSERT INTO [orgs].[Organizations]
--           ([RegistrationDate]
--           ,[State]
--           ,[ParentOrganizationId]
--           ,[ContactName]
--           ,[ContactPhone]
--           ,[LegalAddressId]
--           ,[ActualAddressId]
--           ,[Type])
--     VALUES
--           (dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
--           ,0
--           ,NULL
--           ,N'Илья Петрович'
--           ,N'4952223233'
--           ,1
--           ,2
--           ,0),
--           (dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
--           ,1
--           ,NULL
--           ,NULL
--           ,NULL
--           ,3
--           ,4
--           ,0),
--           (dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
--           ,0
--           ,NULL
--           ,NULL
--           ,NULL
--           ,5
--           ,NULL
--           ,0),
--           (dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
--           ,0
--           ,NULL
--           ,NULL
--           ,NULL
--           ,6
--           ,NULL
--           ,1),
--           (dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
--           ,0
--           ,NULL
--           ,NULL
--           ,NULL
--           ,7
--           ,NULL
--           ,1),
--           (dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
--           ,0
--           ,NULL
--           ,N'Наталья'
--           ,N'9823223422'
--           ,8
--           ,NULL
--           ,0)
--GO

--INSERT INTO [orgs].[CompanyInfos]
--           ([OrganizationId]
--           ,[Inn]
--           ,[Kpp]
--           ,[FullName]
--           ,[ShortName]
--           ,[Ogrn])
--     VALUES
--           (1
--           ,'7727334534'
--           ,'772701001'
--           ,N'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "БОК"'
--           ,N'ООО "БОК"'
--           ,'1155005000233'),
--           (2
--           ,'1657074653'
--           ,'165701001'
--           ,N'Садоводческое некоммерческое товарищество "ПРОГРЕСС ПЛЮС"'
--           ,N'СНТ "ПРОГРЕСС ПЛЮС"'
--           ,'1155005000233'),
--           (3
--           ,'6319232342'
--           ,'631901001'
--           ,N'Акционерное общество "Рустех"'
--           ,N'АО "Рустех"'
--           ,'1155005000233'),
--           (6
--		   ,'9731012352'
--           ,'973101001'
--           ,N'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "СТОМАТОЛОГИЯ"'
--           ,N'ООО "СТОМАТОЛОГИЯ"'
--           ,'5067847240232')
--GO

--USE [AccountDb]
--GO

--INSERT INTO [orgs].[PersonInfos]
--           ([OrganizationId]
--           ,[Inn]
--           ,[FirstName]
--           ,[LastName]
--           ,[MiddleName]
--           ,[OgrnIp])
--     VALUES
--           (4
--           ,'643900725343'
--           ,N'Щуров'
--           ,N'Остап'
--           ,N'Сергеевич'
--           ,'319745600242347'),
--		   (5
--           ,'330604032323'
--           ,N'Муровая'
--           ,N'Анна'
--           ,N'Петровна'
--           ,'318784700525233')
--GO


--INSERT INTO [orgs].[Employees]
--           ([OrganizationId]
--           ,[UserId]
--           ,[Post]
--           ,[State]
--           ,[AccessLevel])
--     VALUES
--           (1
--           ,1
--           ,N'Бухгалтер'
--           ,0
--           ,2),
--           (2
--           ,1
--           ,N'Бухгалтер'
--           ,0
--           ,2),
--           (3
--           ,2
--           ,N'Бухгалтер'
--           ,0
--           ,2),
--           (4
--           ,4
--           ,N'Директор'
--           ,0
--           ,2),
--           (5
--           ,3
--           ,N'Директор'
--           ,0
--           ,2),
--           (6
--           ,1
--           ,N'Бухгалтер'
--           ,0
--           ,2),
--           (6
--           ,5
--           ,N'Управлящий'
--           ,0
--           ,2)
--GO


--INSERT INTO [sales].[Services]
--           ([Name]
--           ,[Description]
--           ,[ShortName]
--           ,[AuthPage]
--           ,[LendingPage])
--     VALUES
--           (N'Отчетность'
--           ,N'Сервис по сдаче отчетности'
--           ,N'Отчетность'
--           ,N'https://test.ru/Authorize'
--           ,N'https://test.ru'),
--           (N'"Электронный документооборот'
--           ,N'Сервис по электронному взаимодействию'
--           ,N'Эдо'
--           ,N'https://edo.ru/Authorize'
--           ,N'https://edo.ru')
--GO


--INSERT INTO [sales].[PriceItems]
--           ([CrmId]
--           ,[Name]
--           ,[ShortName]
--           ,[Count]
--           ,[Month]
--           ,[Price]
--           ,[RelatedServiceId]
--           ,[State]
--           ,[StartDate]
--           ,[EndDate])
--     VALUES
--           (N'50C80E06-7AF7-45C6-97F7-3520AD065A6D'
--           ,N'Годовой тариф'
--           ,N'Годовой тариф'
--           ,1
--           ,12
--           ,5400
--           ,1
--           ,0
--           ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,NULL),
--           (N'921F0FBE-39BB-4AA8-80D1-D9D07FC2962C'
--           ,N'Годовой тариф'
--           ,N'Годовой тариф'
--           ,1
--           ,12
--           ,3400
--           ,2
--           ,0
--           ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,NULL),
--           (N'86B7D2D0-6854-4798-BE1A-959721DB188B'
--           ,N'Годовой тариф +'
--           ,N'Годовой тариф +'
--           ,1
--           ,12
--           ,7400
--           ,1
--           ,0
--           ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,NULL),
--           (N'607F03E7-4A42-40A5-A7B1-9840597DBECB'
--           ,N'Электронно цифровая подпись'
--           ,N'ЭЦП'
--           ,1
--           ,12
--           ,1200
--           ,NULL
--           ,0
--           ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,NULL),
--           (N'5057E286-715A-48BD-88DE-73DEDB3A9A04'
--           ,N'Электронно цифровая подпись'
--           ,N'ЭЦП'
--           ,1
--           ,12
--           ,1000
--           ,NULL
--           ,3
--           ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 10, getdate()))),
--           (N'D5B333C7-281A-4A61-B936-55422D312E3D'
--           ,N'Лицензия на программу'
--           ,N'Лицензия'
--           ,1
--           ,12
--           ,5000
--           ,NULL
--           ,3
--           ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,NULL)
--GO


--INSERT INTO [sales].[Orders]
--           ([Number]
--           ,[Name]
--           ,[UserId]
--		   ,[CreateDate]
--           ,[State])
--     VALUES
--           (N'AA19000001'
--           ,N'Заказ от 19.11.2019'
--           ,1
--		   ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 10, getdate()))
--           ,2),
--           (N'AA19000002'
--           ,N'Заказ от 20.11.2019'
--           ,2
--		   ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,2),
--           (N'AA19000003'
--           ,N'Заказ от 20.11.2019'
--           ,3
--		   ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,0),
--           (N'AA19000004'
--           ,N'Заказ от 20.11.2019'
--           ,1
--		   ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,0),
--           (N'AA19000005'
--           ,N'Заказ от 21.11.2019'
--           ,4
--		   ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,0),
--           (N'AA19000006'
--           ,N'Заказ от 25.11.2019'
--           ,5
--		   ,(dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate()))
--           ,0)
--GO

--INSERT INTO [sales].[OrderLines]
--           ([OrderId]
--           ,[PriceItemId]
--           ,[Count]
--           ,[TotalPrice]
--           ,[RelatedOrganizationId])
--     VALUES
--           (1
--           ,1
--           ,1
--           ,5400
--           ,1),
--           (1
--           ,3
--           ,2
--           ,2400
--           ,NULL),
--           (2
--           ,2
--           ,1
--           ,3400
--           ,2),
--           (3
--           ,3
--           ,1
--           ,7400
--           ,3),
--           (4
--           ,3
--           ,1
--           ,7400
--           ,4),
--           (5
--           ,3
--           ,1
--           ,7400
--           ,5),
--           (5
--           ,2
--           ,1
--           ,3400
--           ,6)
--GO


PRINT N'Run PostDeployment...';

--IF NOT EXISTS (SELECT 1 FROM orgs.Permissions)
--BEGIN
--	PRINT N'Database already seed...';
--	return
--END

declare @id bigint,
		@userId bigint,
		@employeeId bigint,
		@organizationId bigint,
		@serviceId bigint,
		@priceItemId bigint,
		@date datetime,
		@date2 datetime

declare @services table (id bigint)
declare @priceItems table (id bigint)


PRINT N'Add services...';

EXECUTE [crm].[addservice] 
           N'Отчетность'
           ,N'Сервис по сдаче отчетности'
           ,N'Отчетность'
           ,N'https://test.ru/Authorize'
           ,N'https://test.ru'
		   ,@id output

insert into @services
values (@id)

EXECUTE [crm].[addservice] 
           N'"Электронный документооборот'
           ,N'Сервис по электронному взаимодействию'
           ,N'Эдо'
           ,N'https://edo.ru/Authorize'
           ,N'https://edo.ru'
		   ,@id output

insert into @services
values (@id)

PRINT N'Add price items...';

set @date = dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
EXECUTE [crm].[AddPriceItem] 
           N'50C80E06-7AF7-45C6-97F7-3520AD065A6D'
           ,N'Годовой тариф'
           ,N'Годовой тариф'
           ,1
           ,12
           ,5400
           ,1
           ,0
           ,@date
           ,NULL
		   ,@id output

insert into @priceItems
values (@id)

set @date = dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
EXECUTE [crm].[AddPriceItem] 
           N'921F0FBE-39BB-4AA8-80D1-D9D07FC2962C'
           ,N'Годовой тариф'
           ,N'Годовой тариф'
           ,1
           ,12
           ,3400
           ,2
           ,0
           ,@date
           ,NULL
		   ,@id output

insert into @priceItems
values (@id)

set @date = dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
EXECUTE [crm].[AddPriceItem] 
           N'607F03E7-4A42-40A5-A7B1-9840597DBECB'
           ,N'Электронно цифровая подпись'
           ,N'ЭЦП'
           ,1
           ,12
           ,1200
           ,NULL
           ,0
           ,@date
           ,NULL
		   ,@id output

insert into @priceItems
values (@id)



PRINT N'Add users...';

EXECUTE [site].[AddUser] 
			N'Бабенок'
           ,N'Илья'
           ,N'Викторович'
           ,N'8923548965'
           ,N'astronavt@gmail.com'
           ,0
		   ,@userid output


PRINT N'Add companies...';

EXECUTE [site].[AddCompany] 
           '7727334534'
           ,'772701001'
           ,N'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "БОК"'
           ,N'ООО "БОК"'
           ,'1155005000233'
           ,N'Илья Петрович'
           ,N'4952223233'
		   ,NULL
		   ,0
		   ,@organizationId output


PRINT N'Add addresses...';

EXECUTE [site].[AddAddress] 
			@organizationId
			,0
			,'107497'
           ,77
           ,NULL
           ,NULL
           ,N'г'
           ,N'Москва'
           ,N'ул.'
		   ,N'Глиняная'
           ,N'д.'
		   ,'20'
           ,NULL
           ,NULL
           ,N'оф.'
		   ,'475'
		   ,@id output

EXECUTE [site].[AddAddress] 
			@organizationId
			,1
			,'107497'
           ,77
           ,NULL
           ,NULL
           ,N'г'
           ,N'Москва'
           ,N'ул.'
		   ,N'Глиняная'
           ,N'д.'
		   ,'22'
           ,NULL
           ,NULL
           ,N'пом.'
		   ,'7'
		   ,@id output


PRINT N'Add employees...';

EXECUTE [site].[AddEmployee] 
           @organizationId
           ,@userId
           ,N'Бухгалтер'
           ,0
           ,2
		   ,@employeeId output
		   

PRINT N'Add orders...';

set @date = dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
EXECUTE [site].[addorder] 
           N'AA'
           ,N'Заказ от 19.11.2019'
           ,@userId
		   ,@date
           ,2
		   ,@id output

set @priceItemId = (select min(id) from @priceItems)
EXECUTE [site].[AddOrderLine] 
           @userId
           ,@priceItemId
           ,1
           ,5400
           ,1
		   ,@id output


PRINT N'Add packages...';

set @date = dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
set @date2 = dateadd(day, ABS(CHECKSUM(NewId())) % 100, getdate())
EXECUTE [crm].[AddPackage] 
           @organizationId
           ,@priceItemId
           ,@date
           ,@date2
           ,1
		   ,@id output


PRINT N'Add permissions...';

set @serviceId = (select min(id) from @services)
EXECUTE [site].[AddPermission] 
           @employeeId
           ,@serviceId
           ,1
		   ,@id output



PRINT N'Add users...';

EXECUTE [site].[AddUser] 
			N'Климов'
           ,N'Марсель'
           ,N'Эльдарович'
           ,N'9232523522'
           ,N'clish@gmail.com'
           ,0
		   ,@userId output


PRINT N'Add persons...';

EXECUTE [site].[AddPerson] 
           '643900725343'
           ,N'Щуров'
           ,N'Остап'
           ,N'Сергеевич'
           ,'319745600242347'
           ,N'Илья Петрович'
           ,N'4952223233'
		   ,NULL
		   ,0
		   ,@organizationId output

PRINT N'Add addresses...';

EXECUTE [site].[AddAddress] 
			@organizationId
			,0
			,'107497'
           ,77
           ,NULL
           ,NULL
           ,N'г'
           ,N'Казань'
           ,N'ул.'
		   ,N'Мира'
           ,N'д.'
		   ,'334'
           ,N'стр.'
           ,N'2'
           ,N'оф.'
		   ,'2'
		   ,@id output


PRINT N'Add employees...';

EXECUTE [site].[AddEmployee] 
           1
           ,1
           ,N'Бухгалтер'
           ,0
           ,2
		   ,@employeeId output


PRINT N'Add orders...';

set @date = dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
EXECUTE [site].[addorder] 
           N'AA'
           ,N'Заказ от 19.11.2019'
           ,@userId
		   ,@date
           ,2
		   ,@id output

set @priceItemId = (select min(id) from @priceItems)
EXECUTE [site].[AddOrderLine] 
           @id
           ,@priceItemId
           ,1
           ,5400
           ,1
		   ,@id output
set @priceItemId = (select max(id) from @priceItems)
EXECUTE [site].[AddOrderLine] 
           @id
           ,@priceItemId
           ,1
           ,1200
           ,1
		   ,@id output

PRINT N'Add packages...';

set @date = dateadd(day, -ABS(CHECKSUM(NewId())) % 100, getdate())
set @date2 = dateadd(day, ABS(CHECKSUM(NewId())) % 100, getdate())
EXECUTE [crm].[AddPackage] 
           @organizationId
           ,@priceItemId
           ,@date
           ,@date2
           ,1
		   ,@id output

PRINT N'Add permissions...';

set @serviceId = (select min(id) from @services)
EXECUTE [site].[AddPermission] 
           @employeeId
           ,@serviceId
           ,1
		   ,@id output


PRINT N'Add users...';

EXECUTE [site].[AddUser] 
			N'Муровая'
           ,N'Анна'
           ,N'Петровна'
           ,N'9223235223'
           ,N'anna_n@gmail.com'
           ,0
		   ,@userId output

PRINT N'Add employees...';

EXECUTE [site].[AddEmployee] 
           @organizationId
           ,@userId
           ,N'Бухгалтер'
           ,0
           ,2
		   ,@employeeId output


GO

