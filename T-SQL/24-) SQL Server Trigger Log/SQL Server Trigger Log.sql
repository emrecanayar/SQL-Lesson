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

--LogHostName => Products tablosu üzerinde yapýlan deðiþikliði hangi host tarafýndan yapýldýðýný loglamak için oluþturulan alan.
--LogDate => Products tablosu üzerinde yapýlan deðiþikliðin o anki tarihini tutmak için oluþturulan alan.
--LogProgram => Ýþlemi gerçekleþtiren programýn adýný almak ve kaydetmek için kullanýlan alan.
--LogUserName => Ýþlemi gerçekleþtiren kullanýcýnýn ismini veya kullanýcý adýný almak için kullanýlan alan.
--LogSQL => Ýþlem yapýlýrken nasýl bir sql sorgusu ile yapýlmýþ ise o sorguyu loglamak için kullanýlan alan.
--LogActionType => Yapýlan iþlemin tipini belirttiðimiz alan eðer yapýlan iþlem;	
				-- Silme iþlemi ise DELETE ,
				-- Güncelleme iþlemi ise UPDATE,
				-- Ekleme iþlemi ise INSERT deðerini alacaktýr.

Use Northwind

create Trigger ProductsLogUpdate 
on Products
after update
as
	begin 
	declare @LogHostName as nvarchar(255) = HOST_NAME() -- HOST_NAME metodu çalýþan sorgunun host unu bize verir.
	declare @LogDate as DATETIME
	set @LogDate = GETDATE()
	declare @LogProgram as nvarchar(255) = PROGRAM_NAME() -- Çalýþan iþlemin program adýný verir.
	declare @LogUserName as nvarchar(255) = SUSER_NAME() -- SQL Server üzerindeki kullanýcýnýn adýný verir.
	declare @LogSQL nvarchar(MAX)
	declare @LogActionType as nvarchar(10) = 'UPDATE'


	--Select getdate()
	--DBCC INPUTBUFFER(@@SPID) -- SSPID Kullanýcýnýn SQL Server üzerindeki Id si

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

	Update Products Set ProductName = 'Ayva' Where ProductName = 'Güncelledim'