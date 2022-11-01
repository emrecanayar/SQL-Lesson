-- SQL Server Tarih Fonksiyonlarý --

-- DATEPART() Kullanýmý : Bir tarih(datetime) bilgisinden istediðimiz kýsmý elde etmemize yarar.

Select FirstName,LastName, DATEPART(YY,BirthDate) as 'Year' from Employees
ORDER BY 'Year' DESC -- DateTime veri tipinden Yýl bilgisini almak.

-- Yýl bilgisinin 2.Yolu
Select FirstName,LastName, YEAR(BirthDate) as 'Year' from Employees
ORDER BY 'Year' DESC -- DateTime veri tipinden Yýl bilgisini almak.

Select FirstName,LastName, DATEPART(DY,BirthDate) as 'Day Of Year' from Employees
Order By 'Day Of Year' Desc -- Datetime veri tipinden yýlýn kaçýncý gün olduðunun bilgisini almak.

Select FirstName,LastName, DATEPART(M,BirthDate) as 'Month' from Employees
Order By 'Month' Desc -- DateTime veri tipinden Yýlýn kacýncý ay olduðunun bilgisini almak.

-- Ay bilgisinin 2.Yolu
Select FirstName,LastName, Month(BirthDate) as 'Month' from Employees
Order By 'Month' Desc

Select FirstName,LastName, DATEPART(WK,BirthDate) as 'Week Of Year' from Employees
Order By 'Week Of Year' Desc -- DateTime veri tipinden yýlýn kaçýncý haftasý olduðunun bilgisini almak.

Select FirstName,LastName, DATEPART(DW,BirthDate) as 'Day Of Week' from Employees
Order By 'Day Of Week' Desc -- DateTime veri tipinden haftanýn kaçýncý gün olduðunun bilgisini almak.

Select FirstName,LastName, DATEPART(HH,GETDATE()) as 'Hour' from Employees
Order By 'Hour' Desc -- DateTime veri tipinden saat bilgisini almak.

Select FirstName,LastName, DATEPART(MI,GETDATE()) as 'Minute' from Employees
Order By 'Minute' Desc -- DateTime veri tipinden dakika bilgisini almak.

Select FirstName,LastName, DATEPART(SS,GETDATE()) as 'Saniye' from Employees
Order By 'Saniye' Desc -- DateTime veri tipinden saniye bilgisini almak.

Select FirstName,LastName, DATEPART(MS,GETDATE()) as 'Salise' from Employees
Order By 'Salise' Desc -- DateTime veri tipinden salise bilgisini almak.


--DATEDIFF() Kullanýmý : Ýki tarih arasýndaki farký bize veriyor.

Select (FirstName + ' '+ LastName) as 'Ad Soyad',
DATEDIFF(YEAR,BirthDate,GETDATE()) As Yaþ,
DATEDIFF(DAY,HireDate,GETDATE()) as 'Ödenen Prim'
from Employees

-- Employess tablosundaki insanlarýn kaç saat yaþadýðýný bulalým.
Select (FirstName + ' '+ LastName) as 'Ad Soyad',
DATEDIFF(HOUR,BirthDate,GETDATE()) as [Kaç Saat Geçti]
from Employees