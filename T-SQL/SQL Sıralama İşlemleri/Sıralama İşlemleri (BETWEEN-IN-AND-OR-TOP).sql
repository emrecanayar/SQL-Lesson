-- SIRALAMA ÝÞLEMLERÝ --
-- SQL Server üzerinde sýralama yapmak için Order By anahtar kelimesi kullanýlýr.
-- Order By anahtar kelimesi sorgunun en sonunda kullanýlýr.
-- Sýralama yaparken metinsel iþlemlerde A-Z yönünde olmasýný istiyorsak ASC ibaresi kullanýlýr.
-- Sýralama yaparken metinsel iþlemlerde Z-A yönünde olmasýný istiyorsak DESC ibaresi kullanýlýr.
-- Sýralama yaparken sayýsal iþlemlerde  1-9 yönünde olmasýný istiyorsak ASC ibaresi kullanýlýr.
-- Sýralama yaparken sayýsal iþlemlerde 9-1 yönünde DESC ibaresi kullanýlýr.


Select * from Employees
Where EmployeeID > 2 AND EmployeeID <=8
Order By FirstName ASC -- Ascending (artan sýrada)

Select FirstName,LastName,BirthDate from Employees
Order By BirthDate -- Eðer ASC ifadesini belirtmezsek de default olarak bu þekilde(küçükten-büyüðe) sýralama yapacaktýr. Bu sorguda BirthDate sütununa göre artan sýrada sýralama yaptýk.


Select FirstName,LastName,BirthDate,HireDate from Employees
ORDER BY LastName DESC -- (Descending azalan sýrada)


Select FirstName,LastName from Employees
ORDER BY FirstName , LastName DESC
-- Elde ettiðimiz sonuç kümesini isme göre artan sýrada sýraladýk. Eðer ayný isme sahip birden fazla kayýt varsa bunlarýda soyadýna göre azalan sýrada sýralýyoruz. (Bu iþlemi yapmak için Employees tablosuna Micheal Jordan ve Micheal Scoffield kayýtlarýný ekledik.)


Select FirstName,LastName,BirthDate,HireDate,Title,TitleOfCourtesy from Employees
ORDER BY 6 ASC , 4 desc

-- Sorguda yazdýðýmýz sütunun sýrasýna göre sýralama iþlemini yapabiliriz. Burada ilk önce 6. sýradaki sütuna (TitleOfCourtesy) artan sýrada sýralama, daha sonra ayný ünvan deðerine sahip kayýtlar için 4. sýradaki (HireDate) sütununa göre azalan sýrada sýralama yapýyoruz. SQL' de index numaralarý 1 den baþlar. Bu durumda 1 den baþladýðý için TitleOfCourtesy 6. sýrada HireDate ise 4. sýradadýr.


-- Çalýþanlarý unvanlarýna göre ve unvanlarý aynýysa yaþlarýna göre büyükten küçüðe sýralayýnýz.

Select TitleOfCourtesy,FirstName,LastName, (YEAR(GETDATE()) - YEAR(BirthDate) ) as Age from Employees
Where TitleOfCourtesy is not null
Order By 1, Age Desc
-- Order By ifadesi ile sütunlara vermiþ olduðumuz takma isimleri kullanabiliriz. Örneðin Age sütunundaki gibi.

--BETWEEN - AND KULLANIMI
-- Aralýk bildirmek için kullanacaðýmýz bir yapý sunar.
-- syntax => Select * from <tablo_adý> Where <þart_uygulanacak_kolon> BETWEEN <þart1> AND <þart2>

-- 1952 ile 1960 arasýnda doðanlarýn listelenmesi (Employees tablosu)

Select FirstName as Ad,Soyad = LastName, Year(BirthDate) as 'Doðum Yýlý' from Employees
Where Year(BirthDate) BETWEEN 1952 and 1960
ORDER BY 3 desc

-- II.Yol

Select FirstName Ad , Soyad=LastName, YEAR(BirthDate) as [Doðum Yýlý] from Employees
WHERE YEAR(BirthDate) >= 1952 AND YEAR(BirthDate) <= 1960
ORDER BY [Doðum Yýlý] desc


-- Alfabetik olarak Janet ile Robert arasýndaki isimleri listeleyelim.
Select FirstName,LastName from Employees
Where FirstName BETWEEN 'Janet' and 'Robert'
Order by FirstName

-- II.Yol

Select FirstName,LastName from Employees
Where FirstName >= 'Janet' and FirstName <= 'Robert'
Order By 1

-- NOT : Order By ifadesi bir sorguda en sonda olmalýdýr.


-- IN KULLANIMI
-- Unvaný Mr. veya Dr. olanlarýn listelenmesi

Select TitleOfCourtesy+' '+FirstName+' '+ LastName as 'Ad Soyad' from Employees
Where TitleOfCourtesy = 'Mr.' OR TitleOfCourtesy = 'Dr.'

-- II.Yol

Select CONCAT(TitleOfCourtesy, ' ', FirstName , ' ' , LastName) as [Ad Soyad] from Employees
Where TitleOfCourtesy IN ('Mr.','Dr.')


-- 1950, 1955 , 1960 yýllarýnda doðan çalýþanlarýn listelenmesi
Select FirstName Ad, LastName Soyad, YEAR(BirthDate) 'Doðum Yýlý' from Employees
Where Year(BirthDate) IN (1950,1955,1960)


-- TOP Kullanýmý

Select * from Employees -- 11 Kayýt (2 tane biz ekledik, Micheal'lar)

Select TOP 3 * from Employees -- Tablodaki ilk 3 kayýt getirilir.

Select top 5 FirstName,LastName,TitleOfCourtesy from Employees Order By TitleOfCourtesy desc

-- Not : TOP ifadesi bir sorguda en son çalýþan kýsýmdýr. Yani öncellikle sorgumuz çalýþtýrýlýr ve oluþacak olan sonuç kümesinin (Result Set) ilk 5 kaydý alýnýr.

Select top 1 FirstName,LastName,BirthDate from Employees Order By BirthDate asc


-- Çalýþanlarý yaþlarýna göre azalan sýrada sýraladýktan sonra, oluþacak sonuç kümesinin %25 lik kýsmýný inceleyelim.

Select top 25 percent FirstName,LastName,Title , (YEAR(GETDATE())- YEAR(BirthDate)) as Age from Employees
Order By Age Desc

-- Eðer belirttiðimiz oran sonucu 3.2 veya 2.75 gibi bir kayýtr sayýsý oluþuyorsa, bu durumda bize 3.2 için 4 kayýt, 2.75 için 3 kayýt gösterilir, yani yukarý tamamlama(yuvarlama) iþlemi gerçekleþtirilir.