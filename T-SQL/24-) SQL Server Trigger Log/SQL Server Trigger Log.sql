Create Database LogDB

Use LogDB

CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[SupplierID] [int] NULL,
	[CategoryID] [int] NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NOT NULL,
    [LogHostName] [nvarchar](255) NULL,
	[LogDate] datetime NULL,
	[LogProgram] [nvarchar](255) NULL,
	[LogUsername] [nvarchar](255) NULL,
	[LogSQL] [nvarchar](max) NULL,
	[LogActionType] [nvarchar](10) NULL,
)

--LogHostName => Products tablosu �zerinde yap�lan de�i�ikli�i hangi host taraf�ndan yap�ld���n� loglamak i�in olu�turulan alan.
--LogDate => Products tablosu �zerinde yap�lan de�i�ikli�in o anki tarihini tutmak i�in olu�turulan alan.
--LogProgram => ��lemi ger�ekle�tiren program�n ad�n� almak ve kaydetmek i�in kullan�lan alan.
--LogUserName => ��lemi ger�ekle�tiren kullan�c�n�n ismini veya kullan�c� ad�n� almak i�in kullan�lan alan.
--LogSQL => ��lem yap�l�rken nas�l bir sql sorgusu ile yap�lm�� ise o sorguyu loglamak i�in kullan�lan alan.
--LogActionType => Yap�lan i�lemin tipini belirtti�imiz alan e�er yap�lan i�lem;	
				-- Silme i�lemi ise DELETE ,
				-- G�ncelleme i�lemi ise UPDATE,
				-- Ekleme i�lemi ise INSERT de�erini alacakt�r.

Use Northwind

create Trigger ProductsLogUpdate 
on Products
after update
as
	begin 
	declare @LogHostName as nvarchar(255) = HOST_NAME() -- HOST_NAME metodu �al��an sorgunun host unu bize verir.
	declare @LogDate as DATETIME
	set @LogDate = GETDATE()
	declare @LogProgram as nvarchar(255) = PROGRAM_NAME() -- �al��an i�lemin program ad�n� verir.
	declare @LogUserName as nvarchar(255) = SUSER_NAME() -- SQL Server �zerindeki kullan�c�n�n ad�n� verir.
	declare @LogSQL nvarchar(MAX)
	declare @LogActionType as nvarchar(10) = 'UPDATE'


	--Select getdate()
	--DBCC INPUTBUFFER(@@SPID) -- SSPID Kullan�c�n�n SQL Server �zerindeki Id si

	Create table #T(EventType varchar(100),Parameters_ varchar(100),EventInfo varchar(max))
	Declare @SQL as nvarchar(max)
	SET @SQL = 'INSERT INTO #T EXEC (''DBCC INPUTBUFFER('+CONVERT(varchar,@@SPID)+')'')' 
	Exec sp_executesql @SQL
	Select @LogSQL = EventInfo from #T


	Insert into LogDB.dbo.Products
	([ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [LogHostName], [LogDate], [LogProgram], [LogUsername], [LogSQL], [LogActionType])
	Select [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued],@LogHostName,@LogDate,@LogProgram,@LogUserName,@LogSQL,@LogActionType  from deleted

	end


	Select * from Products

	Update Products Set ProductName = 'Ayva' Where ProductName = 'G�ncelledim'