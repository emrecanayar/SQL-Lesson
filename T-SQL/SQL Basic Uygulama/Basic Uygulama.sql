-- Basic Uygulama--

-- 100$ dan b�y�k �r�nlerin isimlerini getirelim.
Select ProductName,UnitPrice from Products
WHERE UnitPrice > 100
ORDER BY 2 DESC

-- Stok de�eri 10'un alt�nda olan �r�nlerin ad�, fiyat� ve stok bilgilerini getirelim.
Select ProductName,UnitPrice,UnitsInStock from Products
where UnitsInStock < 10
Order by 3 


-- Brazilya da bulunan tedarik�ilerin �irket Ad�, Temsilci Ad�, Adres, �ehir,�lke bilgilerini listeleyelim.
Select CompanyName,ContactName,Address,City,Country from Suppliers
Where Country = 'Brazil'


-- Londra ya da Paris te bulunan tedarik�iler
Select CompanyName,ContactName,Address,City,Country from Suppliers
Where City in ('London','Paris')


-- Ad� 'A' harfiyle ba�layan �al��anlar�n Ad, Soyad ve Do�um tarihlerini y�l baz�nda g�steriniz.

Select FirstName as Ad,LastName Soyad,[Do�um Tarihi]= YEAR(BirthDate) from Employees Where FirstName Like 'A%' 
 ORDER BY 3 DESC


 -- 50$ ile 100$ aras�nda bulunan t�m �r�nlerin adlar�n� ve fiyatlar�n� listeleyelim.
 Select ProductName,UnitPrice from Products
 Where UnitPrice between 50 and 100
 Order by 2 asc

 -- �r�nlerin stoklar� k���kten b�y��e do�ru s�ralans�n  ama fiyatlar�da en pahal�dan en ucuza do�ru g�sterilsin ve sonu� k�mesinde �r�n ad�, sto�u ve fiyat de�erleri listelensin

 Select ProductName,UnitsInStock,UnitPrice from Products
 Order By UnitsInStock asc, UnitPrice desc


 -- En pahal� 5 �r�n�n ad�n� ve fiyat�n� getirelim.
 Select Top 5 ProductName,UnitPrice from Products Order by UnitPrice Desc