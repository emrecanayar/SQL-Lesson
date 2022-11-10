-- GROUP BY Kullan�m� (Gruplamak)
-- B�y�k verileri analiz etme hususunda olduk�a kullan�lan bir komut.

-- �al��anlar�n �lkelerine g�re grupland�r�lmas�.
Select Country as �lke,COUNT(EmployeeID) as 'Ki�i Say�s�' from Employees
Where Country is not null
GROUP BY Country

-- �al��anlar�n yapm�� oldu�u sipari� adeti.
Select EmployeeID,COUNT(*) as 'Sipari� Adeti' from Orders
Where EmployeeID is not null
Group BY EmployeeID
Order By 2 desc


-- �r�n bedeli 35$ dan az olan �r�nlerin kategorilerine g�re gruplanmas�. (CategoryID ye g�re gruplayabilirsiniz.)
Select CategoryID,Count(*) as Adet from Products
Where CategoryID is not null and UnitPrice <= 35
Group By CategoryID
Order By 2 desc


-- Ba� harfi A-K aral���nda olan ve stok miktar� 5 ile 30 aras�nda olan �r�nleri kategorilerine g�re gruplay�n�z.
Select CategoryID,COUNT(*) as Adet from Products
Where ProductName like '[A-K]%' AND UnitsInStock Between 5 and 30
GROUP BY CategoryID
Order By 2 Desc


-- Her bir sipari�teki toplam �r�n say�s�n� bulunuz.
Select OrderID,SUM(Quantity) as 'Sat�lan �r�n Adedi' from [Order Details]
Group By OrderID
Order by 2 desc


-- Her bir sipari�in toplam tutar�na g�re listelenmesi
-- Tutar = UnitPrice * Quantiy * (1-Discount)
Select OrderID, SUM (UnitPrice*Quantity*(1-Discount)) as 'Toplam Tutar' from [Order Details]
GROUP BY OrderID
Order By 2 Desc


