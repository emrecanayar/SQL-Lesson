-- GROUP BY Kullanýmý (Gruplamak)
-- Büyük verileri analiz etme hususunda oldukça kullanýlan bir komut.

-- Çalýþanlarýn ülkelerine göre gruplandýrýlmasý.
Select Country as Ülke,COUNT(EmployeeID) as 'Kiþi Sayýsý' from Employees
Where Country is not null
GROUP BY Country

-- Çalýþanlarýn yapmýþ olduðu sipariþ adeti.
Select EmployeeID,COUNT(*) as 'Sipariþ Adeti' from Orders
Where EmployeeID is not null
Group BY EmployeeID
Order By 2 desc


-- Ürün bedeli 35$ dan az olan ürünlerin kategorilerine göre gruplanmasý. (CategoryID ye göre gruplayabilirsiniz.)
Select CategoryID,Count(*) as Adet from Products
Where CategoryID is not null and UnitPrice <= 35
Group By CategoryID
Order By 2 desc


-- Baþ harfi A-K aralýðýnda olan ve stok miktarý 5 ile 30 arasýnda olan ürünleri kategorilerine göre gruplayýnýz.
Select CategoryID,COUNT(*) as Adet from Products
Where ProductName like '[A-K]%' AND UnitsInStock Between 5 and 30
GROUP BY CategoryID
Order By 2 Desc


-- Her bir sipariþteki toplam ürün sayýsýný bulunuz.
Select OrderID,SUM(Quantity) as 'Satýlan Ürün Adedi' from [Order Details]
Group By OrderID
Order by 2 desc


-- Her bir sipariþin toplam tutarýna göre listelenmesi
-- Tutar = UnitPrice * Quantiy * (1-Discount)
Select OrderID, SUM (UnitPrice*Quantity*(1-Discount)) as 'Toplam Tutar' from [Order Details]
GROUP BY OrderID
Order By 2 Desc


