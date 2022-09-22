-- Not: Sorgular�m�z� yazarken k���k-b�y�k harfe dikkat etmemize gerek yok.


-- DML => Data Manipulation Language

Use Northwind -- Northwind veri taban� �zerinde sorgulamalar yapaca��m�z i�in ya bu �ekilde ya da sol �st k��edeki ComboBox'� kullanarak �al��mak istedi�imiz veri taban�n� se�ebiliriz.

-- Tekli yorum sat�r�

/*
�oklu
Yorum
Sat�r�
*/

-- NOT: Yorum sat�r�nda yer alan b�l�mler �al��maz.

-- Ctrl + K + C => se�ili alan� yorum sat�r�na al�r. (Windows)
-- Command + K + C => se�ili alan� yorum sat�r�na al�r. (Mac)

-- Ctrl + K + U => se�ili alan� yorum sat�r�ndan geri al�r. (Windows)
-- Command + K + U => se�ili alan� yorum sat�r�ndan geri al�r. (Mac)

-- Ctrl + R ile i�lem sonucunda ��kan result ekran�n� a��p kapatabilirsiniz.

-- Yazd���m�z sorguyu �al��t�rmak i�in , (execute) F5, Alt + X veya ribon men�de yer alan "Execute" butonuna t�klayabilirsiniz.

-- DML => Data Manipulation Language
-- Ama� : Tablolar� sorgulamak

-- Syntax => Select <s�tun_adlar�> from <tablo_ad�> (s�tun adlar� aras�na virg�l konur.)

-- Employess tablosundaki t�m kay�tlar� listeyelim..
Select * from Employees

-- Employess tablosundan, �al��anlara ait ad,soyad,g�rev ve do�um tarihi bilgilerini listeleyelim.
Select FirstName,LastName,Title,BirthDate from Employees -- Se�mek istedi�imiz s�tunlar� aralar�na virg�l koyarak belirtiyoruz.

-- S�tun isimlerinin Intellisense men�s� ile gelmesi i�in Select ifadesinden sonra From <tablo_Ad�> yaz�p, daha sonra Select ile From aras�na s�tun isimlerini yazarsak, s�tun isimleri bize a��l�r pencerede listelenir.
Select FirstName,LastName,Title,BirthDate from Employees


-- Employess tablosunun s�tunlar�n� s�r�kle b�rak yard�m� ile de ekleyebiliriz.
-- Employess tablosunun alt�ndaki Columns klas�r�n� s�r�kleyip b�rak�rsak b�t�n s�tunlar listelenir.
Select [EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]  from Employees


-- S�TUNLARIN �S�MLEND�R�LMES�
-- 1.Yol

Select FirstName as Ad, LastName as Soyad, Title as G�rev from Employees -- Sorgu sonucu olu�acak olan sonu� k�mesindeki (result-set) s�tun isimleri de�i�tirilecektir, tablodaki orjinal s�tun isimlerinin de�i�tirilmesi gibi bir durum s�z konusu de�ildir.

-- 2.Yol
-- Birden fazla kelimeden olu�an bir s�tun ismi olu�turdu�umuzda bunu k��eli parantezler i�erisinde yada tek t�rnak i�erisinde belirtmemiz gerekir. SQL Server'da Metinsel ifadeler tek t�rnak i�erisinde belirtilir.

Select Ad = FirstName, Soyad= LastName, G�rev=Title, [Do�um Tarihi] = BirthDate from Employees

Select Ad = FirstName, Soyad= LastName, G�rev=Title, 'Do�um Tarihi' = BirthDate from Employees

-- 3.Yol

Select Ad=FirstName, LastName Soyad,Title as G�rev, HireDate as [��e Ba�lama Tarihi] from Employees -- S�tunlar ile belirtti�imiz isimler aras�nda 'as' kullanmam�za gerek yok. (LastName Soyad)


-- TEK�L KAYITLARI L�STELEMEK

Select City from Employees -- Ayn� de�ere sahip olan �ehirler listelenir.

Select DISTINCT City from Employees -- Farkl� olan �ehirler (tekil de�erlerin) listelenmesi sa�lan�r.

Select FirstName,City from Employees

Select Distinct FirstName,City from Employees

-- �steki ile ayn� sonucu getirir, sebebi ise ayn� ad ve �ehir de�erine sahip kay�tlar�n olmamas�d�r. E�er FirstName = Steven City = London olan ba�ka bir kay�t daha girilirse tabloya, bu kay�tlardan sadece biri listelenecektir.


-- MET�NLER� B�RLE�T�RMEK

Select TitleOfCourtesy,FirstName,LastName from Employees

Select (TitleOfCourtesy + ' ' +FirstName+ ' ' +LastName) as �sim from Employees

-- + operat�r� ile metinlerimizi birle�tirebiliriz. ' ' ile araya bo�luk ekliyoruz. E�er as �sim demeseydik, tablomuzda sorguda yazd���m�z gibi bir s�tun olmad��� i�in s�tun ba�l��� olarak No Column Name ifadesi yazacakt�.

-- CONCAT => SQL Server �zerinde metinsel ifadeleri birle�tirmek i�in kullan�l�r.

Select �sim =  CONCAT(TitleOfCourtesy,' ',FirstName,' ',LastName) from Employees