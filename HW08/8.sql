/* Начало проектной работы.
Создание таблиц и представлений для своего проекта.
Нужно используя операторы DDL создать:
1. 3-4 основные таблицы для своего проекта. 
2. Первичные и внешние ключи для всех созданных таблиц
3. 1-2 индекса на таблицы */

use master

if db_id(N'AccountDb') is null
	create database AccountDb

go 

use [AccountDb]

if object_id('dbo.Employees', 'U') is not null
begin
	alter table dbo.Employees
		drop constraint FK_Employees_Users_UserId

	alter table dbo.Employees
		drop constraint FK_Employees_Organizations_OrganizationId
end

drop table if exists dbo.Organizations
drop table if exists dbo.Users
drop table if exists dbo.Employees
go 

-- Таблица организаций
create table dbo.Organizations (
	OrganizationId uniqueidentifier not null,
	Name nvarchar(500) not null,
	ShortName nvarchar(100) not null,
	Inn nvarchar(12) not null,
	Kpp nvarchar(9) null,
	RegistrationDate datetime not null,
	State tinyint not null -- 0 - активная; 1 - новая (органзиация только что добавлена и не имеет подписок ни на один сервис); 2 - заблокированная (истекли подписки на сервисы); 3 - удаленная
)
go

-- первичный ключ
alter table dbo.Organizations 
	add constraint PK_OrganizationId primary key clustered (OrganizationId)
go 

-- статус по умолчанию
alter table dbo.Organizations 
	add constraint DF_Organizations_State default (1) for [State]
go 

-- статус по умолчанию
alter table dbo.Organizations 
	add constraint DF_Organizations_RegistrationDate default (getdate()) for RegistrationDate
go 

-- Индексы на поля
create nonclustered index IX_Inn on dbo.Organizations (Inn)
go
create nonclustered index IX_Name on dbo.Organizations (Name)
go



-- Таблица зарегистрированных пользователей, которые могут авторизовываться в системе
create table dbo.Users (
	UserId uniqueidentifier not null,
	FirstName nvarchar(100) not null,
	LastName nvarchar(100) not null,
	MiddleName nvarchar(100) null,
	MobilePhone nvarchar(10) not null,
	State tinyint not null -- 0 - активный; 1 - новый (начал регистрацию, но не закончил); 2 - заблокированный; 3 - удаленный
		constraint DF_Users_State default (0)
)
go 

-- первичный ключ
alter table dbo.Users
	add constraint PK_UserId primary key clustered (UserId)
go

--составной индекс на имя
create nonclustered index IX_Name on dbo.Users (LastName, FirstName, MiddleName)
go

--индекс на номер телефона
create nonclustered index IX_MobilePhone on dbo.Users (MobilePhone)
go

--Таблица сотрудников/пользователей, которые имеют доступ к организациям
create table dbo.Employees(
	EmployeeId uniqueidentifier not null,
	UserId uniqueidentifier not null,
	OrganizationId uniqueidentifier not null,
	Post nvarchar(100) not null,
	State tinyint not null -- 0 - активный, 1 - неактивный
		constraint DF_Employees_State default (0)
)
go

-- первичный ключ
alter table dbo.Employees
	add constraint PK_EmployeeId primary key clustered (EmployeeId)
go

--внешний ключ на таблицу Users
alter table dbo.Employees with check
	add constraint FK_Employees_Users_UserId foreign key (UserId) 
	references dbo.Users (UserId)
go

--внешний ключ на таблицу Organizations
alter table dbo.Employees with check
	add constraint FK_Employees_Organizations_OrganizationId foreign key (OrganizationId)
	references dbo.Organizations (OrganizationId)


