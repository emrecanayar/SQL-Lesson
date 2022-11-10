--CASE - WHEN - THEN Kullan�m�

Select FirstName as Ad,Soyad = LastName,Title as G�rev,Country as �lke from Employees

--CASE - WHEN - THEN kullan�m� a�a��daki gibidir.
-- Case i�erisine hangi alan i�in �artlar belirteceksek onu yaz�yoruz.
-- Daha sonra WHEN anahtar kelimesi ile Case i�erisinde belirtti�imiz alan�n veri taban�nda bulunan de�erlerini belirtiyoruz. (Mant�ksal i�lemlerde yap�labilir.)
-- THEN ise veri taban�nda bulunan de�erin kar��l���n� belirtti�imiz aland�r. (Yani veri taban�nda USA ise ekranda Amerika Birle�ik Devletleri olsun dedi�imiz aland�r.)

Select FirstName,LastName,
CASE (Country)
When 'USA'
THEN 'Amerika Birle�ik Devletleri'
When 'UK'
THEN '�ngiltere Birle�ik Krall���'
ELSE '�lkesi Belirtilmedi'
END AS Country
from Employees


-- Mant�ksal i�lem i�eren CASE - WHEN - THEN
Select 
EmployeeID,FirstName,LastName,
CASE
When EmployeeID >5
THEN 'Id de�eri 5 ten b�y�kt�r'
When EmployeeID <5
THEN 'Id de�eri 5 den k���kt�r.'
ELSE 'Id de�eri 5''e e�ittir'
end as Statu
from Employees


-- 1.) Example ad�nda bir database olu�turun.
-- 2.) Northwind veri taban�nda bulunan Employees tablosunu Example veri taban�nda Calisanlar adl� tabloya kopyalay�p olu�turun.
-- 3.) Olu�turdu�unuz Calisanlar tablosuna Days ad�nda bir kolon ekleyin bo� ge�ilebilir olsun ve tipini int yap�n.
-- 4.) Calisanlar tablsounda yer alan Days kolonuna kar���k s�rayla 0,1,2,3,4,5,6 �eklinde g�ncelleyin.
-- 5.) Calisanlar tablosundan Ad,Soyad,G�rev,Yas ve N�bet G�n� (Days) olacak �ekilde bir veri �ekilecek. Days 0 ise Pazartesi, 1 ise Sal�, 2 ise �ar�amba �eklinde ilerleyecek 6 ya kadar yaz�lacak ve ekranda bu �ekilde g�sterilecek. S�ralama k�s�t�m�z ise ya�a g�re olacak. B�y�kten k����e do�ru s�ral�yaca��z.

Create Database Example

Select * into Example.dbo.Calisanlar from Northwind.dbo.Employees

ALTER TABLE Example.dbo.Calisanlar
Add [Days] int null

Select * from Example.dbo.Calisanlar

Update Example.dbo.Calisanlar Set [Days] = 0 Where EmployeeID Between 1 and 2
Update Example.dbo.Calisanlar Set [Days] = 1 Where EmployeeID Between 3 and 4
Update Example.dbo.Calisanlar Set [Days] = 2 Where EmployeeID Between 5 and 6
Update Example.dbo.Calisanlar Set [Days] = 3 Where EmployeeID Between 7 and 8
Update Example.dbo.Calisanlar Set [Days] = 4 Where EmployeeID Between 9 and 10
Update Example.dbo.Calisanlar Set [Days] = 5 Where EmployeeID Between 11 and 12
Update Example.dbo.Calisanlar Set [Days] = 6 Where EmployeeID Between 13 and 14


Select Ad = FirstName , LastName Soyad, Title 'G�rev', 
DATEDIFF(YEAR,BirthDate,GETDATE()) Ya�,
Case([Days])
When 0 THEN 'Pazartesi'
When 1 THEN 'Sal�'
When 2 THEN '�ar�amba'
When 3 THEN 'Per�embe'
When 4 THEN 'Cuma'
When 5 THEN 'Cumartesi'
When 6 THEN 'Pazar'
else 'N�bet G�n� Yok'
end as 'N�bet G�n�'
from Example.dbo.Calisanlar
Order By 4 desc