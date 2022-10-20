-- Basic Uygulama--

-- 100$ dan büyük ürünlerin isimlerini getirelim.
Select ProductName,UnitPrice from Products
WHERE UnitPrice > 100
ORDER BY 2 DESC

-- Stok deðeri 10'un altýnda olan ürünlerin adý, fiyatý ve stok bilgilerini getirelim.
Select ProductName,UnitPrice,UnitsInStock from Products
where UnitsInStock < 10
Order by 3 


-- Brazilya da bulunan tedarikçilerin Þirket Adý, Temsilci Adý, Adres, Þehir,Ülke bilgilerini listeleyelim.
Select CompanyName,ContactName,Address,City,Country from Suppliers
Where Country = 'Brazil'


-- Londra ya da Paris te bulunan tedarikçiler
Select CompanyName,ContactName,Address,City,Country from Suppliers
Where City in ('London','Paris')


-- Adý 'A' harfiyle baþlayan çalýþanlarýn Ad, Soyad ve Doðum tarihlerini yýl bazýnda gösteriniz.

Select FirstName as Ad,LastName Soyad,[Doðum Tarihi]= YEAR(BirthDate) from Employees Where FirstName Like 'A%' 
 ORDER BY 3 DESC


 -- 50$ ile 100$ arasýnda bulunan tüm ürünlerin adlarýný ve fiyatlarýný listeleyelim.
 Select ProductName,UnitPrice from Products
 Where UnitPrice between 50 and 100
 Order by 2 asc

 -- Ürünlerin stoklarý küçükten büyüðe doðru sýralansýn  ama fiyatlarýda en pahalýdan en ucuza doðru gösterilsin ve sonuç kðmesinde Ürün adý, stoðu ve fiyat deðerleri listelensin

 Select ProductName,UnitsInStock,UnitPrice from Products
 Order By UnitsInStock asc, UnitPrice desc


 -- En pahalý 5 ürünün adýný ve fiyatýný getirelim.
 Select Top 5 ProductName,UnitPrice from Products Order by UnitPrice Desc