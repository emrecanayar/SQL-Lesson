-- �� ��e Sorgular (SUBQUERY) -- 

declare @MaxFiyat money = (Select MAX(UnitPrice) from Products)
Select * from Products Where UnitPrice = @MaxFiyat

-- SUB QUERY -- 
Select * from Products Where UnitPrice = (Select MAX(UnitPrice) from Products)

-- Fiyat� ortalama fiyat�n �st�nde olan �r�nler
Select * from Products Where UnitPrice > (Select AVG(UnitPrice) from Products)

-- �r�nler tablosundaki sat�lan �r�nlerin listelenmesi
Select * from Products Where ProductID in (Select ProductID  from [Order Details])

-- �r�nler tablosundaki sat�lmayan �r�nlerin listelenmesi
Select * from Products Where ProductID not in (Select ProductID  from [Order Details])

-- NOT : Sub Query lerde her zaman tek s�tun �a�r�labilir.

--�r�nlerin kategori isimlerinin getirilmesi
Select p.ProductName as '�r�n Ad�',p.UnitPrice Fiyat,p.UnitsInStock Stok,
(Select c.CategoryName from Categories c Where c.CategoryID = p.CategoryID) as [Kategori Ad�]
from Products p


-- Kargo �irketlerinin ta��d�klar� sipari� say�lar� -- 
Select ShipVia from Orders
Select * from Shippers Where ShipperID = 2

Select (Select s.CompanyName from Shippers s Where o.ShipVia =s.ShipperID) as [Kargo Firmas�],Count(*) as 'Sipari� Say�s�' from Orders o
GROUP BY o.ShipVia
ORDER BY 2 DESC

-- Exist i�erisinde kullan�m

-- Sipari� alan �al��anlar�m� getirelim.
Select * from Employees e Where exists (Select EmployeeID from Orders o Where o.EmployeeID = e.EmployeeID)

-- Sipari� alamayan �al��anlar�m� getirelim.
Select * from Employees e Where not exists (Select EmployeeID from Orders o Where o.EmployeeID = e.EmployeeID)

-- Not: In yaz�lan subquery den d�nen t�m kay�tlar i�in e�le�me yap�uld�ktan sonra Query �al��mas�n� tamamlar.

-- Exists ise SubQueryi e�le�me yap�lan kay�tlara g�re sonu�land�r�r ve ilave olarak gelen kay�tlar i�inde e�leme yapmaya gerek kalmaz. Exists zaten SubQueryden ihtiyac� olan verileri getirmi� olacakt�r.