---DE���KENLER---

-- 1. De�er Atama Y�ntemi
declare @Ad nvarchar(30)
set @Ad = 'Merve Do�an'
Select @Ad as Ad


-- 2. De�er Atama Y�ntemi
declare @AdSoyad nvarchar(50), @yas int
select @AdSoyad = 'Merve Do�an' , @yas = 25
select @AdSoyad as  'Ad Soyad' , @yas Ya�

-- Aralar�ndaki fark set ile de�er atama ayn� zamanda birden fazla de�i�kene de�er atanamazken, select ile atamada ayn� anda birden fazla de�i�kene de�er atan�r.

-- print @AdSoyad Print ekrana message verir, select ise ekrana tablo d�nd�r�r.

-- Hata Verir.
declare @urunAdi nvarchar(50)
set @urunAdi = (select ProductName from Products)
select @urunAdi as '�r�n Ad�'


-- Hata Vermez.
declare @urunAdi2 nvarchar(50)
set @urunAdi2 = (Select ProductName from Products Where ProductID = 7)
select @urunAdi2 as '�r�n Ad� 2'

-- Hata vermez fakat where siz kulland���m�zdan dolay� geriye anlams�z bir yan�t d�ner.
declare @urunAdi1 nvarchar(50)
select @urunAdi1 = ProductName from Products 
select @urunAdi1


declare @urunAdi3 nvarchar(50)
select @urunAdi3 = ProductName from Products Where ProductID = 5
select @urunAdi3


declare  @urunAdi4 nvarchar(50)
select top 1 @urunAdi4 = ProductName from Products Where UnitsInStock > 50
select @urunAdi4


-- De�i�kenlere ad,soyad ve ya� tan�mlayal�m, tan�mlad���m�z de�i�kenlere de�er atayal�m ve ekranda yazd�ral�m.

DECLARE @ad_ nvarchar(20), @soyad_ varchar(20), @yas_ int
set @ad_ = 'Emre Can'
select @soyad_ = 'Ayar' , @yas_ = 29
print @ad_
print @soyad_
print @yas_


-- Olu�turdu�umuz @n1 ve @n2 de�i�kenlerine bir de�er atamas� yapal�m ve bu iki de�erin ortalamas�n� al�p @ort  de�i�kenine aktaral�m ve ekranda g�sterelim.

declare @n1 int, @n2 int, @ort float
set @n1 = 85
select @n2 = 42
set @ort = (@n1+@n2)/2
print @ort