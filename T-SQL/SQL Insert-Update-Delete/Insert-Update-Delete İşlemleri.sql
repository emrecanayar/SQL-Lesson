--Create Read Update Delete (CRUD) Ýþlemleri -- (Ekle-Listele-Güncelle-Sil)

-- Veri tabanlarý iþlemleri
-- Create => tablo üzerine veri ekleme iþlemi (INSERT INTO)
-- Read => select * from tabloAdi - Tablo içerisindeki verileri listelemeye yarar. (SELECT)
-- Update => tabloda yer alan kayýtlarý güncelleme iþlemini gerçekleþtirir. (UPDATE)
-- Delete => tabloda yer alan kayýtlarý silme iþlemini gerçekleþtirir. (DELETE)


-- 1.) INSERT : Bir veritabanýndaki tablolardan birine kayýt eklemek için kullancaðýmýz komuttur.

/*
(insert) INSERT INTO <Tablo Adý> (<Sütun Adlarý>) VALUES (<Sütun Deðerleri>)
*/

Select * from Categories -- Toplamda 8 kayýt mevcut

INSERT INTO Categories (CategoryName,[Description])
values ('Kategori Adý','Açýklama Alaný')

-- Not: Eðer bir alan primary key ise ve o alan identity özelliðine sahipse id deðeri otomatik olarak SQL tarafýndan veriliyor anlamýna gelir. Bu sebepten dolayu ID deðeri göndermiyoruz :)

-- (1 row affected) => etkilenen satýr sayýsý, yaptýðýmýz iþlem sonucunda o tablo içerisinde kaç kayýt etkilendiyse bize, etkilenen kaydýn adedini teslim eder.

Insert into Categories ([Description]) VALUES ('Kategori Açýklamasý Gelecek')

-- Yukarýda yer alan sorgu çalýþmayacaktýr. Ekleme iþlemi yaparken mutlaka boþ geçilemez alanlara veri eklemek zorundasýnýz. 

Insert into Categories (CategoryName) Values ('Kategori Adý Gelecek, Peki Bu Sorgu Çalýþýr Mý?')

-- Yukarýda yer alan sorgu çalýþmayacaktýr. CategoryName alaný maksimum 15 karakterden oluþtuðundan, fazla karakter veridðimizde hata verecektir.

-- String or binary data would be truncated. The statement has been terminated. (Karakter uzunluðu hatasý)

Insert into Categories (CategoryName) Values ('Kategori Adý')

Select * from Categories

-- Þimdi biraz insert into örneði yapalým.

Select * from Shippers

Insert into Shippers (CompanyName,Phone) Values ('Surat Kargo','(537) 918-43-30')

Insert into Shippers (Phone,CompanyName) Values ('(503) 555-98-31','MNG Kargo')

-- Ekleme iþlemi sýrasýnda, sütun isimlerini belirtmiyorsanýz, deðerleri gönderirken dikkat etmeniz gereken sýralama, tablonun yapýsýndaki sýralamadýr.
Insert into Shippers values ('Ups Kargo', '(503) 555-98-32')

-- Bulk Insert (Toplu Veri Ekleme Ýþlemi)
Insert into Shippers Values
('MNG Kargo','(503) 555-98-31'),
('UPS Kargo','(503) 555-98-32'),
('DHL Kargo','(503) 555-98-33'),
('Aras Kargo','(503) 555-98-34'),
('Sürat Kargo','(503) 555-98-35')


-- Merve Doðan þirketini Müþteriler(Customers) tablosuna ekleyiniz.

Select * from Customers Where CustomerID = 'MRVDN'

Insert into Customers (CompanyName,CustomerID) values ('Merve Doðan Company','MRVDN')

-- Customers tablosundaki CustomerID sütunun tipi nchar(5) tir.
-- Yani , bu sütun Identity olarak belirtilemez, dolayýsýyla bu tabloya bir kayýt girerken CustomerId Sütununa da kendimiz deðer vermeliyiz.

Select NEWID() -- Benzersiz binary tipinde bir Id Size verir => 154A46FC-6594-43F1-BF6D-4A0C7C0022AD


-- 2.) UPDATE : Bir tablodaki kayýtlarý güncellemek için kullanýlýr. Dikkat edilmesi gereken hangi kaydý güncelleyeceðimizi açýktan belirtmek gerekir.
-- AKSI HALDE TÜM KAYITLAR GÜNCELLENEBÝLÝR !!!

/*

	Update <tablo_adi> Set <sütun_adý> = <sütun_degeri> , <sütun_adý> = <sütun_degeri>

*/

-- Kýsa yoldan tablo kopyalama

Select * into Calisanlar from Employees
Select * from Calisanlar

-- Belirli alanlarla tablo kopyalama

Select Ad = FirstName,LastName Soyad into Calismayanlar from Calisanlar
Select * from Calismayanlar


Update Calisanlar Set LastName = 'Ayar'


-- Calisanlar tablosundaki EmployeeID deðeri 5 olan kaydý FirstName alanýný Emre Can olarak güncelleyelim.
Update Calisanlar Set FirstName = 'Emre Can' Where EmployeeID = 5


-- Products tablosu kopyalayarak (ProductID,ProductName,OldPrice,NewPrice) Urunler adýnda yeni bir tablo yapalým ve ürünlere birim fiyat üzerinden %5 lik bir zam yapýnýz.

Select ProductID,ProductName, OldPrice = UnitPrice, NewPrice = UnitPrice into Urunler from Products

Select * from Urunler

Update Urunler Set NewPrice = OldPrice + (OldPrice * 0.05)


-- 3.) Delete : Bir tablodan kayýt silmek için kullanacaðýmýz bir komuttur. Ayný Update iþlemi gibi dikkat edilmesi gerekir, çünkü birden fazla kayýt yanlýþýkla silinebilir.

/*
	delete from <tablo_adý>
*/

Select * from Urunler
Delete from Urunler

delete from Calismayanlar -- Tablo içerisinde yer alan kayýtlarý siler
select * from Calismayanlar


drop table Calismayanlar -- Tablonun kendisini siler.


-----------------------------------------------------------------------------------------------------------------------------------------------------------

Select * into Kategoriler from Categories
Select * into Personeller from Employees

-- Silme iþlemlerinin çeþitliliklerine bir göz atalým..
Select * from Kategoriler
Select * from Personeller


-- Personeller tablosunda unvaný Mr. olanlarý silelim.
Delete from Personeller Where TitleOfCourtesy = 'Mr.'

-- Kategoriler tablosundaki CategoryID si 2 veya 4 veya 7 olanlarý silelim.
Delete from Kategoriler Where CategoryID = 2 or CategoryID = 4 or CategoryID = 7

-- Kategoriler tablosundaki CategoryID leri 1 veya 3 veya 5 veya 6 olanlarý silelim
Delete from Kategoriler Where CategoryID in (1,3,5,6)

-- Personeller tablosundaki TitleOfCourtesy alanýnda Mr. Dr. Mrs. olan kayýtlarý silelim.
Delete from Personeller Where TitleOfCourtesy in ('Mr.','Dr.','Mrs.')

Delete from Employees Where EmployeeID = 10


-- TRUNCATE = Tablonun içerisindeki verileri komple siler ve tablonun ayarlarýný baþlangýca set eder.

Select * from Calisanlar

Delete from Calisanlar

Insert into Calisanlar (FirstName,LastName) Values ('Emre Can','Ayar')

Truncate table Calisanlar