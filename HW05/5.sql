/* 1. Довставлять в базу 5 записей используя insert в таблицу Customers или Suppliers */

declare @firstId int = next value for sequences.CustomerId;
declare @secondId int = next value for sequences.CustomerId;
declare @thirdId int = next value for sequences.CustomerId;
declare @fourthId int = next value for sequences.CustomerId;
declare @fifthId int = next value for sequences.CustomerId;

insert into [Sales].[Customers]
           ([CustomerID]
           ,[CustomerName]
           ,[BillToCustomerID]
           ,[CustomerCategoryID]
           ,[BuyingGroupID]
           ,[PrimaryContactPersonID]
           ,[AlternateContactPersonID]
           ,[DeliveryMethodID]
           ,[DeliveryCityID]
           ,[PostalCityID]
           ,[CreditLimit]
           ,[AccountOpenedDate]
           ,[StandardDiscountPercentage]
           ,[IsStatementSent]
           ,[IsOnCreditHold]
           ,[PaymentDays]
           ,[PhoneNumber]
           ,[FaxNumber]
           ,[DeliveryRun]
           ,[RunPosition]
           ,[WebsiteURL]
           ,[DeliveryAddressLine1]
           ,[DeliveryAddressLine2]
           ,[DeliveryPostalCode]
           ,[DeliveryLocation]
           ,[PostalAddressLine1]
           ,[PostalAddressLine2]
           ,[PostalPostalCode]
           ,[LastEditedBy])
	output inserted.*
    values
           (@firstId,N'First customer 4',823,6,null,3022,null,3,32358,32358,null,'2019-01-01',0,0,0,7,'(201) 234-0100','(233) 234-2342',null,null,'https://ya.ru','Suite 13',null,'90789',null,'PO Box 3456',null,'35636',1),
           (@secondId,N'Second customer 4',917,7,null,2018,null,3,5304,5304,null,'2019-01-21',0,0,0,7,'(211) 234-6232','(623) 634-2363',null,null,'https://rg.ru','Unit 63',null,'32453',null,'PO Box 7345',null,'23235',1),
           (@thirdId,N'Third customer 4',1033,3,null,3022,null,3,17742,2203,null,'2019-01-03',0,0,0,7,'(241) 362-6236','(234) 346-3453',null,null,'https://o2.ru','Suite 23',null,'45644',null,'PO Box 3456',null,'42342',1),
           (@fourthId,N'Fourth customer 4',401,5,null,2159,null,3,2425,2425,null,'2019-01-04',0,0,0,7,'(231) 234-6236','(262) 343-7345',null,null,'https://good.ru','Suite 123',null,'66574',null,'PO Box 4784',null,'34564',1),
           (@fifthId,N'Fifth customer 4',401,6,null,3022,null,3,11597,11597,null,'2019-01-05',0,0,0,7,'(435) 623-6234','(344) 363-7435',null,null,'https://hi.ru','Suite 63',null,'45456',null,'PO Box 34573',null,'64564',1)



/* 2. удалите 1 запись из Customers, которая была вами добавлена */

delete from Sales.Customers 
output deleted.*
where CustomerId = @secondId;


/* 3. изменить одну запись, из добавленных через UPDATE */

update Sales.Customers 
set FaxNumber = '(262) 111-1111'
output inserted.*, deleted.*
where CustomerId = @thirdId

/* 4. Написать MERGE, который вставит запись в клиенты, если ее там нет, и изменит если она уже есть */

drop table if exists #customerStaging

create table #customerStaging (
	[CustomerID] [int] NOT NULL,
	[CustomerName] [nvarchar](100) NOT NULL,
	[BillToCustomerID] [int] NOT NULL,
	[CustomerCategoryID] [int] NOT NULL,
	[BuyingGroupID] [int] NULL,
	[PrimaryContactPersonID] [int] NOT NULL,
	[AlternateContactPersonID] [int] NULL,
	[DeliveryMethodID] [int] NOT NULL,
	[DeliveryCityID] [int] NOT NULL,
	[PostalCityID] [int] NOT NULL,
	[CreditLimit] [decimal](18, 2) NULL,
	[AccountOpenedDate] [date] NOT NULL,
	[StandardDiscountPercentage] [decimal](18, 3) NOT NULL,
	[IsStatementSent] [bit] NOT NULL,
	[IsOnCreditHold] [bit] NOT NULL,
	[PaymentDays] [int] NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[FaxNumber] [nvarchar](20) NOT NULL,
	[DeliveryRun] [nvarchar](5) NULL,
	[RunPosition] [nvarchar](5) NULL,
	[WebsiteURL] [nvarchar](256) NOT NULL,
	[DeliveryAddressLine1] [nvarchar](60) NOT NULL,
	[DeliveryAddressLine2] [nvarchar](60) NULL,
	[DeliveryPostalCode] [nvarchar](10) NOT NULL,
	[DeliveryLocation] [geography] NULL,
	[PostalAddressLine1] [nvarchar](60) NOT NULL,
	[PostalAddressLine2] [nvarchar](60) NULL,
	[PostalPostalCode] [nvarchar](10) NOT NULL,
	[LastEditedBy] [int] NOT NULL)

insert into  #customerStaging
           ([CustomerID]
           ,[CustomerName]
           ,[BillToCustomerID]
           ,[CustomerCategoryID]
           ,[BuyingGroupID]
           ,[PrimaryContactPersonID]
           ,[AlternateContactPersonID]
           ,[DeliveryMethodID]
           ,[DeliveryCityID]
           ,[PostalCityID]
           ,[CreditLimit]
           ,[AccountOpenedDate]
           ,[StandardDiscountPercentage]
           ,[IsStatementSent]
           ,[IsOnCreditHold]
           ,[PaymentDays]
           ,[PhoneNumber]
           ,[FaxNumber]
           ,[DeliveryRun]
           ,[RunPosition]
           ,[WebsiteURL]
           ,[DeliveryAddressLine1]
           ,[DeliveryAddressLine2]
           ,[DeliveryPostalCode]
           ,[DeliveryLocation]
           ,[PostalAddressLine1]
           ,[PostalAddressLine2]
           ,[PostalPostalCode]
           ,[LastEditedBy])
	output inserted.*
    values
           (@firstId,N'First customer modified',823,6,null,3022,null,3,32358,32358,null,'2019-02-01',0,0,0,7,'(999) 234-0100','(233) 234-2342',null,null,'https://ya.ru','Suite 13',null,'90789',null,'PO Box 3456',null,'35636',1),
           (@secondId,N'Second customer modified',917,7,null,2018,null,3,5304,5304,null,'2019-02-21',0,0,0,7,'(999) 234-6232','(623) 634-2363',null,null,'https://rg.ru','Unit 63',null,'32453',null,'PO Box 7345',null,'23235',1),
           (@thirdId,N'Third customer modified',1033,3,null,3022,null,3,17742,2203,null,'2019-02-03',0,0,0,7,'(999) 362-6236','(234) 346-3453',null,null,'https://o2.ru','Suite 23',null,'45644',null,'PO Box 3456',null,'42342',1),
		   (@fourthId,N'Fourth customer modified',401,5,null,2159,null,3,2425,2425,null,'2019-02-04',0,0,0,7,'(999) 234-6236','(262) 343-7345',null,null,'https://good.ru','Suite 123',null,'66574',null,'PO Box 4784',null,'34564',1),
           (@fifthId,N'Fifth customer modified',401,6,null,3022,null,3,11597,11597,null,'2019-02-05',0,0,0,7,'(999) 623-6234','(344) 363-7435',null,null,'https://hi.ru','Suite 63',null,'45456',null,'PO Box 34573',null,'64564',1)


merge Sales.Customers as t
	using #customerStaging as s
on t.CustomerId = s.CustomerId
when matched
	then update 
	set t.[CustomerName] = s.[CustomerName],
		t.[BillToCustomerID] = s.[BillToCustomerID],
		t.[CustomerCategoryID] = s.[CustomerCategoryID],
		t.[BuyingGroupID] = s.[BuyingGroupID],
		t.[PrimaryContactPersonID] = s.[PrimaryContactPersonID],
		t.[AlternateContactPersonID] = s.[AlternateContactPersonID],
		t.[DeliveryMethodID] = s.[DeliveryMethodID],
		t.[DeliveryCityID] = s.[DeliveryCityID],
		t.[PostalCityID] = s.[PostalCityID],
		t.[CreditLimit] = s.[CreditLimit],
		t.[AccountOpenedDate] = s.[AccountOpenedDate],
		t.[StandardDiscountPercentage] = s.[StandardDiscountPercentage],
		t.[IsStatementSent] = s.[IsStatementSent],
		t.[IsOnCreditHold] = s.[IsOnCreditHold],
		t.[PaymentDays] = s.[PaymentDays],
		t.[PhoneNumber] = s.[PhoneNumber],
		t.[FaxNumber] = s.[FaxNumber],
		t.[DeliveryRun] = s.[DeliveryRun],
		t.[RunPosition] = s.[RunPosition],
		t.[WebsiteURL] = s.[WebsiteURL],
		t.[DeliveryAddressLine1] = s.[DeliveryAddressLine1],
		t.[DeliveryAddressLine2] = s.[DeliveryAddressLine2],
		t.[DeliveryPostalCode] = s.[DeliveryPostalCode],
		t.[DeliveryLocation] = s.[DeliveryLocation],
		t.[PostalAddressLine1] = s.[PostalAddressLine1],
		t.[PostalAddressLine2] = s.[PostalAddressLine2],
		t.[PostalPostalCode] = s.[PostalPostalCode],
		t.[LastEditedBy] = s.[LastEditedBy]
when not matched
	then insert ([CustomerID]
           ,[CustomerName]
           ,[BillToCustomerID]
           ,[CustomerCategoryID]
           ,[BuyingGroupID]
           ,[PrimaryContactPersonID]
           ,[AlternateContactPersonID]
           ,[DeliveryMethodID]
           ,[DeliveryCityID]
           ,[PostalCityID]
           ,[CreditLimit]
           ,[AccountOpenedDate]
           ,[StandardDiscountPercentage]
           ,[IsStatementSent]
           ,[IsOnCreditHold]
           ,[PaymentDays]
           ,[PhoneNumber]
           ,[FaxNumber]
           ,[DeliveryRun]
           ,[RunPosition]
           ,[WebsiteURL]
           ,[DeliveryAddressLine1]
           ,[DeliveryAddressLine2]
           ,[DeliveryPostalCode]
           ,[DeliveryLocation]
           ,[PostalAddressLine1]
           ,[PostalAddressLine2]
           ,[PostalPostalCode]
           ,[LastEditedBy])
		values(s.[CustomerID]
           ,s.[CustomerName]
           ,s.[BillToCustomerID]
           ,s.[CustomerCategoryID]
           ,s.[BuyingGroupID]
           ,s.[PrimaryContactPersonID]
           ,s.[AlternateContactPersonID]
           ,s.[DeliveryMethodID]
           ,s.[DeliveryCityID]
           ,s.[PostalCityID]
           ,s.[CreditLimit]
           ,s.[AccountOpenedDate]
           ,s.[StandardDiscountPercentage]
           ,s.[IsStatementSent]
           ,s.[IsOnCreditHold]
           ,s.[PaymentDays]
           ,s.[PhoneNumber]
           ,s.[FaxNumber]
           ,s.[DeliveryRun]
           ,s.[RunPosition]
           ,s.[WebsiteURL]
           ,s.[DeliveryAddressLine1]
           ,s.[DeliveryAddressLine2]
           ,s.[DeliveryPostalCode]
           ,s.[DeliveryLocation]
           ,s.[PostalAddressLine1]
           ,s.[PostalAddressLine2]
           ,s.[PostalPostalCode]
           ,s.[LastEditedBy])
output deleted.*, $action, inserted.*;


/* 5. Напишите запрос, который выгрузит данные через bcp out и загрузить через bulk insert */

-- To allow advanced options to be changed.  
EXEC sp_configure 'show advanced options', 1;  
GO  
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO  
-- To enable the feature.  
EXEC sp_configure 'xp_cmdshell', 1;  
GO  
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO  

declare @path nvarchar(200),
@query nvarchar(1000);
set @path = 'c:\tmp\InvoiceLines.txt';

-- bcp out
set @query = 'bcp "[WideWorldImporters].Sales.InvoiceLines" out  "' + @path + '" -T -w -t"@eu&$1&" -S ' + @@SERVERNAME;

exec master..xp_cmdshell @query

-- bulk insert
drop table if exists #invoceLinesStaging

create table #invoceLinesStaging(
	[InvoiceLineID] [int] NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[StockItemID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[PackageTypeID] [int] NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[TaxRate] [decimal](18, 3) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[LineProfit] [decimal](18, 2) NOT NULL,
	[ExtendedPrice] [decimal](18, 2) NOT NULL,
	[LastEditedBy] [int] NOT NULL,
	[LastEditedWhen] [datetime2](7) NOT NULL
) 

set @query = 'bulk insert #invoceLinesStaging
from "' + @path + '"
with (
	batchsize = 1000, 
	datafiletype = ''widechar'',
	fieldterminator = ''@eu&$1&'',
	rowterminator =''\n'',
	keepnulls,
	tablock 
)';

select @query;

exec sp_executesql @query;
select * from #invoceLinesStaging

