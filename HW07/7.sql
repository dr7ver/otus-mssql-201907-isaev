/* 1. Требуется написать запрос, который в результате своего выполнения формирует таблицу следующего вида:
Название клиента
МесяцГод Количество покупок

Клиентов взять с ID 2-6, это все подразделение Tailspin Toys
имя клиента нужно поменять так чтобы осталось только уточнение
например исходное Tailspin Toys (Gasport, NY) - вы выводите в имени только Gasport,NY
дата должна иметь формат dd.mm.yyyy например 25.12.2019

Например, как должны выглядеть результаты:
InvoiceMonth Peeples Valley, AZ Medicine Lodge, KS Gasport, NY Sylvanite, MT Jessie, ND
01.01.2013 3 1 4 2 2
01.02.2013 7 3 4 2 1 */

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


/* 2. Для всех клиентов с именем, в котором есть Tailspin Toys
вывести все адреса, которые есть в таблице, в одной колонке

Пример результатов
CustomerName AddressLine
Tailspin Toys (Head Office) Shop 38
Tailspin Toys (Head Office) 1877 Mittal Road
Tailspin Toys (Head Office) PO Box 8975
Tailspin Toys (Head Office) Ribeiroville
.....*/

;with customers_CTE as (
	select 
		c.CustomerName,
		c.DeliveryAddressLine1,
		c.DeliveryAddressLine2,
		c.PostalAddressLine1,
		c.PostalAddressLine2
	from Sales.Customers as c
	where c.CustomerName like '%Tailspin Toys%'
)
select 
	CustomerName,
	AddressLine
from customers_CTE as cte
unpivot (
	AddressLine for AddressType in (DeliveryAddressLine1, DeliveryAddressLine2, PostalAddressLine1, PostalAddressLine2)
) as unp

/* 3. В таблице стран есть поля с кодом страны цифровым и буквенным
сделайте выборку ИД страны, название, код - чтобы в поле был либо цифровой либо буквенный код
Пример выдачи

CountryId CountryName Code
1 Afghanistan AFG
1 Afghanistan 4
3 Albania ALB
3 Albania 8 */

;with countries_CTE as (
	select 
		c.CountryID,
		c.CountryName,
		c.IsoAlpha3Code,
		cast(c.IsoNumericCode as nvarchar(3)) as IsoNumericCode
	from Application.Countries as c
)
select 
	CountryID,
	CountryName,
	Code
from countries_CTE as c
unpivot (
	Code for CodeType in (IsoAlpha3Code, IsoNumericCode)
) as unp


/* 4. Перепишите ДЗ из оконных функций через CROSS APPLY
Выберите по каждому клиенту 2 самых дорогих товара, которые он покупал
В результатах должно быть ид клиета, его название, ид товара, цена, дата покупки */

select 
	c.CustomerID,
	c.CustomerName,
	cr.StockItemID,
	cr.UnitPrice,
	cr.InvoiceDate	
from Sales.Customers as c
cross apply (
	select top 2
		i.InvoiceDate,
		il.UnitPrice,
		il.StockItemID
	from Sales.Invoices as i
	join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
	where i.CustomerID = c.CustomerID
	order by il.UnitPrice desc
) as cr
order by c.CustomerID, cr.UnitPrice desc

