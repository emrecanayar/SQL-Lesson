-- STORED PROCEDURE --
-- Saklý yöntem demektir.
-- SubQueryler içerisinde kullanýlamazlar. Nedeni SP ler zaten baþlý baþýna bir iþ yaparlar.
-- SP ler belirli bir iþlevi, görevi yerine getirmek için özellikle yapýlandýrýlmýþ bir veya daha fazla tablo, sp vs. ile iliþkili kod parçacýklarýdýr. Kýsaca derlenmiþ SQL cümleciði diyebiliriz. Sp'ler veri tabanýnda saklanan SQL ifadeleridir. Programlama dillerinde olduðu gibi parametreler içerir. Bu parametrelere göre çalýþýp sonuçlarý listeler.

-- Veri tabaný nesneleri olduklarý için DDL komutlarý (Create,Alter,Drop) ile tanýmlanýr ve üzerinde iþlemler yapýlýr.

-- Stored Procedure Kullanmanýn Faydalarý --
/*

=> Execution Plan çýkarýldýðý için normal sorgulara göre daha hýzlý çalýþýrlar. Yani normal olarak yazdýðýmýz querylere göre oldukça hýzlý çalýþýyor. Normal olarak oluþturduðumuz querylerde her bir iþlem için bir Execution Plan oluþturulduðundan dolayý normal queryler yavaþ, SP lerde bu execution plan tek seferlik oluþtuðundan dolayý da SP lerde sorgular oldukça hýzlý çalýþýr.

=> Client mimarisinin aksine toplu iþlemler kendi içerisinde çalýþtýðý için network hýzýnda deðilde ram hýzýnda çalýþýr.

=> Yazýlým güncellemeden deðiþiklikler yapýlabilir.

=> Oldukça güvenlidir. SQL Injection ataklarýna karþý kesin çözümdür.

=> Kritik raporlar Stored Procedure bazlý oluþturulabilir. Oluþturulan bu raporlara da yetki baðlanabilir.

=> Herhangi bir raporlama dilinde yazýlabilecek hemen hemen her türlü komut burada yazýp çalýþtýrýlabilir.

=> Stored Procedure ler birbirleri içerisinde çaðrýlabilir. Bu sayede kod karmaþasýnýn da önüne geçilmiþ olur.

=> Performansý ölçülebilir. Kaç kez çalýþtýrýlmýþ en son ne zaman çalýþtýrýlmýþ kim tarafýndan çalýþtýrýlmýþ vs. bilgileri görülebilir. Bu loglar sayesinde bu durumlarla alakalý iyileþtirmeler yapýlacaksa yapýlabilir.
*/

/*
STORE PROCEDURE Syntax

Create Procedure Oluþturulacak_SPADI
as
	SQL SORGU

*/

-- Sp Tanýmlama

Alter procedure [UrunEkle] (@UrunAd nvarchar(20),@BirimFiyat money,@KategoriId int)
as
	Insert Products (ProductName,UnitPrice,CategoryID)
	values (@UrunAd,@BirimFiyat,@KategoriId)
	Select * from Products
	
exec UrunEkle 'Portakal',3,5
execute UrunEkle 'Peynir',10,8
UrunEkle 'Muz',40.10,5


-- Yukarýdaki ayný parametrelerle ve ek olarak ProductId parametresini kullanarak Ürünleri güncellemek için bir SP yazýnýz.
Create proc UrunGuncelle
(@UrunAd nvarchar (20), @BirimFiyat money, @KategoriId int, @ProductId int)
as
	Update Products Set ProductName = @UrunAd, UnitPrice = @BirimFiyat, CategoryID = @KategoriId
	Where ProductID = @ProductId

exec UrunGuncelle 'Güncelledim',2,3,15 

Select * from Products Where ProductID = 15


Select * from Categories
Insert Categories (CategoryName) values ('Ohters')
Select * from Products

-- Kategori kontrolü yaparak ürün ekleme iþlemi.
create proc KategoriKontrolluUrunEkleme
(@Ad nvarchar(50),@Fiyat money, @KategoriId int, @Stok int)
as
	declare @enBuyukKategoriId int
	select @enBuyukKategoriId =  Max(CategoryID) from Categories
		
		if @enBuyukKategoriId < @KategoriId
			begin
			print 'Girdiðiniz kategori olmadýðýndan ürünün kategori Id si 24 olarak Ohters adýndaki kategori olarak belirlendi'
				set @KategoriId = 24
			end

			Insert Products(ProductName,UnitPrice,CategoryID,UnitsInStock)
			VALUES (@Ad,@Fiyat,@KategoriId,@Stok)


Exec KategoriKontrolluUrunEkleme 'Mandalina',120.30,13,5
Exec KategoriKontrolluUrunEkleme 'Maydonoz',10,555,5

Exec CustOrderHist 'ANTON'


-- With Encryption ile SP Kullanýmý
Create proc UrunIdyeGoreAdGetir (@UrunId int)
with encryption
as
	Select ProductName from Products Where ProductID = @UrunId

Exec UrunIdyeGoreAdGetir 56


-- SP nin çalýþmasý sonucu dönen deðeri bir deðiþkene atayabiliriz.
declare @UrunAd nvarchar(50), @id int = 55
exec @UrunAd = UrunIdyeGoreAdGetir @id
print CAST (@id as nvarchar) + ' no lu ürün adý : '+@UrunAd

-
-- SP lerde Output parametresinin kullanýmý
Create proc ShipperInsert(@cn nvarchar(50),@p nvarchar(50),@shipperId int output)
as
	Insert Shippers (CompanyName,Phone) Values (@cn,@p)
	set @shipperId = @@IDENTITY


-- Çaðýrma Yöntemleri -- 
-- 1.Yöntem
declare @shipper_Id int 
exec ShipperInsert 'Sendeo','5379184330',@shipperId = @shipper_Id output
select @shipper_Id


-- 2.Yöntem
declare @shipperr_Id int 
exec ShipperInsert 'Sendeo','5379184330',@shipperr_Id output
select @shipperr_Id


-- Procedure Excution Ýstatistiklerini Görme -- 
Select 
sp.object_id as 'Object Id',
sp.database_id as 'Bulunduðu Database Id',
OBJECT_NAME(sp.object_id,sp.database_id) as 'Stored Procedure Adý',
sp.cached_time as 'Cache Süresi',
sp.last_execution_time as 'Son Çalýþma Süresi',
sp.total_elapsed_time as 'Toplam Geçen Süre',
sp.total_elapsed_time / sp.execution_count as 'Ortalama Geçen Süre',
sp.last_elapsed_time as 'Geçen Süre',
sp.execution_count as 'Çalýþma Sayýsý'
from sys.dm_exec_procedure_stats as sp
Where sp.database_id = 5
