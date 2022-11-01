-- SQL Server Tarih Fonksiyonlar� --

-- DATEPART() Kullan�m� : Bir tarih(datetime) bilgisinden istedi�imiz k�sm� elde etmemize yarar.

Select FirstName,LastName, DATEPART(YY,BirthDate) as 'Year' from Employees
ORDER BY 'Year' DESC -- DateTime veri tipinden Y�l bilgisini almak.

-- Y�l bilgisinin 2.Yolu
Select FirstName,LastName, YEAR(BirthDate) as 'Year' from Employees
ORDER BY 'Year' DESC -- DateTime veri tipinden Y�l bilgisini almak.

Select FirstName,LastName, DATEPART(DY,BirthDate) as 'Day Of Year' from Employees
Order By 'Day Of Year' Desc -- Datetime veri tipinden y�l�n ka��nc� g�n oldu�unun bilgisini almak.

Select FirstName,LastName, DATEPART(M,BirthDate) as 'Month' from Employees
Order By 'Month' Desc -- DateTime veri tipinden Y�l�n kac�nc� ay oldu�unun bilgisini almak.

-- Ay bilgisinin 2.Yolu
Select FirstName,LastName, Month(BirthDate) as 'Month' from Employees
Order By 'Month' Desc

Select FirstName,LastName, DATEPART(WK,BirthDate) as 'Week Of Year' from Employees
Order By 'Week Of Year' Desc -- DateTime veri tipinden y�l�n ka��nc� haftas� oldu�unun bilgisini almak.

Select FirstName,LastName, DATEPART(DW,BirthDate) as 'Day Of Week' from Employees
Order By 'Day Of Week' Desc -- DateTime veri tipinden haftan�n ka��nc� g�n oldu�unun bilgisini almak.

Select FirstName,LastName, DATEPART(HH,GETDATE()) as 'Hour' from Employees
Order By 'Hour' Desc -- DateTime veri tipinden saat bilgisini almak.

Select FirstName,LastName, DATEPART(MI,GETDATE()) as 'Minute' from Employees
Order By 'Minute' Desc -- DateTime veri tipinden dakika bilgisini almak.

Select FirstName,LastName, DATEPART(SS,GETDATE()) as 'Saniye' from Employees
Order By 'Saniye' Desc -- DateTime veri tipinden saniye bilgisini almak.

Select FirstName,LastName, DATEPART(MS,GETDATE()) as 'Salise' from Employees
Order By 'Salise' Desc -- DateTime veri tipinden salise bilgisini almak.


--DATEDIFF() Kullan�m� : �ki tarih aras�ndaki fark� bize veriyor.

Select (FirstName + ' '+ LastName) as 'Ad Soyad',
DATEDIFF(YEAR,BirthDate,GETDATE()) As Ya�,
DATEDIFF(DAY,HireDate,GETDATE()) as '�denen Prim'
from Employees

-- Employess tablosundaki insanlar�n ka� saat ya�ad���n� bulal�m.
Select (FirstName + ' '+ LastName) as 'Ad Soyad',
DATEDIFF(HOUR,BirthDate,GETDATE()) as [Ka� Saat Ge�ti]
from Employees