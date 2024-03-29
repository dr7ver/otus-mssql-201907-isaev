/*1. Посчитать среднюю цену товара, общую сумму продажи по месяцам */

select 
	dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as month,
	avg(il.UnitPrice) as avarageCost,
	sum(il.ExtendedPrice) as totalSum
from Sales.Invoices as i
	join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
group by dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0)
order by month;
go

/* 2. Отобразить все месяцы, где общая сумма продаж превысила 10 000 */

select 
	dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as month,
	sum(il.ExtendedPrice) as totalSum
from Sales.Invoices as i
	join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
group by dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0)
having sum(il.ExtendedPrice)>10000
order by month;
go

/* 3. Вывести сумму продаж, дату первой продажи и количество проданного по месяцам, по товарам, продажи которых менее 50 ед в месяц. 
Группировка должна быть по году и месяцу. */

select 
	il.StockItemID,
	datepart(yy, i.InvoiceDate) as year, 
	datepart(mm, i.InvoiceDate) as month,
	sum(il.ExtendedPrice) as TotalSum,
	min(i.InvoiceDate) as FirstInvoice,
	sum(il.Quantity) as TolalQuantity
from Sales.Invoices as i
	join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
group by datepart(yy, i.InvoiceDate), datepart(mm, i.InvoiceDate), il.StockItemID
having sum(il.Quantity) < 50
order by year, month, il.StockItemID;
go

/* 4. Написать рекурсивный CTE sql запрос и заполнить им временную таблицу и табличную переменную
Дано :
CREATE TABLE dbo.MyEmployees 
( 
EmployeeID smallint NOT NULL, 
FirstName nvarchar(30) NOT NULL, 
LastName nvarchar(40) NOT NULL, 
Title nvarchar(50) NOT NULL, 
DeptID smallint NOT NULL, 
ManagerID int NULL, 
CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC) 
); 
INSERT INTO dbo.MyEmployees VALUES 
(1, N'Ken', N'Sánchez', N'Chief Executive Officer',16,NULL) 
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1) 
,(274, N'Stephen', N'Jiang', N'North American Sales Manager',3,273) 
,(275, N'Michael', N'Blythe', N'Sales Representative',3,274) 
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274) 
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273) 
,(286, N'Lynn', N'Tsoflias', N'Sales Representative',3,285) 
,(16, N'David',N'Bradley', N'Marketing Manager', 4, 273) 
,(23, N'Mary', N'Gibson', N'Marketing Specialist', 4, 16); 

Результат вывода рекурсивного CTE:
EmployeeID Name Title EmployeeLevel
1	Ken Sánchez	Chief Executive Officer	1
273	| Brian Welcker	Vice President of Sales	2
16	| | David Bradley	Marketing Manager	3
23	| | | Mary Gibson	Marketing Specialist	4
274	| | Stephen Jiang	North American Sales Manager	3
276	| | | Linda Mitchell	Sales Representative	4
275	| | | Michael Blythe	Sales Representative	4
285	| | Syed Abbas	Pacific Sales Manager	3
286	| | | Lynn Tsoflias	Sales Representative	4
*/

drop table if exists dbo.MyEmployees;

CREATE TABLE dbo.MyEmployees 
( 
	EmployeeID smallint NOT NULL, 
	FirstName nvarchar(30) NOT NULL, 
	LastName nvarchar(40) NOT NULL, 
	Title nvarchar(50) NOT NULL, 
	DeptID smallint NOT NULL, 
	ManagerID int NULL, 
	CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC) 
); 

INSERT INTO dbo.MyEmployees VALUES 
(1, N'Ken', N'Sánchez', N'Chief Executive Officer',16,NULL) 
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1) 
,(274, N'Stephen', N'Jiang', N'North American Sales Manager',3,273) 
,(275, N'Michael', N'Blythe', N'Sales Representative',3,274) 
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274) 
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273) 
,(286, N'Lynn', N'Tsoflias', N'Sales Representative',3,285) 
,(16, N'David',N'Bradley', N'Marketing Manager', 4, 273) 
,(23, N'Mary', N'Gibson', N'Marketing Specialist', 4, 16); 
go

-- Заполнение временной таблицы
with recursive_CTE as (
	select e.EmployeeID,
		cast(concat(e.FirstName, ' ', e.LastName) as nvarchar(50)) as Name,
		e.Title,
		1 as EmployeeLevel
	from dbo.MyEmployees as e
	where e.ManagerID is null

	union all

	select e.EmployeeID,
		cast(concat(replicate('| ', c.EmployeeLevel), e.FirstName, ' ', e.LastName) as nvarchar(50)) as Name,
		e.Title,
		c.EmployeeLevel + 1 as EmployeeLevel
	from dbo.MyEmployees as e
	join recursive_CTE as c on c.EmployeeID = e.ManagerID
)
select *
into #recursive_table
from recursive_CTE as c;
select * from #recursive_table;

drop table #recursive_table;
go

-- Заполнение табличной переменной
declare @recursive_variable table
	(EmployeeID smallint NOT NULL, 
	Name nvarchar(100) NOT NULL,
	Title nvarchar(50) NOT NULL, 
	EmployeeLevel int NULL
);

with recursive_CTE as (
	select e.EmployeeID,
		cast(concat(e.FirstName, ' ', e.LastName) as nvarchar(50)) as Name,
		e.Title,
		1 as EmployeeLevel
	from dbo.MyEmployees as e
	where e.ManagerID is null

	union all

	select e.EmployeeID,
		cast(concat(replicate('| ', c.EmployeeLevel), e.FirstName, ' ', e.LastName) as nvarchar(50)) as Name,
		e.Title,
		c.EmployeeLevel + 1 as EmployeeLevel
	from dbo.MyEmployees as e
	join recursive_CTE as c on c.EmployeeID = e.ManagerID
)
insert into @recursive_variable select * from recursive_CTE;

select * from @recursive_variable;


/* Опционально:
Написать все эти же запросы, но, если за какой-то месяц не было продаж, то этот месяц тоже должен быть в результате и там должны быть нули. */

/* 1.1 Посчитать среднюю цену товара, общую сумму продажи по месяцам */

declare @minDate date;
declare @maxDate date;
set @minDate = (
	select 
		dateadd(mm, datediff(mm, 0, min(i.InvoiceDate)), 0) as Month
	from Sales.Invoices as i
);
set @maxDate = (
	select 
		dateadd(mm, datediff(mm, 0, max(i.InvoiceDate)), 0) as Month
	from Sales.Invoices as i
);

with allMonth_CTE as (
	select @minDate as Month

	union all

	select 
		dateadd(mm, 1, c.Month) as Month
	from allMonth_CTE as c
	where c.Month < @maxDate
),
grouped_CTE as (
		select 
			dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as Month,
			avg(il.UnitPrice) as AvarageCost,
			sum(il.ExtendedPrice) as TotalSum
		from Sales.Invoices as i
			join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
		group by dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0)
)
select m.Month,
	case when g.AvarageCost is null then 0 else g.AvarageCost end as AvarageCost,
	case when g.TotalSum is null then 0 else g.TotalSum end as TotalSum
from allMonth_CTE as m
left join grouped_CTE as g on m.Month = g.Month
order by m.Month;
go

/* 2.1 Отобразить все месяцы, где общая сумма продаж превысила 10 000 */

declare @minDate date;
declare @maxDate date;
set @minDate = (
	select 
		dateadd(mm, datediff(mm, 0, min(i.InvoiceDate)), 0) as Month
	from Sales.Invoices as i
);
set @maxDate = (
	select 
		dateadd(mm, datediff(mm, 0, max(i.InvoiceDate)), 0) as Month
	from Sales.Invoices as i
);

with allMonth_CTE as (
	select @minDate as Month

	union all

	select 
		dateadd(mm, 1, c.Month) as Month
	from allMonth_CTE as c
	where c.Month < @maxDate
),
grouped_CTE as (
	select 
		dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as month,
		sum(il.ExtendedPrice) as totalSum
	from Sales.Invoices as i
		join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
	group by dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0)
	having sum(il.ExtendedPrice)>10000
)
select m.Month,
	case when g.TotalSum is null then 0 else g.TotalSum end as TotalSum
from allMonth_CTE as m
left join grouped_CTE as g on m.Month = g.Month
order by m.Month;
go

/* 3.1 Вывести сумму продаж, дату первой продажи и количество проданного по месяцам, по товарам, продажи которых менее 50 ед в месяц. 
Группировка должна быть по году и месяцу. */

declare @minDate date;
declare @maxDate date;

CREATE TABLE #temporaryMonth (
	Month date primary key clustered
)

set @minDate = (
	select 
		dateadd(mm, datediff(mm, 0, min(i.InvoiceDate)), 0) as Month
	from Sales.Invoices as i
);
set @maxDate = (
	select 
		dateadd(mm, datediff(mm, 0, max(i.InvoiceDate)), 0) as Month
	from Sales.Invoices as i
);

with allMonth_CTE as (
	select @minDate as Month

	union all

	select 
		dateadd(mm, 1, c.Month) as Month
	from allMonth_CTE as c
	where c.Month < @maxDate
)
insert into #temporaryMonth
select *
from allMonth_CTE as m;

with optimize_CTE as (
	select 
		dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0) as Month,
		il.StockItemID,
		sum(il.ExtendedPrice) as TotalSum,
		min(i.InvoiceDate) as FirstInvoice,
		sum(il.Quantity) as TolalQuantity
	from Sales.Invoices as i
		join Sales.InvoiceLines as il on i.InvoiceID = il.InvoiceID
	group by dateadd(mm, datediff(mm, 0, i.InvoiceDate), 0), il.StockItemID
)
select s.StockItemID,
	m.Month,
	isnull(t.TotalSum, 0) as TotalSum,
	t.FirstInvoice,
	isnull(t.TolalQuantity, 0) as TolalQuantity
from #temporaryMonth as m
	cross join Warehouse.StockItems as s
	left join optimize_CTE as t on s.StockItemID = t.StockItemID and t.Month = m.Month
where t.TolalQuantity < 50 or t.TolalQuantity is null
order by m.Month, s.StockItemID;

drop table #temporaryMonth;