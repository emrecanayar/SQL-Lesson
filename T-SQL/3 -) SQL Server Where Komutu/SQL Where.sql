--SORGULARI FÝLTRELEMEK--

-- Yazdýðýmýz soruglarý belirli koþullara göre filtreleyebilmek için WHERE cümleciðini kullanýrýz.

-- Çalýþanlarýn Unvaný Mr. olanlarýn listelenmesi. (Ad,Soyad,Unvaný)
Select FirstName,LastName,TitleOfCourtesy from Employees Where TitleOfCourtesy = 'Mr.'
--Not : SQL Server'da metinsel ifadeler tek týrnak içerisinde yazýlýr.


-- EmployeeID deðeri 5 'ten büyük olan kayýtlarý listeleyelim. (Employees tablosunda)
Select EmployeeID as Id , Ad = FirstName, LastName as Soyad, TitleOfCourtesy 'Unvan' from Employees
Where EmployeeID > 5


-- 1960 yýlýnda doðan çalýþanlarýn listelenmesi. (Ad, Soyad , Doðum Tarihi)
Select FirstName,LastName,BirthDate from Employees 
Where YEAR(BirthDate) = 1960 

-- YEAR(datetime parametre) fonksiyonu bizden datetime tipinde bir parametre deðeri alýr ve geriye o 
-- tarih bilgisinin sadece yýlýný döndürür.

--1950 ve 1961 yýllarý arasýnda doðan çalýþanlarý getirelim.
Select FirstName,LastName,BirthDate from Employees
Where YEAR(BirthDate) >= 1950 AND YEAR(BirthDate) <= 1961

-- Ýngiltere'de oturan kadýnlarýn Adý, Soyadý, Mesleði, Unvaný, Ülkesi ve Doðrum tarihlerini listeyelim.
Select FirstName as Ad,LastName as Soyad,Title Meslek,TitleOfCourtesy Unvan,Country Ülke,
BirthDate 'Doðum Tarihi' from Employees
Where Country = 'UK' and (TitleOfCourtesy = 'Mrs.' or TitleOfCourtesy = 'Ms.')

-- Unvaný Mr. olanlar veya yaþý 60 ' tan büyük olanlarýn listelenmesi
-- Yaþ hesaplamak için Bugünün yýlý - Doðum tarihindeki yýl
-- Select Getdate() => GETDATE() fonksiyonu ile SQL Server da bugünün tarihini alabiliriz.

Select CONCAT(TitleOfCourtesy,' ',FirstName, ' ',LastName) as 'Personal Info',
(YEAR(GETDATE()) - YEAR(BirthDate)) Age
from Employees 
Where TitleOfCourtesy = 'Mr.' OR (YEAR(GETDATE()) - YEAR(BirthDate)) > 60


-- NULL Verileri Sorgulamak
Select * from Employees

Select Region from Employees Where Region is null -- Region kolonundaki null verileri getirir.
Select Region from Employees Where Region is not null -- Region kolonundaki null olmayan verileri getirir.


-- Bölgesi belirtilmeyen çalýþanlarýn listesi
Select TitleOfCourtesy,FirstName,LastName,Region from Employees
Where Region is null

-- Bölgesi belirtilen çalýþanlarýn listesi
Select TitleOfCourtesy,FirstName,LastName,Region from Employees
Where Region is not null

--NOT : Null deðerler sorgulanýrken = veya <> gibi operatörler kullanýlmaz. Bunun yerine IS NULL veya 
-- IS NOT NULL ifadeleri kullanýlýr.