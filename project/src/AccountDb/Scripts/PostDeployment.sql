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

PRINT N'Run PostDeployment...';

IF EXISTS (SELECT 1 FROM orgs.Permissions)
BEGIN
	PRINT N'Database already seed...';
	return
END

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

