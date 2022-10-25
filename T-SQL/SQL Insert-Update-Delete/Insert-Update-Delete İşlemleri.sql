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
