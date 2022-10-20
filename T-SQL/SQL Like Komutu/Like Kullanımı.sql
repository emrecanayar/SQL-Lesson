-- LIKE KULLANIMI --

-- I. YOL

Select FirstName,LastName,Title from Employees
Where FirstName = 'Michael'

-- II. YOL

Select FirstName,LastName,Title from Employees
Where FirstName LIKE 'Michael'

-- Ad�n�n ilk harfi A ile ba�layan �al��anlar
Select FirstName,LastName,Title from Employees
Where FirstName like 'A%'

-- Soyad�n�n son harfi N olanlar
Select FirstName,LastName,Title from Employees
Where LastName Like '%n'

-- Ad�n�n i�erisinde E harfi ge�enler
Select FirstName,LastName,Title from Employees
Where FirstName like '%e%'

-- Ad�n�n ilk harfi A veya L olanlar
-- I. Yol
Select FirstName,LastName,Title from Employees
Where FirstName like 'A%' or FirstName like 'L%'

-- II.Yol
Select FirstName,LastName,Title from Employees
Where FirstName LIKE '[AL]%'


-- Ad�n�n i�erisinde R veya T harfi bulunanlar
Select FirstName,LastName,Title from Employees
Where FirstName like '%[RT]%'


-- Ad�n�n ilk harfi alfabetik olarak J ile R aral���nda olan �al��anlar
Select FirstName, LastName,Title from Employees
Where FirstName Like '[J-R]%'
Order By FirstName


-- Ad� �u �ekilde olanlar : tAmEr,yAsEmin,tAnEr (A ile E aras�nda tek bir karakter olanlar)
Select FirstName,LastName,Title from Employees
Where FirstName like '%A_E%'


-- Ad�n�n i�erisinde A ile E aras�nda iki tane karakter olanlar
Select FirstName,LastName,Title from Employees
Where FirstName Like '%A__E%'


-- Ad�n�n ilk harfi M olmayanlar

-- I.Yol

Select FirstName,LastName,Title from Employees
Where FirstName not like 'M%'

-- II.Yol

Select FirstName,LastName,Title from Employees
Where FirstName like '[^M]%'


-- Ad� T ile bitmeyenler
Select FirstName,LastName,Title from Employees
Where FirstName like '%[^T]'


-- Ad�n�n ilk harfi A ile I aral���nda bulunmayanlar. (2 yolla da yapal�m.)
--I.Yol
Select FirstName,LastName,Title from Employees
Where FirstName NOT LIKE '[A-I]%'
Order By 1

-- II.Yol

Select FirstName,LastName,Title from Employees
Where FirstName Like '[^A-I]%'
ORDER BY 1


-- Ad�n�n 2. harfi A veya T olmayanlar
Select FirstName,LastName,Title from Employees
Where FirstName Like '_[^AT]%'
ORDER BY 1


-- Ad�n�n ilk iki harfi LA,LN,AA veya AN olanlar
Select FirstName,LastName,Title from Employees
Where FirstName Like '[LA][AN]%'

-- �lk karakter i�in L veya A'dan birini, 2. karakter i�inde A veya N'den birini se�er ve olas�klar LA,LN,AA ve AN olur.

-- ��erisinde _ (alt-tire) ge�en isimlerin listelenmesi
-- Normalde _ karakterinin �zel bir anlam� vard�r ve tek bir karakter yerine ge�er, ancak [] i�inde belirtti�inizde s�radan bir karakter olarak aratabiliriz.

-- I. Yol
Select FirstName,LastName,Title from Employees
Where FirstName Like '%[_]%'

-- II.Yol
Select FirstName,LastName,Title from Employees
Where FirstName Like '%\_%' escape '\'


-- Customers tablosundan CustomerID'sinin 2.harfi A, 4.harfi T olanlar� top 5 getiren sorguyu yaz�n�z.

Select CustomerID,CompanyName from Customers
Where CustomerID Like '_A_T%'