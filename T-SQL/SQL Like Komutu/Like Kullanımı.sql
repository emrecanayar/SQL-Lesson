-- LIKE KULLANIMI --

-- I. YOL

Select FirstName,LastName,Title from Employees
Where FirstName = 'Michael'

-- II. YOL

Select FirstName,LastName,Title from Employees
Where FirstName LIKE 'Michael'

-- Adýnýn ilk harfi A ile baþlayan çalýþanlar
Select FirstName,LastName,Title from Employees
Where FirstName like 'A%'

-- Soyadýnýn son harfi N olanlar
Select FirstName,LastName,Title from Employees
Where LastName Like '%n'

-- Adýnýn içerisinde E harfi geçenler
Select FirstName,LastName,Title from Employees
Where FirstName like '%e%'

-- Adýnýn ilk harfi A veya L olanlar
-- I. Yol
Select FirstName,LastName,Title from Employees
Where FirstName like 'A%' or FirstName like 'L%'

-- II.Yol
Select FirstName,LastName,Title from Employees
Where FirstName LIKE '[AL]%'


-- Adýnýn içerisinde R veya T harfi bulunanlar
Select FirstName,LastName,Title from Employees
Where FirstName like '%[RT]%'


-- Adýnýn ilk harfi alfabetik olarak J ile R aralýðýnda olan çalýþanlar
Select FirstName, LastName,Title from Employees
Where FirstName Like '[J-R]%'
Order By FirstName


-- Adý þu þekilde olanlar : tAmEr,yAsEmin,tAnEr (A ile E arasýnda tek bir karakter olanlar)
Select FirstName,LastName,Title from Employees
Where FirstName like '%A_E%'


-- Adýnýn içerisinde A ile E arasýnda iki tane karakter olanlar
Select FirstName,LastName,Title from Employees
Where FirstName Like '%A__E%'


-- Adýnýn ilk harfi M olmayanlar

-- I.Yol

Select FirstName,LastName,Title from Employees
Where FirstName not like 'M%'

-- II.Yol

Select FirstName,LastName,Title from Employees
Where FirstName like '[^M]%'


-- Adý T ile bitmeyenler
Select FirstName,LastName,Title from Employees
Where FirstName like '%[^T]'


-- Adýnýn ilk harfi A ile I aralýðýnda bulunmayanlar. (2 yolla da yapalým.)
--I.Yol
Select FirstName,LastName,Title from Employees
Where FirstName NOT LIKE '[A-I]%'
Order By 1

-- II.Yol

Select FirstName,LastName,Title from Employees
Where FirstName Like '[^A-I]%'
ORDER BY 1


-- Adýnýn 2. harfi A veya T olmayanlar
Select FirstName,LastName,Title from Employees
Where FirstName Like '_[^AT]%'
ORDER BY 1


-- Adýnýn ilk iki harfi LA,LN,AA veya AN olanlar
Select FirstName,LastName,Title from Employees
Where FirstName Like '[LA][AN]%'

-- Ýlk karakter için L veya A'dan birini, 2. karakter içinde A veya N'den birini seçer ve olasýklar LA,LN,AA ve AN olur.

-- Ýçerisinde _ (alt-tire) geçen isimlerin listelenmesi
-- Normalde _ karakterinin özel bir anlamý vardýr ve tek bir karakter yerine geçer, ancak [] içinde belirttiðinizde sýradan bir karakter olarak aratabiliriz.

-- I. Yol
Select FirstName,LastName,Title from Employees
Where FirstName Like '%[_]%'

-- II.Yol
Select FirstName,LastName,Title from Employees
Where FirstName Like '%\_%' escape '\'


-- Customers tablosundan CustomerID'sinin 2.harfi A, 4.harfi T olanlarý top 5 getiren sorguyu yazýnýz.

Select CustomerID,CompanyName from Customers
Where CustomerID Like '_A_T%'