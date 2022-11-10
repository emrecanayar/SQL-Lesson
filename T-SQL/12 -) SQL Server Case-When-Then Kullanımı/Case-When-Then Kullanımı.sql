--CASE - WHEN - THEN Kullanýmý

Select FirstName as Ad,Soyad = LastName,Title as Görev,Country as Ülke from Employees

--CASE - WHEN - THEN kullanýmý aþaðýdaki gibidir.
-- Case içerisine hangi alan için þartlar belirteceksek onu yazýyoruz.
-- Daha sonra WHEN anahtar kelimesi ile Case içerisinde belirttiðimiz alanýn veri tabanýnda bulunan deðerlerini belirtiyoruz. (Mantýksal iþlemlerde yapýlabilir.)
-- THEN ise veri tabanýnda bulunan deðerin karþýlýðýný belirttiðimiz alandýr. (Yani veri tabanýnda USA ise ekranda Amerika Birleþik Devletleri olsun dediðimiz alandýr.)

Select FirstName,LastName,
CASE (Country)
When 'USA'
THEN 'Amerika Birleþik Devletleri'
When 'UK'
THEN 'Ýngiltere Birleþik Krallýðý'
ELSE 'Ülkesi Belirtilmedi'
END AS Country
from Employees


-- Mantýksal iþlem içeren CASE - WHEN - THEN
Select 
EmployeeID,FirstName,LastName,
CASE
When EmployeeID >5
THEN 'Id deðeri 5 ten büyüktür'
When EmployeeID <5
THEN 'Id deðeri 5 den küçüktür.'
ELSE 'Id deðeri 5''e eþittir'
end as Statu
from Employees


-- 1.) Example adýnda bir database oluþturun.
-- 2.) Northwind veri tabanýnda bulunan Employees tablosunu Example veri tabanýnda Calisanlar adlý tabloya kopyalayýp oluþturun.
-- 3.) Oluþturduðunuz Calisanlar tablosuna Days adýnda bir kolon ekleyin boþ geçilebilir olsun ve tipini int yapýn.
-- 4.) Calisanlar tablsounda yer alan Days kolonuna karýþýk sýrayla 0,1,2,3,4,5,6 þeklinde güncelleyin.
-- 5.) Calisanlar tablosundan Ad,Soyad,Görev,Yas ve Nöbet Günü (Days) olacak þekilde bir veri çekilecek. Days 0 ise Pazartesi, 1 ise Salý, 2 ise Çarþamba þeklinde ilerleyecek 6 ya kadar yazýlacak ve ekranda bu þekilde gösterilecek. Sýralama kýsýtýmýz ise yaþa göre olacak. Büyükten küçüðe doðru sýralýyacaðýz.

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


Select Ad = FirstName , LastName Soyad, Title 'Görev', 
DATEDIFF(YEAR,BirthDate,GETDATE()) Yaþ,
Case([Days])
When 0 THEN 'Pazartesi'
When 1 THEN 'Salý'
When 2 THEN 'Çarþamba'
When 3 THEN 'Perþembe'
When 4 THEN 'Cuma'
When 5 THEN 'Cumartesi'
When 6 THEN 'Pazar'
else 'Nöbet Günü Yok'
end as 'Nöbet Günü'
from Example.dbo.Calisanlar
Order By 4 desc