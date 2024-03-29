/* 1. Все товары, в которых в название есть пометка urgent или название начинается с Animal*/

SELECT *
FROM [WideWorldImporters].[Warehouse].[StockItems] as i
where i.StockItemName like '%urgent%' or i.StockItemName like 'Animal%'


/* 2. Поставщиков, у которых не было сделано ни одного заказа (потом покажем как это делать через подзапрос, сейчас сделайте через JOIN)*/

select *
from [WideWorldImporters].Purchasing.Suppliers s
	left join WideWorldImporters.Purchasing.PurchaseOrders p on s.SupplierID = p.SupplierID
where p.PurchaseOrderID is null


/* 3. Продажи с названием месяца, в котором была продажа, номером квартала, к которому относится продажа, 
 включите также к какой трети года относится дата - каждая треть по 4 месяца, дата забора заказа должна быть задана, 
 с ценой товара более 100$ либо количество единиц товара более 20. 
 Добавьте вариант этого запроса с постраничной выборкой пропустив первую 1000 и отобразив следующие 100 записей. 
 Соритровка должна быть по номеру квартала, трети года, дате продажи. */

select 
	s.InvoiceID, 
	s.InvoiceDate, 
	DATENAME(mm,s.InvoiceDate) AS MonthName,
	DATEPART(qq,s.InvoiceDate) AS Quater,
	CEILING(MONTH(s.InvoiceDate)/4.0) as ThirdYear
from [WideWorldImporters].Sales.Invoices s
	inner join [WideWorldImporters].Sales.InvoiceLines l on s.InvoiceID = l.InvoiceID
where s.ConfirmedDeliveryTime is not null and (l.UnitPrice > 100 or l.Quantity > 20)
group by s.InvoiceID, s.InvoiceDate
order by Quater, ThirdYear, s.InvoiceDate

/* Вариант запроса с постраничной выборкой*/

select 
	s.InvoiceID, 
	s.InvoiceDate, 
	DATENAME(mm,s.InvoiceDate) AS MonthName,
	DATEPART(qq,s.InvoiceDate) AS Quater,
	CEILING(MONTH(s.InvoiceDate)/4.0) as ThirdYear
from [WideWorldImporters].Sales.Invoices s
	left join [WideWorldImporters].Sales.InvoiceLines l on s.InvoiceID = l.InvoiceID
where s.ConfirmedDeliveryTime is not null and (l.UnitPrice > 100 or l.Quantity > 20)
group by s.InvoiceID, s.InvoiceDate
order by Quater, ThirdYear, s.InvoiceDate
OFFSET 1000 ROWS FETCH FIRST 100 ROWS ONLY


/* 4. Заказы поставщикам, которые были исполнены за 2014й год с доставкой Road Freight или Post,
 добавьте название поставщика, имя контактного лица принимавшего заказ*/

select 
	o.PurchaseOrderID,
	s.SupplierName,
	p.FullName
from [Purchasing].PurchaseOrders as o
	inner join [Purchasing].Suppliers as s on o.SupplierID = s.SupplierID
	inner join [Application].People as p on o.ContactPersonID = p.PersonID
	inner join [Application].DeliveryMethods as d on o.DeliveryMethodID = d.DeliveryMethodID
where year(o.OrderDate) = 2014 and d.DeliveryMethodName in ('Road Freight', 'Post')


/* 5. 10 последних по дате продаж с именем клиента и именем сотрудника, который оформил заказ.*/

select top(10) 
	i.InvoiceID, 
	i.InvoiceDate, 
	c.CustomerName, 
	p.FullName
from [Sales].Invoices as i
	inner join [Sales].Customers as c on i.CustomerID = c.CustomerID
	inner join [Application].People as p on i.ContactPersonID = p.PersonID
order by i.InvoiceDate desc


/* 6. Все ид и имена клиентов и их контактные телефоны, которые покупали товар Chocolate frogs 250g*/

select DISTINCT
	c.CustomerID,
	c.CustomerName,
	c.PhoneNumber
from [Sales].Invoices as i
	inner join [Sales].Customers as c on i.CustomerID = c.CustomerID
	inner join [Sales].InvoiceLines as l on i.InvoiceID = l.InvoiceID
	inner join [Warehouse].StockItems as si on l.StockItemID = si.StockItemID
where si.StockItemName = 'Chocolate frogs 250g'