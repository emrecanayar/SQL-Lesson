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
