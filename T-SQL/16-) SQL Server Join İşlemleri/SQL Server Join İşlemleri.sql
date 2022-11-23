-- JOIN ÝÞLEMLERÝ -- 
-- Tek bir bütün olarak tasarlanmýþ verinin farklý tablolalardaki parçalarýný SELECT sorgusu ile birleþtirerek elde etmeye denir.
-- JOIN'in temel amacý farklý tablolardaki veriyi birleþtirerek tek bir SELECT sorgu sonucu olarak elde ebilmeyi saðlamaktadýr.
-- Birden fazla JOIN tipi vardýr ve her biri üzerinde farklý bir anlam üreterek verinin farklý bir bakýþ açýsýyla elde edilmesini saðlar.
-- Bir tablonun kendi üzerinde JOIN oluþturulabileceði gibi ikiden fazla tablo üzerinde de JOIN oluþturabilir.
-- JOIN performans açýsýndan iyi olmasa da yerini dolduracak baþka bir yöntem yoktur. Bu nedenle kullanýlmaktadýr.
-- JOIN raporlar, istatistiksel sorgular ve birbirleriye iliþkili veriye hýzlý bir bakýþ yapabilmeyi kolaylaþtýrýr.


-- INNER JOIN : Bir tablodaki her bir kaydýn diðer tabloda bir karþýlýðý olan kayýtlar listelenir. Inner join ifadesini yazarken Inner kelimesi yazmasak da (sadece Join yazarak) bu yine Inner Join olarak iþleme alýnýr.

Select p.ProductName,c.CategoryName from Products p INNER JOIN Categories c
on p.CategoryID = c.CategoryID


-- Products tablosundan ProductID,ProductName,CategoryID
-- Categories tablosundan CategoryName,Description  (INNER JOIN)

Select p.ProductID,p.ProductName,p.CategoryID,
c.CategoryName,c.Description
from Products p inner join Categories c 
on p.CategoryID = c.CategoryID

-- Not: Eðer seçtiðimiz sütunlar her iki tabloda da bulunuyorsa, o sütunu hangi tablodan seçtiðimizi ya da seçeceðimizi açýkça belirtmemiz gerekmektedir. (p.CategoryID gibi)

-- Hangi sipariþ, hangi çalýþan tarafýndan, hangi müþteriye yapulmýþtýr.

-- I.Yol

Select 
o.OrderID as 'Sipariþ No',o.OrderDate 'Sipariþ Tarihi',
c.CompanyName [Þirket Adý], [Yetkili Kiþi] = c.ContactName,
(e.FirstName + ' '+e.LastName) as 'Çalýþan Ad Soyad', e.Title Görev
from Orders o
inner join Employees e on o.EmployeeID = e.EmployeeID
inner join Customers c on o.CustomerID = c.CustomerID


-- II.Yol
Select o.OrderID as 'Sipariþ No',o.OrderDate 'Sipariþ Tarihi',
c.CompanyName [Þirket Adý] , [Yetkili Kiþi] = c.ContactName,
(e.FirstName + ' ' + e.LastName) as 'Çalýþan Ad Soyad', e.Title Görev
from Customers c
inner join Orders o on o.CustomerID = c.CustomerID
inner join Employees e on o.EmployeeID = e.EmployeeID

-- Not: Sorguyu kýsaltmak amacýyla tablo isimlerine de takma isim verilebilir, ancak dikkat edilmesi gereken nokta bir tabloya takma isim verildikten sonra artýk her yerde o ismin kullanýlmasý gerektiðidir.


-- Suppliers tablosundan CompanyName,ContactName
-- Products tablosundan ProductName,UnitPrice
-- Categories tablosundan CategoryName
-- CompanyName sütununa göre artan sýrada sýralayalým.

Select s.CompanyName,s.ContactName,
p.ProductName,p.UnitPrice,
c.CategoryName
from Categories c
inner join Products p on p.CategoryID = c.CategoryID
inner join Suppliers s on s.SupplierID = p.SupplierID
Order By 1 

-- Not: From'dan sonra sorguda geçen herhangi bir tabloyu belirtebiliriz, diðerlerini de daha sonra Join iþlemleri ile birleþtiriyoruz.


-- Kategorilere göre ürünlerin toplam stok miktarýný bulunuz.
Select c.CategoryName,SUM(p.UnitsInStock) as 'Toplam Stok' from Categories c 
inner join Products p on c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY 2 DESC


-- Her bir çalýþan toplam ne kadar satýþ yapmýþtýr.
Select Concat(e.FirstName,' ',e.LastName)  as Çalýþan,
ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)),2) as [Toplam Tutar]
from Employees e
inner join Orders o on e.EmployeeID = o.EmployeeID
inner join [Order Details] od on o.OrderID = od.OrderID
GROUP BY Concat(e.FirstName,' ',e.LastName)
ORDER BY 2 desc


-- 2-) OUTER JOIN
-- 2.1) LEFT OUTER JOIN : Sorguya katýlan tablolardan soldakinin tüm kayýtlarý getirilirken, saðdaki tabloda sadece iliþkili olan kayýtlar getirilir.

Select * from Products

-- Aþaðýdaki iþlem için Products tablosuna CategoryId bilgilisi olmayan ürün ekledik.
Select p.ProductName,c.CategoryName from Products p
left outer join Categories c
ON p.CategoryID = c.CategoryID


-- Her bir çalýþaný rapor verdiði kiþiyle birlikte listeyelim.
Select e1.FirstName,e1.LastName, (e2.FirstName+ ' ' +e2.LastName) Manager 
from Employees e1 inner join Employees e2
on e1.ReportsTo = e2.EmployeeID

-- Tüm çalýþanlarý ve eðer varsa müdürleriyle birlikte getirelim.
Select e1.FirstName,e1.LastName, (e2.FirstName+ ' ' +e2.LastName) Manager 
from Employees e1 left join Employees e2
on e1.ReportsTo = e2.EmployeeID

-- Not : Left Outer Join yerine kýsaca Left Join yazabiliriz.

-- 2.2) RIGHT OUTER JOIN : Sorguya katýlan tablolardan saðdakinin tüm kayýtlarý getirilirken, soldaki tabloda sadece iliþki kayýtlar getirilir.

Select * from Products
Select * from Categories

Select p.ProductName,c.CategoryName from Categories c Inner Join Products p on c.CategoryID = p.CategoryID

Select p.ProductName,c.CategoryName from Categories c Left Join Products p on c.CategoryID = p.CategoryID

Select p.ProductName,c.CategoryName from Categories c Right Join Products p on c.CategoryID = p.CategoryID

-- Her bir çalýþaný müdürüyle beraber listeleyelim.
Select
(e1.FirstName + ' '+ e1.LastName) as Müdür,
CONCAT(e2.FirstName,' ',e2.LastName) as Çalýþan
from Employees e1 right join Employees e2
on e1.EmployeeID = e2.ReportsTo

--Categories tablosuna 2 tane kayýt ekleyelim.
-- Categories ve Products tablosu arasýnda right join yapalým. (Ýlk tablo Products, ikinci tablo categories olsun)

Insert into Categories (CategoryName,[Description])
Values ('Right Join 3','Right Join Örnek 3'),('Right Join 4','Right Join Örnek 4')

Select c.CategoryName,p.ProductName from Products p right join Categories c on p.CategoryID = c.CategoryID

-- 2.3) FULL JOIN: Her iki tablodak, tüm kayýtlarý getirir. Left ve Right Join'in birleþimidir.

Select p.ProductName,c.CategoryName FROM  Categories c full join Products p On c.CategoryID = p.CategoryID

-- 2.4) CROSS JOIN : Bir tablodaki bir kaydýn diðer tablodaki tüm kayýtlarla eþleþtirilmesidir.

Select Count(*)  from Categories -- 18 Kayýt
Select Count(*)  from Products -- 80 Kayýt

Select CategoryName,ProductName from Categories cross join Products


-- Hangi kargo þirketine toplam ne kadar ödeme yapmýþým?
Select 
s.CompanyName as [Kargo Þirketi],
SUM(o.Freight) as [Ödenen Ücret]
from Shippers s inner join Orders o 
on s.ShipperID = o.ShipVia
GROUP BY s.CompanyName
Order by 2 desc


-- Sipariþ Adetleri 70 den fazla olan çalýþanlarýmýzý bulalým. (AdSoyad birleþik olsun, Toplam Sipariþ Adeti)
Select 
CONCAT(e.FirstName,' ', e.LastName) as Çalýþan,
COUNT(o.OrderID) as 'Toplam Sipariþ Adeti'
from Orders o inner join Employees e on o.EmployeeID = e.EmployeeID
GROUP BY CONCAT(e.FirstName,' ', e.LastName)
having COUNT(o.OrderID) > 70
ORDER BY 2 DESC


-- Kategoriler bazýnda ürünlerden elde ettiðim toplam gelirim ne kadar?
Select 
c.CategoryName as [Kategori Adý],
ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)),2) as 'Toplam Gelir'
from Categories c
inner join Products p on c.CategoryID = p.CategoryID
inner join [Order Details] od on od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY 2 DESC


-- Hangi ülkere ne kadarlýk satýþ yapmýþým?
Select 
c.Country Ülke,
ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)),2) as 'Toplam Gelir'
from Customers c
inner join Orders o on c.CustomerID = o.CustomerID
inner join [Order Details] od on o.OrderID = od.OrderID
GROUP BY c.Country
ORDER BY 2 DESC


-- 1998 yýlý mart ayýndaki sipariþlerimin adresi, sipariþi alan çalýþanýn adý, çalýþanýn soyadý
Select 
o.ShipAddress Adres,e.FirstName Ad,e.LastName Soyad
from Orders o inner join Employees e 
on o.EmployeeID = e.EmployeeID
Where YEAR(o.OrderDate) = 1998 AND MONTH(o.OrderDate) = 3


-- 1997 yýlýnda sipariþ veren müþterilerimin ContactName ve Telefon numarasýný listeleyelim.
Select distinct c.ContactName as 'Ýlgili Kiþi',c.Phone Telefon from Orders o 
inner join Customers c on o.CustomerID = c.CustomerID
Where YEAR(o.OrderDate) = 1997

-- 1997 yýlýnda verilen sipariþlerin tarihi, þehri, çalýþan adý-soyadý (Ad Soyad birleþik arada tire olacak ve hepsi büyük harf olacak)

Select o.OrderDate 'Sipariþ Tarihi',
o.ShipCity as Þehir,
UPPER(e.FirstName + '-' + e.LastName) as [Ad Soyad]
from Orders o inner join Employees e on o.EmployeeID = e.EmployeeID
Where YEAR(o.OrderDate) = 1997

-- En çok satýlan ürünümün (adet bazýnda) adý, kategorisinin adý ve tedarikçisin adýný listeleyim.
Select top 1
p.ProductName as 'Ürün Adý',
c.CategoryName as [Kategori Adý],
[Tedarikçi Adý] = s.CompanyName,
od.Quantity Adet
from [Order Details] od
inner join Products p on od.ProductID = p.ProductID
inner join Categories c on c.CategoryID = p.CategoryID
inner join Suppliers s on s.SupplierID = p.SupplierID
order by od.Quantity desc