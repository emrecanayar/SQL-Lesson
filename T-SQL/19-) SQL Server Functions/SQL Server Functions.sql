-- USER DEFINED FUNCTIONS -- 
/*

1-) Scalar - Valued Functions
2-) Table - Valued Functions

User Defined Functions tanýmlarken return veya returns anahtar kelimeleri kullanýlýr. Bu anahtar kelimeleri kullanmamýzýn sebebi bu fonksiyonlar her çalýþtýðýnda geriye mutlaka bir deðer dönerler.

Functionlar da birer database nesnesidir. Bu sebepten dolayý DDL komutlarý (Create,Alter,Drop) ile yönetilirler.

Functionlar parametre alabilirler veya almayadabilirler.

Functionlar subQuery içerisinde kullanýlabilir. Fakat Stored Procedure ler herhangi bir sorgu içerisinde kullanýlmazlar.

Scalar ve Tablet Valued Functionlarda sadece Select sorgusu kullanýlabilir.

*/

-- Fonksiyon Tanýmlama -- 
create function KDVliFiyatHesapla(@Tutar money,@Oran float)
returns money
as
	begin
	return (@Tutar * (1+@Oran))
	end


-- Oluþturulan fonksiyonu çaðýrma iþlemi -- 
Select dbo.KDVliFiyatHesapla(124.45,0.18)
Select p.ProductID,p.ProductName,p.UnitPrice,dbo.KDVliFiyatHesapla(p.UnitPrice,0.08) as 'Kdv li Tutar' from Products p



--Bugünün tarihini dönen bir scalar function yapalým.
create function BugununTarihi()
Returns date
as
	begin
	return getdate()
	end

-- Çaðýrma
select dbo.BugununTarihi()


-- Kategori id bilgisi alan, aldýðý bu bilgiye göre bu kategoriden kaç adet ürünün satýldýðýný gösteren bir fonksiyon oluþturalým.

create function KategorideSatilanUrunSayisi(@CategoryId int)
returns int
as
	begin
	return( Select Sum(od.Quantity) from [Order Details] od inner join Products p
	on od.ProductID = p.ProductID
	Where p.CategoryID = @CategoryId)
	end

Select dbo.KategorideSatilanUrunSayisi(1)


-- Yukarýdaki fonksiyonu kategoriname e göre gruplayarak getiren fonksiyonu yazýnýz.


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

-- Tarih formatlama fonksiyonunu çaðýrma
select dbo.TarihFormatla(GETDATE(),'/','mdy')

Select o.OrderID,o.ShipCity,o.ShipCountry,dbo.TarihFormatla(o.OrderDate,'.','dmy') from Orders o 


-- MultiStatement Table Valued Functions --
-- Bu functionlar içerisinde insert,update,delete iþlemlerini kullanabiliriz.
-- Bu functionlar geriye bir tablo döner fakat bu tablo fiziksel olarak tanýmlanmaz.
-- Tanýmladýðýmýz bu tablo local yada global bir deðiþkenden ibarettir.


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

--ÇAÐIRMA--

Select * from Kisilerim('ad')
Select * from Kisilerim('adsoyad') Where Id <> 9


-- Müþterinin satýn aldýðý ürünleri (Ürün Adý,Fiyatý ve Mevcut Stok) gösteren bir fonksiyon yazalým. Parametre olarak müþteri id alsýn.

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



-- Oluþturulan fonksiyonu çaðýrma -- 
Select * from Customers

Select * from MusteriSatinAldigiUrunDetaylari('ALFKI')