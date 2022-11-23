-- JOIN ��LEMLER� -- 
-- Tek bir b�t�n olarak tasarlanm�� verinin farkl� tablolalardaki par�alar�n� SELECT sorgusu ile birle�tirerek elde etmeye denir.
-- JOIN'in temel amac� farkl� tablolardaki veriyi birle�tirerek tek bir SELECT sorgu sonucu olarak elde ebilmeyi sa�lamaktad�r.
-- Birden fazla JOIN tipi vard�r ve her biri �zerinde farkl� bir anlam �reterek verinin farkl� bir bak�� a��s�yla elde edilmesini sa�lar.
-- Bir tablonun kendi �zerinde JOIN olu�turulabilece�i gibi ikiden fazla tablo �zerinde de JOIN olu�turabilir.
-- JOIN performans a��s�ndan iyi olmasa da yerini dolduracak ba�ka bir y�ntem yoktur. Bu nedenle kullan�lmaktad�r.
-- JOIN raporlar, istatistiksel sorgular ve birbirleriye ili�kili veriye h�zl� bir bak�� yapabilmeyi kolayla�t�r�r.


-- INNER JOIN : Bir tablodaki her bir kayd�n di�er tabloda bir kar��l��� olan kay�tlar listelenir. Inner join ifadesini yazarken Inner kelimesi yazmasak da (sadece Join yazarak) bu yine Inner Join olarak i�leme al�n�r.

Select p.ProductName,c.CategoryName from Products p INNER JOIN Categories c
on p.CategoryID = c.CategoryID


-- Products tablosundan ProductID,ProductName,CategoryID
-- Categories tablosundan CategoryName,Description  (INNER JOIN)

Select p.ProductID,p.ProductName,p.CategoryID,
c.CategoryName,c.Description
from Products p inner join Categories c 
on p.CategoryID = c.CategoryID

-- Not: E�er se�ti�imiz s�tunlar her iki tabloda da bulunuyorsa, o s�tunu hangi tablodan se�ti�imizi ya da se�ece�imizi a��k�a belirtmemiz gerekmektedir. (p.CategoryID gibi)

-- Hangi sipari�, hangi �al��an taraf�ndan, hangi m��teriye yapulm��t�r.

-- I.Yol

Select 
o.OrderID as 'Sipari� No',o.OrderDate 'Sipari� Tarihi',
c.CompanyName [�irket Ad�], [Yetkili Ki�i] = c.ContactName,
(e.FirstName + ' '+e.LastName) as '�al��an Ad Soyad', e.Title G�rev
from Orders o
inner join Employees e on o.EmployeeID = e.EmployeeID
inner join Customers c on o.CustomerID = c.CustomerID


-- II.Yol
Select o.OrderID as 'Sipari� No',o.OrderDate 'Sipari� Tarihi',
c.CompanyName [�irket Ad�] , [Yetkili Ki�i] = c.ContactName,
(e.FirstName + ' ' + e.LastName) as '�al��an Ad Soyad', e.Title G�rev
from Customers c
inner join Orders o on o.CustomerID = c.CustomerID
inner join Employees e on o.EmployeeID = e.EmployeeID

-- Not: Sorguyu k�saltmak amac�yla tablo isimlerine de takma isim verilebilir, ancak dikkat edilmesi gereken nokta bir tabloya takma isim verildikten sonra art�k her yerde o ismin kullan�lmas� gerekti�idir.


-- Suppliers tablosundan CompanyName,ContactName
-- Products tablosundan ProductName,UnitPrice
-- Categories tablosundan CategoryName
-- CompanyName s�tununa g�re artan s�rada s�ralayal�m.

Select s.CompanyName,s.ContactName,
p.ProductName,p.UnitPrice,
c.CategoryName
from Categories c
inner join Products p on p.CategoryID = c.CategoryID
inner join Suppliers s on s.SupplierID = p.SupplierID
Order By 1 

-- Not: From'dan sonra sorguda ge�en herhangi bir tabloyu belirtebiliriz, di�erlerini de daha sonra Join i�lemleri ile birle�tiriyoruz.


-- Kategorilere g�re �r�nlerin toplam stok miktar�n� bulunuz.
Select c.CategoryName,SUM(p.UnitsInStock) as 'Toplam Stok' from Categories c 
inner join Products p on c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY 2 DESC


-- Her bir �al��an toplam ne kadar sat�� yapm��t�r.
Select Concat(e.FirstName,' ',e.LastName)  as �al��an,
ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)),2) as [Toplam Tutar]
from Employees e
inner join Orders o on e.EmployeeID = o.EmployeeID
inner join [Order Details] od on o.OrderID = od.OrderID
GROUP BY Concat(e.FirstName,' ',e.LastName)
ORDER BY 2 desc


-- 2-) OUTER JOIN
-- 2.1) LEFT OUTER JOIN : Sorguya kat�lan tablolardan soldakinin t�m kay�tlar� getirilirken, sa�daki tabloda sadece ili�kili olan kay�tlar getirilir.

Select * from Products

-- A�a��daki i�lem i�in Products tablosuna CategoryId bilgilisi olmayan �r�n ekledik.
Select p.ProductName,c.CategoryName from Products p
left outer join Categories c
ON p.CategoryID = c.CategoryID


-- Her bir �al��an� rapor verdi�i ki�iyle birlikte listeyelim.
Select e1.FirstName,e1.LastName, (e2.FirstName+ ' ' +e2.LastName) Manager 
from Employees e1 inner join Employees e2
on e1.ReportsTo = e2.EmployeeID

-- T�m �al��anlar� ve e�er varsa m�d�rleriyle birlikte getirelim.
Select e1.FirstName,e1.LastName, (e2.FirstName+ ' ' +e2.LastName) Manager 
from Employees e1 left join Employees e2
on e1.ReportsTo = e2.EmployeeID

-- Not : Left Outer Join yerine k�saca Left Join yazabiliriz.

-- 2.2) RIGHT OUTER JOIN : Sorguya kat�lan tablolardan sa�dakinin t�m kay�tlar� getirilirken, soldaki tabloda sadece ili�ki kay�tlar getirilir.

Select * from Products
Select * from Categories

Select p.ProductName,c.CategoryName from Categories c Inner Join Products p on c.CategoryID = p.CategoryID

Select p.ProductName,c.CategoryName from Categories c Left Join Products p on c.CategoryID = p.CategoryID

Select p.ProductName,c.CategoryName from Categories c Right Join Products p on c.CategoryID = p.CategoryID

-- Her bir �al��an� m�d�r�yle beraber listeleyelim.
Select
(e1.FirstName + ' '+ e1.LastName) as M�d�r,
CONCAT(e2.FirstName,' ',e2.LastName) as �al��an
from Employees e1 right join Employees e2
on e1.EmployeeID = e2.ReportsTo

--Categories tablosuna 2 tane kay�t ekleyelim.
-- Categories ve Products tablosu aras�nda right join yapal�m. (�lk tablo Products, ikinci tablo categories olsun)

Insert into Categories (CategoryName,[Description])
Values ('Right Join 3','Right Join �rnek 3'),('Right Join 4','Right Join �rnek 4')

Select c.CategoryName,p.ProductName from Products p right join Categories c on p.CategoryID = c.CategoryID

-- 2.3) FULL JOIN: Her iki tablodak, t�m kay�tlar� getirir. Left ve Right Join'in birle�imidir.

Select p.ProductName,c.CategoryName FROM  Categories c full join Products p On c.CategoryID = p.CategoryID

-- 2.4) CROSS JOIN : Bir tablodaki bir kayd�n di�er tablodaki t�m kay�tlarla e�le�tirilmesidir.

Select Count(*)  from Categories -- 18 Kay�t
Select Count(*)  from Products -- 80 Kay�t

Select CategoryName,ProductName from Categories cross join Products


-- Hangi kargo �irketine toplam ne kadar �deme yapm���m?
Select 
s.CompanyName as [Kargo �irketi],
SUM(o.Freight) as [�denen �cret]
from Shippers s inner join Orders o 
on s.ShipperID = o.ShipVia
GROUP BY s.CompanyName
Order by 2 desc


-- Sipari� Adetleri 70 den fazla olan �al��anlar�m�z� bulal�m. (AdSoyad birle�ik olsun, Toplam Sipari� Adeti)
Select 
CONCAT(e.FirstName,' ', e.LastName) as �al��an,
COUNT(o.OrderID) as 'Toplam Sipari� Adeti'
from Orders o inner join Employees e on o.EmployeeID = e.EmployeeID
GROUP BY CONCAT(e.FirstName,' ', e.LastName)
having COUNT(o.OrderID) > 70
ORDER BY 2 DESC


-- Kategoriler baz�nda �r�nlerden elde etti�im toplam gelirim ne kadar?
Select 
c.CategoryName as [Kategori Ad�],
ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)),2) as 'Toplam Gelir'
from Categories c
inner join Products p on c.CategoryID = p.CategoryID
inner join [Order Details] od on od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY 2 DESC


-- Hangi �lkere ne kadarl�k sat�� yapm���m?
Select 
c.Country �lke,
ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)),2) as 'Toplam Gelir'
from Customers c
inner join Orders o on c.CustomerID = o.CustomerID
inner join [Order Details] od on o.OrderID = od.OrderID
GROUP BY c.Country
ORDER BY 2 DESC


-- 1998 y�l� mart ay�ndaki sipari�lerimin adresi, sipari�i alan �al��an�n ad�, �al��an�n soyad�
Select 
o.ShipAddress Adres,e.FirstName Ad,e.LastName Soyad
from Orders o inner join Employees e 
on o.EmployeeID = e.EmployeeID
Where YEAR(o.OrderDate) = 1998 AND MONTH(o.OrderDate) = 3


-- 1997 y�l�nda sipari� veren m��terilerimin ContactName ve Telefon numaras�n� listeleyelim.
Select distinct c.ContactName as '�lgili Ki�i',c.Phone Telefon from Orders o 
inner join Customers c on o.CustomerID = c.CustomerID
Where YEAR(o.OrderDate) = 1997

-- 1997 y�l�nda verilen sipari�lerin tarihi, �ehri, �al��an ad�-soyad� (Ad Soyad birle�ik arada tire olacak ve hepsi b�y�k harf olacak)

Select o.OrderDate 'Sipari� Tarihi',
o.ShipCity as �ehir,
UPPER(e.FirstName + '-' + e.LastName) as [Ad Soyad]
from Orders o inner join Employees e on o.EmployeeID = e.EmployeeID
Where YEAR(o.OrderDate) = 1997

-- En �ok sat�lan �r�n�m�n (adet baz�nda) ad�, kategorisinin ad� ve tedarik�isin ad�n� listeleyim.
Select top 1
p.ProductName as '�r�n Ad�',
c.CategoryName as [Kategori Ad�],
[Tedarik�i Ad�] = s.CompanyName,
od.Quantity Adet
from [Order Details] od
inner join Products p on od.ProductID = p.ProductID
inner join Categories c on c.CategoryID = p.CategoryID
inner join Suppliers s on s.SupplierID = p.SupplierID
order by od.Quantity desc