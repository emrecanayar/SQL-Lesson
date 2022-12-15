-- STORED PROCEDURE --
-- Sakl� y�ntem demektir.
-- SubQueryler i�erisinde kullan�lamazlar. Nedeni SP ler zaten ba�l� ba��na bir i� yaparlar.
-- SP ler belirli bir i�levi, g�revi yerine getirmek i�in �zellikle yap�land�r�lm�� bir veya daha fazla tablo, sp vs. ile ili�kili kod par�ac�klar�d�r. K�saca derlenmi� SQL c�mleci�i diyebiliriz. Sp'ler veri taban�nda saklanan SQL ifadeleridir. Programlama dillerinde oldu�u gibi parametreler i�erir. Bu parametrelere g�re �al���p sonu�lar� listeler.

-- Veri taban� nesneleri olduklar� i�in DDL komutlar� (Create,Alter,Drop) ile tan�mlan�r ve �zerinde i�lemler yap�l�r.

-- Stored Procedure Kullanman�n Faydalar� --
/*

=> Execution Plan ��kar�ld��� i�in normal sorgulara g�re daha h�zl� �al���rlar. Yani normal olarak yazd���m�z querylere g�re olduk�a h�zl� �al���yor. Normal olarak olu�turdu�umuz querylerde her bir i�lem i�in bir Execution Plan olu�turuldu�undan dolay� normal queryler yava�, SP lerde bu execution plan tek seferlik olu�tu�undan dolay� da SP lerde sorgular olduk�a h�zl� �al���r.

=> Client mimarisinin aksine toplu i�lemler kendi i�erisinde �al��t��� i�in network h�z�nda de�ilde ram h�z�nda �al���r.

=> Yaz�l�m g�ncellemeden de�i�iklikler yap�labilir.

=> Olduk�a g�venlidir. SQL Injection ataklar�na kar�� kesin ��z�md�r.

=> Kritik raporlar Stored Procedure bazl� olu�turulabilir. Olu�turulan bu raporlara da yetki ba�lanabilir.

=> Herhangi bir raporlama dilinde yaz�labilecek hemen hemen her t�rl� komut burada yaz�p �al��t�r�labilir.

=> Stored Procedure ler birbirleri i�erisinde �a�r�labilir. Bu sayede kod karma�as�n�n da �n�ne ge�ilmi� olur.

=> Performans� �l��lebilir. Ka� kez �al��t�r�lm�� en son ne zaman �al��t�r�lm�� kim taraf�ndan �al��t�r�lm�� vs. bilgileri g�r�lebilir. Bu loglar sayesinde bu durumlarla alakal� iyile�tirmeler yap�lacaksa yap�labilir.
*/

/*
STORE PROCEDURE Syntax

Create Procedure Olu�turulacak_SPADI
as
	SQL SORGU

*/

-- Sp Tan�mlama

Alter procedure [UrunEkle] (@UrunAd nvarchar(20),@BirimFiyat money,@KategoriId int)
as
	Insert Products (ProductName,UnitPrice,CategoryID)
	values (@UrunAd,@BirimFiyat,@KategoriId)
	Select * from Products
	
exec UrunEkle 'Portakal',3,5
execute UrunEkle 'Peynir',10,8
UrunEkle 'Muz',40.10,5


-- Yukar�daki ayn� parametrelerle ve ek olarak ProductId parametresini kullanarak �r�nleri g�ncellemek i�in bir SP yaz�n�z.
Create proc UrunGuncelle
(@UrunAd nvarchar (20), @BirimFiyat money, @KategoriId int, @ProductId int)
as
	Update Products Set ProductName = @UrunAd, UnitPrice = @BirimFiyat, CategoryID = @KategoriId
	Where ProductID = @ProductId

exec UrunGuncelle 'G�ncelledim',2,3,15 

Select * from Products Where ProductID = 15


Select * from Categories
Insert Categories (CategoryName) values ('Ohters')
Select * from Products

-- Kategori kontrol� yaparak �r�n ekleme i�lemi.
create proc KategoriKontrolluUrunEkleme
(@Ad nvarchar(50),@Fiyat money, @KategoriId int, @Stok int)
as
	declare @enBuyukKategoriId int
	select @enBuyukKategoriId =  Max(CategoryID) from Categories
		
		if @enBuyukKategoriId < @KategoriId
			begin
			print 'Girdi�iniz kategori olmad���ndan �r�n�n kategori Id si 24 olarak Ohters ad�ndaki kategori olarak belirlendi'
				set @KategoriId = 24
			end

			Insert Products(ProductName,UnitPrice,CategoryID,UnitsInStock)
			VALUES (@Ad,@Fiyat,@KategoriId,@Stok)


Exec KategoriKontrolluUrunEkleme 'Mandalina',120.30,13,5
Exec KategoriKontrolluUrunEkleme 'Maydonoz',10,555,5

Exec CustOrderHist 'ANTON'


-- With Encryption ile SP Kullan�m�
Create proc UrunIdyeGoreAdGetir (@UrunId int)
with encryption
as
	Select ProductName from Products Where ProductID = @UrunId

Exec UrunIdyeGoreAdGetir 56


-- SP nin �al��mas� sonucu d�nen de�eri bir de�i�kene atayabiliriz.
declare @UrunAd nvarchar(50), @id int = 55
exec @UrunAd = UrunIdyeGoreAdGetir @id
print CAST (@id as nvarchar) + ' no lu �r�n ad� : '+@UrunAd

-
-- SP lerde Output parametresinin kullan�m�
Create proc ShipperInsert(@cn nvarchar(50),@p nvarchar(50),@shipperId int output)
as
	Insert Shippers (CompanyName,Phone) Values (@cn,@p)
	set @shipperId = @@IDENTITY


-- �a��rma Y�ntemleri -- 
-- 1.Y�ntem
declare @shipper_Id int 
exec ShipperInsert 'Sendeo','5379184330',@shipperId = @shipper_Id output
select @shipper_Id


-- 2.Y�ntem
declare @shipperr_Id int 
exec ShipperInsert 'Sendeo','5379184330',@shipperr_Id output
select @shipperr_Id


-- Procedure Excution �statistiklerini G�rme -- 
Select 
sp.object_id as 'Object Id',
sp.database_id as 'Bulundu�u Database Id',
OBJECT_NAME(sp.object_id,sp.database_id) as 'Stored Procedure Ad�',
sp.cached_time as 'Cache S�resi',
sp.last_execution_time as 'Son �al��ma S�resi',
sp.total_elapsed_time as 'Toplam Ge�en S�re',
sp.total_elapsed_time / sp.execution_count as 'Ortalama Ge�en S�re',
sp.last_elapsed_time as 'Ge�en S�re',
sp.execution_count as '�al��ma Say�s�'
from sys.dm_exec_procedure_stats as sp
Where sp.database_id = 5
