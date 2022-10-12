--SORGULARI F�LTRELEMEK--

-- Yazd���m�z soruglar� belirli ko�ullara g�re filtreleyebilmek i�in WHERE c�mleci�ini kullan�r�z.

-- �al��anlar�n Unvan� Mr. olanlar�n listelenmesi. (Ad,Soyad,Unvan�)
Select FirstName,LastName,TitleOfCourtesy from Employees Where TitleOfCourtesy = 'Mr.'
--Not : SQL Server'da metinsel ifadeler tek t�rnak i�erisinde yaz�l�r.


-- EmployeeID de�eri 5 'ten b�y�k olan kay�tlar� listeleyelim. (Employees tablosunda)
Select EmployeeID as Id , Ad = FirstName, LastName as Soyad, TitleOfCourtesy 'Unvan' from Employees
Where EmployeeID > 5


-- 1960 y�l�nda do�an �al��anlar�n listelenmesi. (Ad, Soyad , Do�um Tarihi)
Select FirstName,LastName,BirthDate from Employees 
Where YEAR(BirthDate) = 1960 

-- YEAR(datetime parametre) fonksiyonu bizden datetime tipinde bir parametre de�eri al�r ve geriye o 
-- tarih bilgisinin sadece y�l�n� d�nd�r�r.

--1950 ve 1961 y�llar� aras�nda do�an �al��anlar� getirelim.
Select FirstName,LastName,BirthDate from Employees
Where YEAR(BirthDate) >= 1950 AND YEAR(BirthDate) <= 1961

-- �ngiltere'de oturan kad�nlar�n Ad�, Soyad�, Mesle�i, Unvan�, �lkesi ve Do�rum tarihlerini listeyelim.
Select FirstName as Ad,LastName as Soyad,Title Meslek,TitleOfCourtesy Unvan,Country �lke,
BirthDate 'Do�um Tarihi' from Employees
Where Country = 'UK' and (TitleOfCourtesy = 'Mrs.' or TitleOfCourtesy = 'Ms.')

-- Unvan� Mr. olanlar veya ya�� 60 ' tan b�y�k olanlar�n listelenmesi
-- Ya� hesaplamak i�in Bug�n�n y�l� - Do�um tarihindeki y�l
-- Select Getdate() => GETDATE() fonksiyonu ile SQL Server da bug�n�n tarihini alabiliriz.

Select CONCAT(TitleOfCourtesy,' ',FirstName, ' ',LastName) as 'Personal Info',
(YEAR(GETDATE()) - YEAR(BirthDate)) Age
from Employees 
Where TitleOfCourtesy = 'Mr.' OR (YEAR(GETDATE()) - YEAR(BirthDate)) > 60


-- NULL Verileri Sorgulamak
Select * from Employees

Select Region from Employees Where Region is null -- Region kolonundaki null verileri getirir.
Select Region from Employees Where Region is not null -- Region kolonundaki null olmayan verileri getirir.


-- B�lgesi belirtilmeyen �al��anlar�n listesi
Select TitleOfCourtesy,FirstName,LastName,Region from Employees
Where Region is null

-- B�lgesi belirtilen �al��anlar�n listesi
Select TitleOfCourtesy,FirstName,LastName,Region from Employees
Where Region is not null

--NOT : Null de�erler sorgulan�rken = veya <> gibi operat�rler kullan�lmaz. Bunun yerine IS NULL veya 
-- IS NOT NULL ifadeleri kullan�l�r.