/* Для всех заданий где возможно, сделайте 2 варианта запросов:
	1) через вложенный запрос
	2) через WITH (для производных таблиц)*/

/* 1. Выберите сотрудников, которые являются продажниками, и еще не сделали ни одной продажи.*/

--через вложенный запрос
select * 
from Application.People as p
where p.IsSalesperson = 1 and p.PersonID not in (
	select distinct i.SalespersonPersonID
	from Sales.Invoices as i
);

--через WITH
with salesperson_CTE as (
	select distinct i.SalespersonPersonID
	from Sales.Invoices as i
)
select * 
from Application.People as p
where p.IsSalesperson = 1 and p.PersonID not in (
	select SalespersonPersonID from salesperson_CTE
)

/* 2. Выберите товары с минимальной ценой (подзапросом), 2 варианта подзапроса. */

--через вложенный запрос (Вариант 1)
select * 
from Warehouse.StockItems as i
where i.UnitPrice = (
	select min(i2.UnitPrice) 
	from Warehouse.StockItems as i2
)

--через вложенный запрос (Вариант 2)
select * 
from Warehouse.StockItems as i
where i.UnitPrice <= all (
	select i2.UnitPrice
	from Warehouse.StockItems as i2
);

--через WITH 
with minPrice_CTE as (
	select min(i.UnitPrice) as MinPrice
	from Warehouse.StockItems as i
)
select * 
from Warehouse.StockItems as i
where i.UnitPrice in (
	select MinPrice from minPrice_CTE
)

/* 3. Выберите информацию по клиентам, которые перевели компании 5 максимальных платежей из [Sales].[CustomerTransactions] 
	представьте 3 способа (в том числе с CTE)*/

--через вложенный запрос (Вариант 1)
select * 
from Sales.Customers as c
where c.CustomerID in (
	select top(5) t.CustomerID
	from Sales.CustomerTransactions as t 
	order by t.TransactionAmount desc
);

--через вложенный запрос (Вариант 2)
select * 
from Sales.Customers as c
join (
		select top(5) t.CustomerID
		from Sales.CustomerTransactions as t 
		order by t.TransactionAmount desc
	) as temp
	on temp.CustomerID = c.CustomerID;

--через WITH 
with maxAmount_CTE as (
	select top(5) t.CustomerID
	from Sales.CustomerTransactions as t 
	order by t.TransactionAmount desc
)
select * 
from Sales.Customers as c
where c.CustomerID in (
	select * from maxAmount_CTE
);

/* 4. Выберите города (ид и название), в которые были доставлены товары, входящие в тройку самых дорогих товаров,
	а также Имя сотрудника, который осуществлял упаковку заказов */

--через вложенный запрос
select c.CityID,
	c.CityName,
	p.FullName
from Application.Cities as c
join Sales.Customers as cu on c.CityID = cu.DeliveryCityID
join Sales.Invoices as i on cu.CustomerID = i.CustomerID
join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
join Warehouse.StockItems as si on il.StockItemID = si.StockItemID
join Application.People as p on i.PackedByPersonID = p.PersonID
where si.StockItemID in (
	select top(3) si2.StockItemID 
	from Warehouse.StockItems as si2
	order by si2.UnitPrice desc
);

--через WITH 
with topCost_CTE as (
	select top(3) si2.StockItemID 
	from Warehouse.StockItems as si2
	order by si2.UnitPrice desc
)
select c.CityID,
	c.CityName,
	p.FullName
from Application.Cities as c
join Sales.Customers as cu on c.CityID = cu.DeliveryCityID
join Sales.Invoices as i on cu.CustomerID = i.CustomerID
join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
join Warehouse.StockItems as si on il.StockItemID = si.StockItemID
join Application.People as p on i.PackedByPersonID = p.PersonID
where si.StockItemID in (
	select * from topCost_CTE
);


/* 5. Объясните, что делает и оптимизируйте запрос. 
	Приложите план запроса и его анализ, а также ход ваших рассуждений по поводу оптимизации. 
	Можно двигаться как в сторону улучшения читабельности запроса (что уже было в материале лекций), так и в сторону упрощения плана\ускорения.*/

SELECT 
	Invoices.InvoiceID, 
	Invoices.InvoiceDate,
	(
		SELECT People.FullName
		FROM Application.People
		WHERE People.PersonID = Invoices.SalespersonPersonID
	) AS SalesPersonName,
	SalesTotals.TotalSumm AS TotalSummByInvoice, 
	(
		SELECT SUM(OrderLines.PickedQuantity*OrderLines.UnitPrice)
		FROM Sales.OrderLines
		WHERE OrderLines.OrderId = (
			SELECT Orders.OrderId 
			FROM Sales.Orders
			WHERE Orders.PickingCompletedWhen IS NOT NULL	
					AND Orders.OrderId = Invoices.OrderId
		)
	) AS TotalSummForPickedItems
FROM Sales.Invoices 
JOIN (
	SELECT InvoiceId, SUM(Quantity*UnitPrice) AS TotalSumm
	FROM Sales.InvoiceLines
	GROUP BY InvoiceId
	HAVING SUM(Quantity*UnitPrice) > 27000
) AS SalesTotals
ON Invoices.InvoiceID = SalesTotals.InvoiceID
ORDER BY TotalSumm DESC;

/* Запрос выводит информацию по счетам, в которых общая стоимость товаров больше 27000. 
Для таких счетов также выводится ФИО менеджера по продажам и общая стоимость товаров согласно заказу, связанному с этим счетом. И этот заказ должен быть упакован

В запросе присутствуют 2 зависимых запроса: для поиска ФИО менеджера и для поиска общей стоимости товаров в заказе.
Также есть подзапрос в join, который ухудшает читабельность.
Подзапрос в join и зависимый подзапрос к заказам вынесем в CTE.
Подзапрос к персонам переделаем на join

original.sqlplan - план исходного запроса
optimized.sqlplan - план оптимизированного запроса
*/

with invoice_CTE as (
	select il.InvoiceId,
		sum(il.Quantity*il.UnitPrice) AS TotalSumm
	from Sales.InvoiceLines as il
	group by il.InvoiceId
	having sum(il.Quantity*il.UnitPrice) > 27000
),
orders_CTE as (
	select ol.OrderID,
		sum(ol.PickedQuantity*ol.UnitPrice) as TotalSumm
	from Sales.OrderLines as ol
	group by ol.OrderID
)
select ic.InvoiceID,
	i.InvoiceDate,
	p.FullName as SalesPersonName,
	ic.TotalSumm as TotalSummByInvoice,
	oc.TotalSumm as TotalSummForPickedItems
from invoice_CTE as ic
join Sales.Invoices as i on ic.InvoiceID = i.InvoiceID
join Sales.Orders as o on i.OrderID = o.OrderID
join orders_CTE as oc on i.OrderID = oc.OrderID
join Application.People as p on i.SalespersonPersonID = p.PersonID
where o.PickingCompletedWhen IS NOT NULL
order by ic.TotalSumm desc;

