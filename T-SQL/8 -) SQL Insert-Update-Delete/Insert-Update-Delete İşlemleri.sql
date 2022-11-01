--Create Read Update Delete (CRUD) ��lemleri -- (Ekle-Listele-G�ncelle-Sil)

-- Veri tabanlar� i�lemleri
-- Create => tablo �zerine veri ekleme i�lemi (INSERT INTO)
-- Read => select * from tabloAdi - Tablo i�erisindeki verileri listelemeye yarar. (SELECT)
-- Update => tabloda yer alan kay�tlar� g�ncelleme i�lemini ger�ekle�tirir. (UPDATE)
-- Delete => tabloda yer alan kay�tlar� silme i�lemini ger�ekle�tirir. (DELETE)


-- 1.) INSERT : Bir veritaban�ndaki tablolardan birine kay�t eklemek i�in kullanca��m�z komuttur.

/*
(insert) INSERT INTO <Tablo Ad�> (<S�tun Adlar�>) VALUES (<S�tun De�erleri>)
*/

Select * from Categories -- Toplamda 8 kay�t mevcut

INSERT INTO Categories (CategoryName,[Description])
values ('Kategori Ad�','A��klama Alan�')

-- Not: E�er bir alan primary key ise ve o alan identity �zelli�ine sahipse id de�eri otomatik olarak SQL taraf�ndan veriliyor anlam�na gelir. Bu sebepten dolayu ID de�eri g�ndermiyoruz :)

-- (1 row affected) => etkilenen sat�r say�s�, yapt���m�z i�lem sonucunda o tablo i�erisinde ka� kay�t etkilendiyse bize, etkilenen kayd�n adedini teslim eder.

Insert into Categories ([Description]) VALUES ('Kategori A��klamas� Gelecek')

-- Yukar�da yer alan sorgu �al��mayacakt�r. Ekleme i�lemi yaparken mutlaka bo� ge�ilemez alanlara veri eklemek zorundas�n�z. 

Insert into Categories (CategoryName) Values ('Kategori Ad� Gelecek, Peki Bu Sorgu �al���r M�?')

-- Yukar�da yer alan sorgu �al��mayacakt�r. CategoryName alan� maksimum 15 karakterden olu�tu�undan, fazla karakter verid�imizde hata verecektir.

-- String or binary data would be truncated. The statement has been terminated. (Karakter uzunlu�u hatas�)

Insert into Categories (CategoryName) Values ('Kategori Ad�')

Select * from Categories

-- �imdi biraz insert into �rne�i yapal�m.

Select * from Shippers

Insert into Shippers (CompanyName,Phone) Values ('Surat Kargo','(537) 918-43-30')

Insert into Shippers (Phone,CompanyName) Values ('(503) 555-98-31','MNG Kargo')

-- Ekleme i�lemi s�ras�nda, s�tun isimlerini belirtmiyorsan�z, de�erleri g�nderirken dikkat etmeniz gereken s�ralama, tablonun yap�s�ndaki s�ralamad�r.
Insert into Shippers values ('Ups Kargo', '(503) 555-98-32')

-- Bulk Insert (Toplu Veri Ekleme ��lemi)
Insert into Shippers Values
('MNG Kargo','(503) 555-98-31'),
('UPS Kargo','(503) 555-98-32'),
('DHL Kargo','(503) 555-98-33'),
('Aras Kargo','(503) 555-98-34'),
('S�rat Kargo','(503) 555-98-35')


-- Merve Do�an �irketini M��teriler(Customers) tablosuna ekleyiniz.

Select * from Customers Where CustomerID = 'MRVDN'

Insert into Customers (CompanyName,CustomerID) values ('Merve Do�an Company','MRVDN')

-- Customers tablosundaki CustomerID s�tunun tipi nchar(5) tir.
-- Yani , bu s�tun Identity olarak belirtilemez, dolay�s�yla bu tabloya bir kay�t girerken CustomerId S�tununa da kendimiz de�er vermeliyiz.

Select NEWID() -- Benzersiz binary tipinde bir Id Size verir => 154A46FC-6594-43F1-BF6D-4A0C7C0022AD


-- 2.) UPDATE : Bir tablodaki kay�tlar� g�ncellemek i�in kullan�l�r. Dikkat edilmesi gereken hangi kayd� g�ncelleyece�imizi a��ktan belirtmek gerekir.
-- AKSI HALDE T�M KAYITLAR G�NCELLENEB�L�R !!!

/*

	Update <tablo_adi> Set <s�tun_ad�> = <s�tun_degeri> , <s�tun_ad�> = <s�tun_degeri>

*/

-- K�sa yoldan tablo kopyalama

Select * into Calisanlar from Employees
Select * from Calisanlar

-- Belirli alanlarla tablo kopyalama

Select Ad = FirstName,LastName Soyad into Calismayanlar from Calisanlar
Select * from Calismayanlar


Update Calisanlar Set LastName = 'Ayar'


-- Calisanlar tablosundaki EmployeeID de�eri 5 olan kayd� FirstName alan�n� Emre Can olarak g�ncelleyelim.
Update Calisanlar Set FirstName = 'Emre Can' Where EmployeeID = 5


-- Products tablosu kopyalayarak (ProductID,ProductName,OldPrice,NewPrice) Urunler ad�nda yeni bir tablo yapal�m ve �r�nlere birim fiyat �zerinden %5 lik bir zam yap�n�z.

Select ProductID,ProductName, OldPrice = UnitPrice, NewPrice = UnitPrice into Urunler from Products

Select * from Urunler

Update Urunler Set NewPrice = OldPrice + (OldPrice * 0.05)


-- 3.) Delete : Bir tablodan kay�t silmek i�in kullanaca��m�z bir komuttur. Ayn� Update i�lemi gibi dikkat edilmesi gerekir, ��nk� birden fazla kay�t yanl���kla silinebilir.

/*
	delete from <tablo_ad�>
*/

Select * from Urunler
Delete from Urunler

delete from Calismayanlar -- Tablo i�erisinde yer alan kay�tlar� siler
select * from Calismayanlar


drop table Calismayanlar -- Tablonun kendisini siler.


-----------------------------------------------------------------------------------------------------------------------------------------------------------

Select * into Kategoriler from Categories
Select * into Personeller from Employees

-- Silme i�lemlerinin �e�itliliklerine bir g�z atal�m..
Select * from Kategoriler
Select * from Personeller


-- Personeller tablosunda unvan� Mr. olanlar� silelim.
Delete from Personeller Where TitleOfCourtesy = 'Mr.'

-- Kategoriler tablosundaki CategoryID si 2 veya 4 veya 7 olanlar� silelim.
Delete from Kategoriler Where CategoryID = 2 or CategoryID = 4 or CategoryID = 7

-- Kategoriler tablosundaki CategoryID leri 1 veya 3 veya 5 veya 6 olanlar� silelim
Delete from Kategoriler Where CategoryID in (1,3,5,6)

-- Personeller tablosundaki TitleOfCourtesy alan�nda Mr. Dr. Mrs. olan kay�tlar� silelim.
Delete from Personeller Where TitleOfCourtesy in ('Mr.','Dr.','Mrs.')

Delete from Employees Where EmployeeID = 10


-- TRUNCATE = Tablonun i�erisindeki verileri komple siler ve tablonun ayarlar�n� ba�lang�ca set eder.

Select * from Calisanlar

Delete from Calisanlar

Insert into Calisanlar (FirstName,LastName) Values ('Emre Can','Ayar')

Truncate table Calisanlar