/*
Tools => Options => Designers => Prevent Saving Changes (Tablo üzerinde deðiþiklik yapmaya izin verir.)
Tools => Options => Text Editor => All Language => Word Wrap (Ekrana sýðmayan verileri otomatik olarak alt satýra alýr.)
Tools => Options => Text Editor => All Language => Show Visual Glyphs (Yukarýdaki madde ile baðlantýlý)
Tools => Options => Text Editor => All Language => Line Numbers (SSMS üzerinde satýr numaralarý çýkartýyor.)

Ctrl + R Query Result (Result ekranýný açar kapatýr.) 
Ctrl + Space Intellisense açýlmasý için kýsa yol.

*/

-- ZAMAN METOTLARI (FONKSÝYONLARI) --
/*

YEAR		=> Ýçerisine parametre olarak datetime tipinde veri alýr ve bize o verinin yýl bilgisini döner.
MONTH	    => Ýçerisine parametre olarak datetime tipinde veri alýr ve bize o verinin ay bilgisini döner.
DAY			=> Ýçerisine parametre olarak datetime tipinde veri alýr ve bize o verinin gün bilgisini döner.
GETDATE ()	=> Þuan ki sistem tarihini ve saatini döndürür.

*/

-- AGGREGATE FUNCTIONS -- 
-- Aggregate Function'lar parametrede gönderdiðimiz kolonun hesaplanmýþ sonucunu bize döndürür.
/*

AVG		=> Ortalama almak için kullanýlýr. (Sayýsal verilerde kullanýlmasý zorunludur.)
SUM		=> Toplama fonksiyonudur. Belirtilen kolondaki her veriyi toplayarak sonucunu bize döndürür. (Sayýsal verilerde kullanýlmasý zorunludur.)
COUNT	=> Sayma fonksiyonudur. Belirtilen kolondaki her veriyi adet olarak sayar ve bize döndürür. (Sayýsal verilerde kullanýlmasý zorunludur.)
MAX		=> Belirtilen kolondaki en büyük deðeri verir. (Sayýsal verilerde kullanýlmasý zorunlu deðildir.)
MIN		=> Belirtilen kolondaki en küçük deðeri verir. (Sayýsal verilerde kullanýlmasý zorunlu deðildir.)
ROUND	=> Yuvarlama için kullanýlýr. "," virgülden sonraki deðerleri yuvarlar.

*/


--ROUND KULLANIMI--
declare @sayi float
select @sayi = 14.56985
Select ROUND(@sayi,2)


-- SQL Server'da veri tiplerini birbirlerine dönüþtürmek için biz CAST ve CONVERT fonksiyonlarýný kullanýrýz. Aþaðýda CAST ve CONVERT için yazýlmýþ syntax larý görebilirsiniz.
-- CAST Kullanýmý	 => CAST(expression AS datatype(length))
-- CONVERT Kullanýmý => CONVERT(datatype(length),expression,style)

Select * from Products

Select 'Ürün Kodu : '+CAST(p.ProductID as varchar)+ ' Ürün Adý: '+p.ProductName as [Ürün Bilgisi] from Products p 
Select CAST(25.65 as int) -- Ondalýklý sayýyý tam sayýya çevirme
Select CAST(25.65 as varchar) + '5' -- Ondalýklý sayýyý metinsel formata çevirme
Select CAST('2017-08-25' as datetime) -- Metinsel deðeri tarihsel formata çevirme iþlemi

Select CONVERT(int,'123') + 5 -- Metinsel bir ifadeyi sayýsal deðere çevirme
Select CONVERT(varchar(30),GETDATE(),4) -- Tarihsel bir deðeri metinsel ifadeye çevirme.

-- Employees tablosuna Insert ile kendi kaydýnýzý ekleyiniz.
-- Eklediðiniz bu kaydýn FirstName = 'Ýstanbul' LastName='Türkiye' olarak güncelleyiniz.
-- Güncelleme iþlemi bittikten sonra ilgili kaydý siliniz.

Select * from Employees

Insert into Employees (FirstName,LastName) Values ('Emre Can','Ayar')

Update Employees Set FirstName = 'Ýstanbul' , LastName = 'Türkiye' Where EmployeeID = 20

Delete from Employees Where EmployeeID = 20


-- Ürünlerin toplam birim fiyatý ne kadardýr?
Select SUM(p.UnitPrice) as 'Toplam Fiyat' from Products p

--Þirketim þimdiye kadar toplam ne kadar ciro yapmýþ?
Select  ROUND(SUM(o.UnitPrice * o.Quantity * (1-o.Discount)),2) as 'Toplam Ciro'  from [Order Details] o

--Hangi kategoride kaç adet ürün bulunuyor.
Select c.CategoryName as [Kategori Adý],Count(p.ProductID) as 'Ürün Sayýsý' from Products p inner join Categories c 
on p.CategoryID=c.CategoryID
GROUP BY c.CategoryName
order by 2 desc

-- Hangi sipariþte toplam ne kadar kazanmýþýz. (Birim * Miktar) toplam kazancýmýz olarak hesaplayacaðýz ve büyükten küçüðe sýralayacaðýz.
SELECT  [Sipariþ Kodu] =  od.OrderID, SUM(od.UnitPrice*od.Quantity) as 'Toplam Kazanç' FROM [Order Details] od
GROUP BY od.OrderID
ORDER BY 2 DESC

-- Doðum günü bugün olan çalýþanlarýmýzýn ad,soyad ve doðum tarihini getiren sorguyu yazýnýz.
--(Önce Employees tablosuna doðum tarihi bugün olan bir kayýt ekleyin.)

Insert into Employees (FirstName,LastName,BirthDate) Values ('Emre Can','Ayar',CAST(GETDATE() as date))

Select e.FirstName,e.LastName,e.BirthDate from Employees e
Where  MONTH(e.BirthDate) = MONTH(GETDATE()) and DAY(e.BirthDate) = DAY(GETDATE())


-- 1996 yýlýnýn 12.ayýna ait sipariþleri listeleyelim.
Select o.OrderID,o.OrderDate,o.ShipCity,o.ShipCountry from Orders o 
Where Year(o.OrderDate) = 1996 AND MONTH(o.OrderDate) = 12
Order by o.OrderDate desc


-- Toplam tutarý 2500 ve 3500 arasýnda olan sipariþlerden, her bir sipariþteki ürün sayýsý 200 'den az olan ürünleri listeleyiniz.
-- Toplam Adet küçükten büyüðe doðru sýralansýn.
-- SipariþId,Toplam Adet,Toplam Sipariþ Tutarý
Select od.OrderID SipariþId,
SUM(od.Quantity) as 'Toplam Adet',
ROUND(SUM(od.UnitPrice*od.Quantity*(1-Discount)),2) 'Toplam Sipariþ Tutarý' from [Order Details] od
GROUP BY od.OrderID
HAVING ROUND(SUM(od.UnitPrice*od.Quantity*(1-Discount)),2) between 2500 and 3500 and SUM(od.Quantity) < 200
ORDER BY 2 asc