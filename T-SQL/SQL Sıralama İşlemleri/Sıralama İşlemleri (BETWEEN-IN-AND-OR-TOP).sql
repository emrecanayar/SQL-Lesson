-- SIRALAMA ��LEMLER� --
-- SQL Server �zerinde s�ralama yapmak i�in Order By anahtar kelimesi kullan�l�r.
-- Order By anahtar kelimesi sorgunun en sonunda kullan�l�r.
-- S�ralama yaparken metinsel i�lemlerde A-Z y�n�nde olmas�n� istiyorsak ASC ibaresi kullan�l�r.
-- S�ralama yaparken metinsel i�lemlerde Z-A y�n�nde olmas�n� istiyorsak DESC ibaresi kullan�l�r.
-- S�ralama yaparken say�sal i�lemlerde  1-9 y�n�nde olmas�n� istiyorsak ASC ibaresi kullan�l�r.
-- S�ralama yaparken say�sal i�lemlerde 9-1 y�n�nde DESC ibaresi kullan�l�r.


Select * from Employees
Where EmployeeID > 2 AND EmployeeID <=8
Order By FirstName ASC -- Ascending (artan s�rada)

Select FirstName,LastName,BirthDate from Employees
Order By BirthDate -- E�er ASC ifadesini belirtmezsek de default olarak bu �ekilde(k���kten-b�y��e) s�ralama yapacakt�r. Bu sorguda BirthDate s�tununa g�re artan s�rada s�ralama yapt�k.


Select FirstName,LastName,BirthDate,HireDate from Employees
ORDER BY LastName DESC -- (Descending azalan s�rada)


Select FirstName,LastName from Employees
ORDER BY FirstName , LastName DESC
-- Elde etti�imiz sonu� k�mesini isme g�re artan s�rada s�ralad�k. E�er ayn� isme sahip birden fazla kay�t varsa bunlar�da soyad�na g�re azalan s�rada s�ral�yoruz. (Bu i�lemi yapmak i�in Employees tablosuna Micheal Jordan ve Micheal Scoffield kay�tlar�n� ekledik.)


Select FirstName,LastName,BirthDate,HireDate,Title,TitleOfCourtesy from Employees
ORDER BY 6 ASC , 4 desc

-- Sorguda yazd���m�z s�tunun s�ras�na g�re s�ralama i�lemini yapabiliriz. Burada ilk �nce 6. s�radaki s�tuna (TitleOfCourtesy) artan s�rada s�ralama, daha sonra ayn� �nvan de�erine sahip kay�tlar i�in 4. s�radaki (HireDate) s�tununa g�re azalan s�rada s�ralama yap�yoruz. SQL' de index numaralar� 1 den ba�lar. Bu durumda 1 den ba�lad��� i�in TitleOfCourtesy 6. s�rada HireDate ise 4. s�radad�r.


-- �al��anlar� unvanlar�na g�re ve unvanlar� ayn�ysa ya�lar�na g�re b�y�kten k����e s�ralay�n�z.

Select TitleOfCourtesy,FirstName,LastName, (YEAR(GETDATE()) - YEAR(BirthDate) ) as Age from Employees
Where TitleOfCourtesy is not null
Order By 1, Age Desc
-- Order By ifadesi ile s�tunlara vermi� oldu�umuz takma isimleri kullanabiliriz. �rne�in Age s�tunundaki gibi.

--BETWEEN - AND KULLANIMI
-- Aral�k bildirmek i�in kullanaca��m�z bir yap� sunar.
-- syntax => Select * from <tablo_ad�> Where <�art_uygulanacak_kolon> BETWEEN <�art1> AND <�art2>

-- 1952 ile 1960 aras�nda do�anlar�n listelenmesi (Employees tablosu)

Select FirstName as Ad,Soyad = LastName, Year(BirthDate) as 'Do�um Y�l�' from Employees
Where Year(BirthDate) BETWEEN 1952 and 1960
ORDER BY 3 desc

-- II.Yol

Select FirstName Ad , Soyad=LastName, YEAR(BirthDate) as [Do�um Y�l�] from Employees
WHERE YEAR(BirthDate) >= 1952 AND YEAR(BirthDate) <= 1960
ORDER BY [Do�um Y�l�] desc


-- Alfabetik olarak Janet ile Robert aras�ndaki isimleri listeleyelim.
Select FirstName,LastName from Employees
Where FirstName BETWEEN 'Janet' and 'Robert'
Order by FirstName

-- II.Yol

Select FirstName,LastName from Employees
Where FirstName >= 'Janet' and FirstName <= 'Robert'
Order By 1

-- NOT : Order By ifadesi bir sorguda en sonda olmal�d�r.


-- IN KULLANIMI
-- Unvan� Mr. veya Dr. olanlar�n listelenmesi

Select TitleOfCourtesy+' '+FirstName+' '+ LastName as 'Ad Soyad' from Employees
Where TitleOfCourtesy = 'Mr.' OR TitleOfCourtesy = 'Dr.'

-- II.Yol

Select CONCAT(TitleOfCourtesy, ' ', FirstName , ' ' , LastName) as [Ad Soyad] from Employees
Where TitleOfCourtesy IN ('Mr.','Dr.')


-- 1950, 1955 , 1960 y�llar�nda do�an �al��anlar�n listelenmesi
Select FirstName Ad, LastName Soyad, YEAR(BirthDate) 'Do�um Y�l�' from Employees
Where Year(BirthDate) IN (1950,1955,1960)


-- TOP Kullan�m�

Select * from Employees -- 11 Kay�t (2 tane biz ekledik, Micheal'lar)

Select TOP 3 * from Employees -- Tablodaki ilk 3 kay�t getirilir.

Select top 5 FirstName,LastName,TitleOfCourtesy from Employees Order By TitleOfCourtesy desc

-- Not : TOP ifadesi bir sorguda en son �al��an k�s�md�r. Yani �ncellikle sorgumuz �al��t�r�l�r ve olu�acak olan sonu� k�mesinin (Result Set) ilk 5 kayd� al�n�r.

Select top 1 FirstName,LastName,BirthDate from Employees Order By BirthDate asc


-- �al��anlar� ya�lar�na g�re azalan s�rada s�ralad�ktan sonra, olu�acak sonu� k�mesinin %25 lik k�sm�n� inceleyelim.

Select top 25 percent FirstName,LastName,Title , (YEAR(GETDATE())- YEAR(BirthDate)) as Age from Employees
Order By Age Desc

-- E�er belirtti�imiz oran sonucu 3.2 veya 2.75 gibi bir kay�tr say�s� olu�uyorsa, bu durumda bize 3.2 i�in 4 kay�t, 2.75 i�in 3 kay�t g�sterilir, yani yukar� tamamlama(yuvarlama) i�lemi ger�ekle�tirilir.