/* 1. Напишите запрос с временной таблицей и перепишите его с табличной переменной. Сравните планы.
В качестве запроса с временной таблицей и табличной переменной можно взять свой запрос или следующий запрос:
Сделать расчет суммы продаж нарастающим итогом по месяцам с 2015 года 
(в рамках одного месяца он будет одинаковый, нарастать будет в течение времени выборки)
Выведите id продажи, название клиента, дату продажи, сумму продажи, сумму нарастающим итогом
Пример
Дата продажи Нарастающий итог по месяцу
2015-01-29 4801725.31
2015-01-30 4801725.31
2015-01-31 4801725.31
2015-02-01 9626342.98
2015-02-02 9626342.98
2015-02-03 9626342.98
Продажи можно взять из таблицы Invoices.
Нарастающий итог должен быть без оконной функции. */

set statistics io, time on;

-- С временной таблицей
drop table if exists #InvoicesTable

select 
	i.InvoiceID,
	dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as Month,
	sum(il.Quantity*il.UnitPrice) as InvoicePrice
into #InvoicesTable
from Sales.Invoices as i
join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
where i.InvoiceDate >= '2015-01-01'
group by i.InvoiceID, i.InvoiceDate

select 
	t.InvoiceID,
	c.CustomerName,
	i.InvoiceDate,
	t.InvoicePrice,
	(
		select sum(t2.InvoicePrice)
		from #InvoicesTable as t2
		where t2.Month <= t.Month
	) as CumulativePrice
from #InvoicesTable as t
join Sales.Invoices as i on i.InvoiceID = t.InvoiceID
join Sales.Customers as c on i.CustomerID = c.CustomerID
order by i.InvoiceID
go

-- План в temporaryTable.sqlplan

-- Статистика
-- SQL Server Execution Times:
--   CPU time = 0 ms,  elapsed time = 0 ms.
--SQL Server parse and compile time: 
--   CPU time = 38 ms, elapsed time = 38 ms.

-- SQL Server Execution Times:
--   CPU time = 0 ms,  elapsed time = 0 ms.

-- SQL Server Execution Times:
--   CPU time = 0 ms,  elapsed time = 1 ms.
--Table 'InvoiceLines'. Scan count 8, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 322, lob physical reads 0, lob read-ahead reads 0.
--Table 'InvoiceLines'. Segment reads 1, segment skipped 0.
--Table 'Invoices'. Scan count 5, logical reads 11994, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

--(31440 rows affected)

--(1 row affected)

-- SQL Server Execution Times:
--   CPU time = 107 ms,  elapsed time = 58 ms.
--SQL Server parse and compile time: 
--   CPU time = 44 ms, elapsed time = 44 ms.

--(31440 rows affected)
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table '#InvoicesTable______________________________________________________________________________________________________000000000008'. Scan count 18, logical reads 2718, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Invoices'. Scan count 1, logical reads 11400, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Customers'. Scan count 1, logical reads 41, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

--(1 row affected)

-- SQL Server Execution Times:
--   CPU time = 188 ms,  elapsed time = 579 ms.
--SQL Server parse and compile time: 
--   CPU time = 0 ms, elapsed time = 0 ms.


-- С табличной переменной
declare @InvoicesVariable table (
	InvoiceID int,
	Month date,
	InvoicePrice decimal(18,2)
)

insert into @InvoicesVariable
select 
	i.InvoiceID,
	dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as Month,
	sum(il.Quantity*il.UnitPrice) as InvoicePrice
from Sales.Invoices as i
join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
where i.InvoiceDate >= '2015-01-01'
group by i.InvoiceID, i.InvoiceDate

select 
	t.InvoiceID,
	c.CustomerName,
	i.InvoiceDate,
	t.InvoicePrice,
	(
		select sum(t2.InvoicePrice)
		from @InvoicesVariable as t2
		where t2.Month <= t.Month
	) as CumulativePrice
from @InvoicesVariable as t
join Sales.Invoices as i on i.InvoiceID = t.InvoiceID
join Sales.Customers as c on i.CustomerID = c.CustomerID
order by i.InvoiceID
go

-- План в tableVariable.sqlplan

-- Статистика
--(31440 rows affected)
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Customers'. Scan count 1, logical reads 41, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Worktable'. Scan count 1, logical reads 221434, physical reads 0, read-ahead reads 91, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Invoices'. Scan count 0, logical reads 94320, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table '#A5319D6D'. Scan count 31441, logical reads 3081218, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

--(1 row affected)

-- SQL Server Execution Times:
--   CPU time = 160906 ms,  elapsed time = 161814 ms.
--SQL Server parse and compile time: 
--   CPU time = 0 ms, elapsed time = 0 ms.


-- Запрос с временой таблицей выполняется полсекунды, запрос с табличной переменной же выполняется 2,5 минуты.
-- Это обусловлено нюансом с табличной переменной: оптимизатор предполагает, что в табличной переменной содержится 1 строка,
-- и из-за этого выбирает неоптимальный алгоритм соединения временной таблицы с таблицей Invoices: Nested Loop, вместо Hash Match.
 

/* 2. Если вы брали предложенный выше запрос, то сделайте расчет суммы нарастающим итогом с помощью оконной функции.
Сравните 2 варианта запроса - через windows function и без них. Написать какой быстрее выполняется, сравнить по set statistics time on; */

set statistics io, time on;

select distinct
	i.InvoiceID,
	c.CustomerName,
	i.InvoiceDate,
	sum(il.Quantity*il.UnitPrice) over (partition by il.InvoiceID) as InvoicePrice,
	sum(il.Quantity*il.UnitPrice) over (order by dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0)) as CumulativePrice
from Sales.Invoices as i
join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
join Sales.Customers as c on i.CustomerID = c.CustomerID
where i.InvoiceDate >= '2015-01-01'
order by i.InvoiceID

-- План в windowsFunction.sqlplan

---- Статистика
--(31440 rows affected)
--Table 'InvoiceLines'. Scan count 2, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 161, lob physical reads 0, lob read-ahead reads 0.
--Table 'InvoiceLines'. Segment reads 1, segment skipped 0.
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Invoices'. Scan count 1, logical reads 11400, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Customers'. Scan count 1, logical reads 41, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

--(1 row affected)

-- SQL Server Execution Times:
--   CPU time = 203 ms,  elapsed time = 471 ms.
--SQL Server parse and compile time: 
--   CPU time = 0 ms, elapsed time = 0 ms.

-- По статистикам разница между временной таблицей и оконной функцией не так значительна.
-- Основное отличие: отсутствие одного запроса по таблице Invoices, что уменьшило чтений этой табилцы в 2 раза

/* 3. Вывести список 2х самых популярных продуктов (по кол-ву проданных) в каждом месяце за 2016й год
-- (по 2 самых популярных продукта в каждом месяце) */

;with stockItems_CTE as (
	select 
		month(i.InvoiceDate) as Month,
		row_number() over (partition by month(i.InvoiceDate) order by sum(il.Quantity) desc) as Number,
		s.StockItemID,
		s.StockItemName,
		sum(il.Quantity) as Count		
	from Sales.Invoices as i
	join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
	join Warehouse.StockItems as s on il.StockItemID = s.StockItemID
	where year(i.InvoiceDate) = 2016
	group by month(i.InvoiceDate), s.StockItemID, s.StockItemName
)
select * 
from stockItems_CTE as cte
where cte.Number < =2
order by cte.Month, cte.Number

/* 3. Функции одним запросом
Посчитайте по таблице товаров, в вывод также должен попасть ид товара, название, брэнд и цена
пронумеруйте записи по названию товара, так чтобы при изменении буквы алфавита нумерация начиналась заново
посчитайте общее количество товаров и выведете полем в этом же запросе
посчитайте общее количество товаров в зависимости от первой буквы названия товара
отобразите следующий id товара исходя из того, что порядок отображения товаров по имени
предыдущий ид товара с тем же порядком отображения (по имени)
названия товара 2 строки назад, в случае если предыдущей строки нет нужно вывести "No items"
сформируйте 30 групп товаров по полю вес товара на 1 шт
Для этой задачи НЕ нужно писать аналог без аналитических функций */

select 
	s.StockItemID,
	s.StockItemName,
	s.Brand,
	s.UnitPrice,
	row_number() over(partition by left(s.StockItemName, 1) order by s.StockItemName) as Number,
	count(1) over() as TotalCount,
	count(1) over(partition by left(s.StockItemName, 1)) as TotalByChar,
	lead(s.StockItemID) over(order by s.StockItemName) as NextStockItemId,
	lag(s.StockItemID) over(order by s.StockItemName) as PreviousStockItemId,
	isnull(lag(s.StockItemName, 2) over(order by s.StockItemName), 'No items') as PreviousStockItemName,
	ntile(30) over(order by s.TypicalWeightPerUnit) as Groups
from Warehouse.StockItems as s
order by s.StockItemName



/* 4. По каждому сотруднику выведите последнего клиента, которому сотрудник что-то продал
В результатах должны быть ид и фамилия сотрудника, ид и название клиента, дата продажи, сумму сделки */

;with query_CTE as (
	select 
		p.PersonID,
		p.FullName,
		c.CustomerID,
		c.CustomerName,
		i.InvoiceDate,
		sum(il.Quantity*il.UnitPrice) over(partition by il.InvoiceID) as Cost,
		row_number() over(partition by p.PersonId order by i.InvoiceDate desc, i.InvoiceID desc) as NumberByDate
	from Application.People as p
	join Sales.Invoices as i on p.PersonID = i.SalespersonPersonID
	join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
	join Sales.Customers as c on i.CustomerID = c.CustomerID
)
select 
	c.PersonID,
	c.FullName,
	c.CustomerID,
	c.CustomerName,
	c.InvoiceDate,
	c.Cost
from query_CTE as c
where c.NumberByDate = 1
order by c.PersonID


/* 5. Выберите по каждому клиенту 2 самых дорогих товара, которые он покупал
В результатах должно быть ид клиета, его название, ид товара, цена, дата покупки */

;with query_CTE as (
	select 
		c.CustomerID,
		c.CustomerName,
		il.StockItemID,
		il.UnitPrice,
		i.InvoiceDate,
		row_number() over(partition by c.CustomerID order by il.UnitPrice desc) as NumberByCost
	from Sales.Customers as c
	join Sales.Invoices as i on c.CustomerID = i.CustomerID
	join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
)
select 
	c.CustomerID,
	c.CustomerName,
	c.StockItemID,
	c.UnitPrice,
	c.InvoiceDate
from query_CTE as c
where c.NumberByCost <= 2
order by c.CustomerID, c.NumberByCost

/* Опционально можно сделать вариант запросов для заданий 2,4,5 без использования windows function и сравнить скорость как в задании 1.*/

/* Bonus из предыдущей темы
Напишите запрос, который выбирает 10 клиентов, которые сделали больше 30 заказов и последний заказ был не позднее апреля 2016. */

select 
	c.CustomerID,
	c.CustomerName,
	count(c.CustomerID),
	max(i.InvoiceDate)
from Sales.Customers as c
join Sales.Invoices as i on c.CustomerID = i.CustomerID
group by c.CustomerID, c.CustomerName
having count(c.CustomerID) > 30 and max(i.InvoiceDate) < '2016-05-01'
order by c.CustomerID
