/*
Tools => Options => Designers => Prevent Saving Changes (Tablo �zerinde de�i�iklik yapmaya izin verir.)
Tools => Options => Text Editor => All Language => Word Wrap (Ekrana s��mayan verileri otomatik olarak alt sat�ra al�r.)
Tools => Options => Text Editor => All Language => Show Visual Glyphs (Yukar�daki madde ile ba�lant�l�)
Tools => Options => Text Editor => All Language => Line Numbers (SSMS �zerinde sat�r numaralar� ��kart�yor.)

Ctrl + R Query Result (Result ekran�n� a�ar kapat�r.) 
Ctrl + Space Intellisense a��lmas� i�in k�sa yol.

*/

-- ZAMAN METOTLARI (FONKS�YONLARI) --
/*

YEAR		=> ��erisine parametre olarak datetime tipinde veri al�r ve bize o verinin y�l bilgisini d�ner.
MONTH	    => ��erisine parametre olarak datetime tipinde veri al�r ve bize o verinin ay bilgisini d�ner.
DAY			=> ��erisine parametre olarak datetime tipinde veri al�r ve bize o verinin g�n bilgisini d�ner.
GETDATE ()	=> �uan ki sistem tarihini ve saatini d�nd�r�r.

*/

-- AGGREGATE FUNCTIONS -- 
-- Aggregate Function'lar parametrede g�nderdi�imiz kolonun hesaplanm�� sonucunu bize d�nd�r�r.
/*

AVG		=> Ortalama almak i�in kullan�l�r. (Say�sal verilerde kullan�lmas� zorunludur.)
SUM		=> Toplama fonksiyonudur. Belirtilen kolondaki her veriyi toplayarak sonucunu bize d�nd�r�r. (Say�sal verilerde kullan�lmas� zorunludur.)
COUNT	=> Sayma fonksiyonudur. Belirtilen kolondaki her veriyi adet olarak sayar ve bize d�nd�r�r. (Say�sal verilerde kullan�lmas� zorunludur.)
MAX		=> Belirtilen kolondaki en b�y�k de�eri verir. (Say�sal verilerde kullan�lmas� zorunlu de�ildir.)
MIN		=> Belirtilen kolondaki en k���k de�eri verir. (Say�sal verilerde kullan�lmas� zorunlu de�ildir.)
ROUND	=> Yuvarlama i�in kullan�l�r. "," virg�lden sonraki de�erleri yuvarlar.

*/


--ROUND KULLANIMI--
declare @sayi float
select @sayi = 14.56985
Select ROUND(@sayi,2)


-- SQL Server'da veri tiplerini birbirlerine d�n��t�rmek i�in biz CAST ve CONVERT fonksiyonlar�n� kullan�r�z. A�a��da CAST ve CONVERT i�in yaz�lm�� syntax lar� g�rebilirsiniz.
-- CAST Kullan�m�	 => CAST(expression AS datatype(length))
-- CONVERT Kullan�m� => CONVERT(datatype(length),expression,style)

Select * from Products

Select '�r�n Kodu : '+CAST(p.ProductID as varchar)+ ' �r�n Ad�: '+p.ProductName as [�r�n Bilgisi] from Products p 
Select CAST(25.65 as int) -- Ondal�kl� say�y� tam say�ya �evirme
Select CAST(25.65 as varchar) + '5' -- Ondal�kl� say�y� metinsel formata �evirme
Select CAST('2017-08-25' as datetime) -- Metinsel de�eri tarihsel formata �evirme i�lemi

Select CONVERT(int,'123') + 5 -- Metinsel bir ifadeyi say�sal de�ere �evirme
Select CONVERT(varchar(30),GETDATE(),4) -- Tarihsel bir de�eri metinsel ifadeye �evirme.

-- Employees tablosuna Insert ile kendi kayd�n�z� ekleyiniz.
-- Ekledi�iniz bu kayd�n FirstName = '�stanbul' LastName='T�rkiye' olarak g�ncelleyiniz.
-- G�ncelleme i�lemi bittikten sonra ilgili kayd� siliniz.

Select * from Employees

Insert into Employees (FirstName,LastName) Values ('Emre Can','Ayar')

Update Employees Set FirstName = '�stanbul' , LastName = 'T�rkiye' Where EmployeeID = 20

Delete from Employees Where EmployeeID = 20


-- �r�nlerin toplam birim fiyat� ne kadard�r?
Select SUM(p.UnitPrice) as 'Toplam Fiyat' from Products p

--�irketim �imdiye kadar toplam ne kadar ciro yapm��?
Select  ROUND(SUM(o.UnitPrice * o.Quantity * (1-o.Discount)),2) as 'Toplam Ciro'  from [Order Details] o

--Hangi kategoride ka� adet �r�n bulunuyor.
Select c.CategoryName as [Kategori Ad�],Count(p.ProductID) as '�r�n Say�s�' from Products p inner join Categories c 
on p.CategoryID=c.CategoryID
GROUP BY c.CategoryName
order by 2 desc

-- Hangi sipari�te toplam ne kadar kazanm���z. (Birim * Miktar) toplam kazanc�m�z olarak hesaplayaca��z ve b�y�kten k����e s�ralayaca��z.
SELECT  [Sipari� Kodu] =  od.OrderID, SUM(od.UnitPrice*od.Quantity) as 'Toplam Kazan�' FROM [Order Details] od
GROUP BY od.OrderID
ORDER BY 2 DESC

-- Do�um g�n� bug�n olan �al��anlar�m�z�n ad,soyad ve do�um tarihini getiren sorguyu yaz�n�z.
--(�nce Employees tablosuna do�um tarihi bug�n olan bir kay�t ekleyin.)

Insert into Employees (FirstName,LastName,BirthDate) Values ('Emre Can','Ayar',CAST(GETDATE() as date))

Select e.FirstName,e.LastName,e.BirthDate from Employees e
Where  MONTH(e.BirthDate) = MONTH(GETDATE()) and DAY(e.BirthDate) = DAY(GETDATE())


-- 1996 y�l�n�n 12.ay�na ait sipari�leri listeleyelim.
Select o.OrderID,o.OrderDate,o.ShipCity,o.ShipCountry from Orders o 
Where Year(o.OrderDate) = 1996 AND MONTH(o.OrderDate) = 12
Order by o.OrderDate desc


-- Toplam tutar� 2500 ve 3500 aras�nda olan sipari�lerden, her bir sipari�teki �r�n say�s� 200 'den az olan �r�nleri listeleyiniz.
-- Toplam Adet k���kten b�y��e do�ru s�ralans�n.
-- Sipari�Id,Toplam Adet,Toplam Sipari� Tutar�
Select od.OrderID Sipari�Id,
SUM(od.Quantity) as 'Toplam Adet',
ROUND(SUM(od.UnitPrice*od.Quantity*(1-Discount)),2) 'Toplam Sipari� Tutar�' from [Order Details] od
GROUP BY od.OrderID
HAVING ROUND(SUM(od.UnitPrice*od.Quantity*(1-Discount)),2) between 2500 and 3500 and SUM(od.Quantity) < 200
ORDER BY 2 asc