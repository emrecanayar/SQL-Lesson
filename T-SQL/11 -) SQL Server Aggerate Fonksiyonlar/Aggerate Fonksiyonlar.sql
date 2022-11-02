-- Aggregate Fonksiyonlar (Toplam Fonksiyonlar�, Gruplamal� Fonksiyonlar)

-- COUNT (S�tun ad� | *) : Bir tablodaki kay�t say�s�n� g�rmek yada ��renmek i�in kullan�l�r.

Select COUNT(*) from Employees -- Bir tablodaki toplam kay�t say�s�n� bu �ekilde ��renebiliriz.

Select COUNT(EmployeeID) from Employees -- EmployeeID s�tunundaki kay�t say�s�

Select Count(Region) from Employees

-- Region s�tunundaki kay�t say�s� (Region s�tunu null ge�ilebildi�i i�in bir tablodaki kay�t say�s�n� bu s�tundan yola ��karak ��renmek yanl�� sonu�lar olu�turabilir. ��nk� aggregate fonksiyonlaru NULL de�er i�eren kay�tlar� dikkate almaz. Bu nedenle kay�t say�s�n� ��renebilmek i�in ya * karakterini ya da NULL de�er ge�ilemeyen s�tunlardan birinin ad�n� kullanmam�z gerekir.)

Select COUNT(City) from Employees -- 9 yazar ancak baz� �ehirler birden fazla tekrar etmi�tir.

Select COUNT(Distinct City) as 'Farkl� �ehir' from Employees -- Farkl� olan �ehirlerin say�s�n� verir.

-- SUM (S�tun Ad�) : Bir s�tundaki de�erlerin toplam�n� veriyor.
Select SUM(EmployeeID) as 'Id''lerin toplam�' from Employees

-- �al��anlar�n ya�lar�n�n toplam�n� bulunuz.

-- I.Yol

Select SUM(YEAR(GETDATE()) - YEAR(BirthDate)) as 'Ya�lar�n Toplam�'  from Employees

-- II.Yol

Select SUM(DATEDIFF(YEAR,BirthDate,GETDATE())) as [Ya�lar�n Toplam�] from Employees

Select SUM(FirstName) from Employees -- NOT : SUM fonksiyonunu say�sal s�tunlarda kullanabiliriz. Aksi di�er s�tunlarda kullan�lamaz. HATA VER�R!


-- AVG (S�tun Ad�)  : Bir s�tundaki de�erlerin ortalamas�n� verir.

Select AVG(EmployeeID) as 'Ortalama' from Employees

-- �al��anlar�n ya�lar�n�n ortalamas�n� 2. yoldan yapal�m

Select AVG(DATEDIFF(YEAR,BirthDate,GETDATE())) as [Ya�lar�n Ortalamas�] from Employees

Select AVG(FirstName) from Employees -- NOT : AVG fonksiyonunu say�sal s�tunlarda kullanabiliriz. Aksi di�er s�tunlarda kullan�lamaz. HATA VER�R!


-- MAX (S�tun Ad�) : Bir s�tundaki en b�y�k de�eri verir.

Select MAX(EmployeeID) from Employees

Select MAX(FirstName) from Employees -- S�tunun say�sal s�tun olmas�na gerek yok, alfabetik olaran en b�y�k de�eri de verir.


-- MIN (S�tun Ad�) : Bir s�tundaki en k���k de�eri verir.

Select MIN(EmployeeID) from Employees

Select MIN(FirstName) from Employees -- S�tunun say�sal s�tun olmas�na gerek yok, alfabetik olarak en k���k de�eri de verir.