-- Ýç Ýçe Sorgular (SUBQUERY) -- 

declare @MaxFiyat money = (Select MAX(UnitPrice) from Products)
Select * from Products Where UnitPrice = @MaxFiyat

-- SUB QUERY -- 
Select * from Products Where UnitPrice = (Select MAX(UnitPrice) from Products)

-- Fiyatý ortalama fiyatýn üstünde olan ürünler
Select * from Products Where UnitPrice > (Select AVG(UnitPrice) from Products)

-- Ürünler tablosundaki satýlan ürünlerin listelenmesi
Select * from Products Where ProductID in (Select ProductID  from [Order Details])

-- Ürünler tablosundaki satýlmayan ürünlerin listelenmesi
Select * from Products Where ProductID not in (Select ProductID  from [Order Details])

-- NOT : Sub Query lerde her zaman tek sütun çaðrýlabilir.

--Ürünlerin kategori isimlerinin getirilmesi
Select p.ProductName as 'Ürün Adý',p.UnitPrice Fiyat,p.UnitsInStock Stok,
(Select c.CategoryName from Categories c Where c.CategoryID = p.CategoryID) as [Kategori Adý]
from Products p


-- Kargo þirketlerinin taþýdýklarý sipariþ sayýlarý -- 
Select ShipVia from Orders
Select * from Shippers Where ShipperID = 2

Select (Select s.CompanyName from Shippers s Where o.ShipVia =s.ShipperID) as [Kargo Firmasý],Count(*) as 'Sipariþ Sayýsý' from Orders o
GROUP BY o.ShipVia
ORDER BY 2 DESC

-- Exist içerisinde kullaným

-- Sipariþ alan çalýþanlarýmý getirelim.
Select * from Employees e Where exists (Select EmployeeID from Orders o Where o.EmployeeID = e.EmployeeID)

-- Sipariþ alamayan çalýþanlarýmý getirelim.
Select * from Employees e Where not exists (Select EmployeeID from Orders o Where o.EmployeeID = e.EmployeeID)

-- Not: In yazýlan subquery den dönen tüm kayýtlar için eþleþme yapýuldýktan sonra Query çalýþmasýný tamamlar.

-- Exists ise SubQueryi eþleþme yapýlan kayýtlara göre sonuçlandýrýr ve ilave olarak gelen kayýtlar içinde eþleme yapmaya gerek kalmaz. Exists zaten SubQueryden ihtiyacý olan verileri getirmiþ olacaktýr.