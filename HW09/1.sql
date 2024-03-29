/* 1. Загрузить данные из файла StockItems.xml в таблицу StockItems.
Существующие записи в таблице обновить, отсутствующие добавить (искать по StockItemName).
Файл StockItems.xml в личном кабинете.*/

begin tran

drop table if exists #loadedStockItems

declare @stockItemsXml xml
declare @handle int
create table #loadedStockItems (
	StockItemName nvarchar (100),
	SupplierID int,
	UnitPackageID int,
	OuterPackageID int,
	QuantityPerOuter int,
	TypicalWeightPerUnit decimal (18, 3),
	LeadTimeDays int,
	IsChillerStock bit,
	TaxRate decimal (18, 3),
	UnitPrice decimal (18, 2)
)

set @stockItemsXml =
(
	select *
    from OpenRowSet(
		Bulk 'c:\Repos\otus-mssql-201907-isaev\HW09\StockItems-188-f89807.xml', 
		Single_blob
	) as x
);

exec sp_xml_preparedocument @handle output, @stockItemsXml

insert into #loadedStockItems
select * 
from openxml(@handle, '/StockItems/Item', 2)
with (
	StockItemName nvarchar (100) '@Name',
	SupplierID int 'SupplierID',
	UnitPackageID int 'Package/UnitPackageID',
	OuterPackageID int 'Package/OuterPackageID',
	QuantityPerOuter int 'Package/QuantityPerOuter',
	TypicalWeightPerUnit decimal (18, 3) 'Package/TypicalWeightPerUnit',
	LeadTimeDays int 'LeadTimeDays',
	IsChillerStock bit 'IsChillerStock',
	TaxRate decimal (18, 3) 'TaxRate',
	UnitPrice decimal (18, 2) 'UnitPrice'
)


merge warehouse.StockItems as t
	using #loadedStockItems as l
on t.[StockItemName] = l.[StockItemName] COLLATE Latin1_General_CS_AS
when matched
	then update
	set t.[SupplierID] = l.[SupplierID],
		t.[UnitPackageID] = l.[UnitPackageID],
		t.[OuterPackageID] = l.[OuterPackageID],
		t.[LeadTimeDays] = l.[LeadTimeDays],
		t.[QuantityPerOuter] = l.[QuantityPerOuter],
		t.[IsChillerStock] = l.[IsChillerStock],
		t.[TaxRate] = l.[TaxRate],
		t.[UnitPrice] = l.[UnitPrice],
		t.[TypicalWeightPerUnit] = l.[TypicalWeightPerUnit]
when not matched
	then insert (
		[StockItemName],
		[SupplierID],
		[UnitPackageID],
		[OuterPackageID],
		[LeadTimeDays],
		[QuantityPerOuter],
		[IsChillerStock],
		[TaxRate],
		[UnitPrice],
		[TypicalWeightPerUnit],
		[LastEditedBy]
	)
    VALUES (
		l.[StockItemName],
		l.[SupplierID],
		l.[UnitPackageID],
		l.[OuterPackageID],
		l.[LeadTimeDays],
		l.[QuantityPerOuter],
		l.[IsChillerStock],
		l.[TaxRate],
		l.[UnitPrice],
		l.[TypicalWeightPerUnit],
		1
	)
output deleted.*, $action, inserted.*;

rollback tran

/* 2. Выгрузить данные из таблицы StockItems в такой же xml-файл, как StockItems.xml */

declare @xmlString nvarchar(max)
declare @command nvarchar(4000)

set @xmlString = '\
select s.StockItemName as ''@Name'', \
	s.SupplierID, \
	s.UnitPackageID as ''Package/UnitPackageID'', \
	s.OuterPackageID as ''Package/OuterPackageID'', \
	s.QuantityPerOuter as ''Package/QuantityPerOuter'', \
	s.TypicalWeightPerUnit as ''Package/TypicalWeightPerUnit'', \
	s.LeadTimeDays, \
	s.IsChillerStock, \
	s.TaxRate, \
	s.UnitPrice \
from Warehouse.StockItems s for xml path(''Item''), type, elements, root(''StockItems'')'

set @command = 'bcp "' + @xmlString + '" queryout "c:\Repos\otus-mssql-201907-isaev\HW09\StockItems-my.xml" -T -S ' + @@SERVERNAME + ' -d WideWorldImporters -w'

EXEC master..xp_cmdshell @command;

/* 3. В таблице StockItems в колонке CustomFields есть данные в json.
Написать select для вывода:
- StockItemID
- StockItemName
- CountryOfManufacture (из CustomFields)
- Range (из CustomFields) */ 

select s.StockItemID,
	s.StockItemName,
	json_value(s.CustomFields, '$.CountryOfManufacture') as CountryOfManufacture,
	json_value(s.CustomFields, '$.Range') as Range
from Warehouse.StockItems as s

/* 4. Найти в StockItems строки, где есть тэг "Vintage"
Запрос написать через функции работы с JSON.
Тэги искать в поле CustomFields, а не в поле Tags.
Для поиска использовать равенство, использовать LIKE запрещено.
Запрос должен быть примерно в таком виде:
SELECT ... WHERE ... = 'Vintage' */

select 
	s.StockItemID,
	s.CustomFields
from Warehouse.StockItems s
cross apply openjson(s.CustomFields, '$.Tags')
where [value] ='Vintage'

/* 5. Пишем динамический PIVOT.
По заданию из 8го занятия про CROSS APPLY и PIVOT
Требуется написать запрос, который в результате своего выполнения формирует таблицу следующего вида:
Название клиента
МесяцГод Количество покупок

Нужно написать запрос, который будет генерировать результаты для всех клиентов
имя клиента указывать полностью из CustomerName
дата должна иметь формат dd.mm.yyyy например 25.12.2019 */

-- статический pivot

with invoices_CTE as (
	select 
		i.InvoiceID,
		replace(replace(c.CustomerName, 'Tailspin Toys (', ''), ')','') AS CustomerName,
		dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as InvoiceMonth
	from Sales.Invoices as i
	join Sales.Customers as c on i.CustomerID = c.CustomerID
	where c.CustomerID between 2 and 6
)
select 
	format(InvoiceMonth, 'dd.MM.yyyy') AS InvoiceMonth,
	[Peeples Valley, AZ], 
	[Medicine Lodge, KS], 
	[Gasport, NY], 
	[Sylvanite, MT], 
	[Jessie, ND]
from invoices_CTE
pivot (
	count(InvoiceID)
	for CustomerName IN ([Peeples Valley, AZ], [Medicine Lodge, KS], [Gasport, NY], [Sylvanite, MT], [Jessie, ND])
) as pvt

-- динамический pivot

declare @columns nvarchar(max)

set @columns= stuff(
	(select N','+QUOTENAME(CustomerName) as [text()]
	from sales.Customers
	group by CustomerName
	order by CustomerName
	for xml path(''), type).value('.[1]','nvarchar(max)'),1,1,'');
--select @columns

declare @sql nvarchar(max) = N'with invoices_CTE as (
	select 
		i.InvoiceID,
		c.CustomerName,
		dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as InvoiceMonth
	from Sales.Invoices as i
	join Sales.Customers as c on i.CustomerID = c.CustomerID
)
select *
from invoices_CTE
pivot (
	count(InvoiceID)
	for CustomerName IN (' + @columns + ')
) as pvt;';
--select @sql;

exec (@sql);

