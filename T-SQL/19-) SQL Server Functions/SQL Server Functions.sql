-- USER DEFINED FUNCTIONS -- 
/*

1-) Scalar - Valued Functions
2-) Table - Valued Functions

User Defined Functions tan�mlarken return veya returns anahtar kelimeleri kullan�l�r. Bu anahtar kelimeleri kullanmam�z�n sebebi bu fonksiyonlar her �al��t���nda geriye mutlaka bir de�er d�nerler.

Functionlar da birer database nesnesidir. Bu sebepten dolay� DDL komutlar� (Create,Alter,Drop) ile y�netilirler.

Functionlar parametre alabilirler veya almayadabilirler.

Functionlar subQuery i�erisinde kullan�labilir. Fakat Stored Procedure ler herhangi bir sorgu i�erisinde kullan�lmazlar.

Scalar ve Tablet Valued Functionlarda sadece Select sorgusu kullan�labilir.

*/

-- Fonksiyon Tan�mlama -- 
create function KDVliFiyatHesapla(@Tutar money,@Oran float)
returns money
as
	begin
	return (@Tutar * (1+@Oran))
	end


-- Olu�turulan fonksiyonu �a��rma i�lemi -- 
Select dbo.KDVliFiyatHesapla(124.45,0.18)
Select p.ProductID,p.ProductName,p.UnitPrice,dbo.KDVliFiyatHesapla(p.UnitPrice,0.08) as 'Kdv li Tutar' from Products p



--Bug�n�n tarihini d�nen bir scalar function yapal�m.
create function BugununTarihi()
Returns date
as
	begin
	return getdate()
	end

-- �a��rma
select dbo.BugununTarihi()


-- Kategori id bilgisi alan, ald��� bu bilgiye g�re bu kategoriden ka� adet �r�n�n sat�ld���n� g�steren bir fonksiyon olu�tural�m.

create function KategorideSatilanUrunSayisi(@CategoryId int)
returns int
as
	begin
	return( Select Sum(od.Quantity) from [Order Details] od inner join Products p
	on od.ProductID = p.ProductID
	Where p.CategoryID = @CategoryId)
	end

Select dbo.KategorideSatilanUrunSayisi(1)


-- Yukar�daki fonksiyonu kategoriname e g�re gruplayarak getiren fonksiyonu yaz�n�z.


--Tarih Formatla Fonksiyonu
create function TarihFormatla
(@tarih datetime,@ayrac char(1),@format char(3))
Returns nchar(10)
as
		begin
		declare @yil nchar(4) =  Year(@tarih)
		declare @ay nchar(2)  =  Month(@tarih) 
		declare @gun nchar(2) =  Day(@tarih)  
		declare @formatliTarih nchar(10)
			
			if LEN(@gun) = 1
				set @gun = '0'+@gun
			if LEN(@ay) = 1
				set @ay = '0'+@ay

			if @format = 'dmy'
				set @formatliTarih = @gun+@ayrac+@ay+@ayrac+@yil
			if @format = 'mdy'
				set @formatliTarih = @ay+@ayrac+@gun+@ayrac+@yil
			if @format = 'ymd'
				set @formatliTarih = @yil+@ayrac+@ay+@ayrac+@gun

return @formatliTarih
		end

-- Tarih formatlama fonksiyonunu �a��rma
select dbo.TarihFormatla(GETDATE(),'/','mdy')

Select o.OrderID,o.ShipCity,o.ShipCountry,dbo.TarihFormatla(o.OrderDate,'.','dmy') from Orders o 


-- MultiStatement Table Valued Functions --
-- Bu functionlar i�erisinde insert,update,delete i�lemlerini kullanabiliriz.
-- Bu functionlar geriye bir tablo d�ner fakat bu tablo fiziksel olarak tan�mlanmaz.
-- Tan�mlad���m�z bu tablo local yada global bir de�i�kenden ibarettir.


--TANIMALAMA--

Create function Kisilerim (@tip nvarchar(7))
returns @Tablom table(Id int,Ad nvarchar(50))
as
		begin
		if @tip = 'ad'
			begin
			Insert @Tablom Select EmployeeID,FirstName from Employees
			end
		else if @tip ='adsoyad'
			begin
			Insert @Tablom Select EmployeeID, (FirstName+' '+LastName) from Employees
			end

		RETURN
		end

--�A�IRMA--

Select * from Kisilerim('ad')
Select * from Kisilerim('adsoyad') Where Id <> 9


-- M��terinin sat�n ald��� �r�nleri (�r�n Ad�,Fiyat� ve Mevcut Stok) g�steren bir fonksiyon yazal�m. Parametre olarak m��teri id als�n.

create function MusteriSatinAldigiUrunDetaylari
(@CustomerId nvarchar(10))
returns @MusteriSatinAlinanUrunler table
(
UrunAdi nvarchar(50),
Fiyat decimal(18,2),
MevcutStok int
)
as
	begin 
		Insert @MusteriSatinAlinanUrunler
		Select p.ProductName,od.UnitPrice,p.UnitsInStock from Customers c
					inner join Orders o on c.CustomerID = o.CustomerID
					inner join [Order Details] od on o.OrderID = od.OrderID
					inner join Products p on od.ProductID = p.ProductID
					Where c.CustomerID = @CustomerId
	return
	end



-- Olu�turulan fonksiyonu �a��rma -- 
Select * from Customers

Select * from MusteriSatinAldigiUrunDetaylari('ALFKI')