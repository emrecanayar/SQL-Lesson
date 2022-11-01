---DEÐÝÞKENLER---

-- 1. Deðer Atama Yöntemi
declare @Ad nvarchar(30)
set @Ad = 'Merve Doðan'
Select @Ad as Ad


-- 2. Deðer Atama Yöntemi
declare @AdSoyad nvarchar(50), @yas int
select @AdSoyad = 'Merve Doðan' , @yas = 25
select @AdSoyad as  'Ad Soyad' , @yas Yaþ

-- Aralarýndaki fark set ile deðer atama ayný zamanda birden fazla deðiþkene deðer atanamazken, select ile atamada ayný anda birden fazla deðiþkene deðer atanýr.

-- print @AdSoyad Print ekrana message verir, select ise ekrana tablo döndürür.

-- Hata Verir.
declare @urunAdi nvarchar(50)
set @urunAdi = (select ProductName from Products)
select @urunAdi as 'Ürün Adý'


-- Hata Vermez.
declare @urunAdi2 nvarchar(50)
set @urunAdi2 = (Select ProductName from Products Where ProductID = 7)
select @urunAdi2 as 'Ürün Adý 2'

-- Hata vermez fakat where siz kullandýðýmýzdan dolayý geriye anlamsýz bir yanýt döner.
declare @urunAdi1 nvarchar(50)
select @urunAdi1 = ProductName from Products 
select @urunAdi1


declare @urunAdi3 nvarchar(50)
select @urunAdi3 = ProductName from Products Where ProductID = 5
select @urunAdi3


declare  @urunAdi4 nvarchar(50)
select top 1 @urunAdi4 = ProductName from Products Where UnitsInStock > 50
select @urunAdi4


-- Deðiþkenlere ad,soyad ve yaþ tanýmlayalým, tanýmladýðýmýz deðiþkenlere deðer atayalým ve ekranda yazdýralým.

DECLARE @ad_ nvarchar(20), @soyad_ varchar(20), @yas_ int
set @ad_ = 'Emre Can'
select @soyad_ = 'Ayar' , @yas_ = 29
print @ad_
print @soyad_
print @yas_


-- Oluþturduðumuz @n1 ve @n2 deðiþkenlerine bir deðer atamasý yapalým ve bu iki deðerin ortalamasýný alýp @ort  deðiþkenine aktaralým ve ekranda gösterelim.

declare @n1 int, @n2 int, @ort float
set @n1 = 85
select @n2 = 42
set @ort = (@n1+@n2)/2
print @ort