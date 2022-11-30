---VIEWS---

-- View'lar olu�turulurken d��ar�dan parametre almaz. (StoredProcedure ve UserDefinedFunctions lar alabilir.)
-- View'lar veri taban� nesnesidir. (Create,Alter,Drop ile kullan�l�r.) 
-- View'lar veriyi hi� bir zaman kendi �zerinde ta��mazlar.
-- Veri yine kendi ger�ek tablosunda durur ve Select sorgusunun sonucunu g�ncel olarak getirir.
-- View'lar sadece SELECT sorgular�yla kullan�labilir.

/*

Not: View'lar NO COLUMN NAME hatas� verir. Yani bir view olu�tururken isimiz kolon b�rakmamal�s�n�z.
StoreProcedure ve UserDefinedFunctions'lar NO COLUMN NAME hatas� vermez. Yani isimsiz kolonlara izin verirler.

Viewlar en temelde ve en genelde raporlama i�in kullan�l�rlar.

 1-) KISALTMAK ���N (Performans)

 Sistemde �ok falza kullanaca��m�z SELECT sorgular� varsa biz bunlar� view diyerek kaydedebiliyoruz.
 Yani view asl�nda kaydedilmi� SELECT sorgular�ndan ibarettir.
 �stedi�imiz sorguyu yaz�p bunu bir view olarak kaydedebiliriz.


 2-) G�VENL�K ���N 

 View i tan�mlama sebebimiz sadece sorgunun �ok fazla kullan�l�yor olmas� de�il, ayn� zamanda g�venlik sebebiyle de view tan�mlabilir, herkes SQL SERVER'da her �eyi g�rmemelidir.

 �rne�in sekreterim �al��anlar�ma ula�abilmeli fakat �al��anlar�m�n maa�lar�n� g�rmemeli. ��nk� bu durum �al��anlar aras�nda bir �ekememezlik yaratabilir. Bu nedenle sekreterin eri�ti�i alanlar� k�s�tlamak amac�yla da bir view olu�turabilir.

 View, verileri tek tablodan al�yorsa e�er Insert,Update,Delete i�lemlerini view �zerinden ger�ekle�tirebilirim.

 E�er birden fazla tablo varsa,
 iki sat�r etkileniyorsa Insert,Update,Delete yapamam. Sadece Select yapabilirim.
 tek tabloya ekleme yapacaksam Insert,Update,Delete yapabilirim.
*/

Select * from [Order Details]

-- View Olu�turma
Create View vw_AraToplamlar
as
	Select od.OrderID,od.ProductID,od.UnitPrice,od.Quantity,od.Discount,
	od.UnitPrice * od.Quantity * (1-Discount) 'Sub Total'
	from [Order Details] od


-- Olu�turulan View'� �a��rma ��lemi
Select * from vw_AraToplamlar

Insert into [Order Details] (OrderID,ProductID,UnitPrice,Quantity,Discount)
Values(10248,30,100,3,0)


-- View �zerinden Veri Ekleme (Olu�turulan View tek tablodan olmal�!....)
Insert vw_AraToplamlar (OrderID,ProductID,UnitPrice,Quantity,Discount)
values(10285,15,12,12,0.5)

Select * from vw_AraToplamlar Where OrderID = 10285

--�r�n�n Kategorilerini ve Tedarik�ikerini getiren bir view yaz�n�z.(UrunKategorileriVeTedarikcileri)
-- �r�n Ad�, Kategori Ad�, Tedarik�i Ad� g�z�ks�n

create view vw_UrunTedKat
as
	Select p.ProductName,c.CategoryName,s.CompanyName from Products p
	inner join Categories c on p.CategoryID = c.CategoryID
	inner join Suppliers s on p.SupplierID = s.SupplierID

Select * from vw_UrunTedKat

Select * from vw_UrunTedKat where UnitInStock > 50 -- Buras� �al��maz ��nk� UnitInStock view i�erisinde yer alm�yor.

Insert vw_UrunTedKat values ('Hede','Beverages','Hudo') -- Buras� �al��maz ��nk� view i�erisinde tek bir tablo yok. Birden fazla tablo yap�s� oldu�undan dolay� view �zerinden veri ekleme i�lemi ger�ekle�tirilemez.


-- With encryption => E�er view olu�turulurken bu parametreyi belirtirsek encrypt edilen bir nesnenin i�erisinde kodlar g�r�nmez. Bu sebepten dolay� ilgili view in kodlar� Design dan ula��lamaz olur.

create view vw_UrunTekKatStock
with encryption
as
	Select p.ProductName,p.UnitsInStock,c.CategoryName,s.CompanyName from Products p
	inner join Categories c on p.CategoryID = c.CategoryID
	inner join Suppliers s on p.SupplierID = s.SupplierID

Select * from vw_UrunTekKatStock Where UnitsInStock > 50 Order By UnitsInStock DESC


-- With Check Option => View �zerinden ilgili tabloya veri eklerken sadece, view in select sorgusundaki where ko�uluna uyan kay�tlar�n giribilmesi i�in kullan�lan parametredir.

Create View vw_CategoryId
as
	Select * from Products Where CategoryID = 7
	with check option

Select * from vw_CategoryId

Insert vw_CategoryId (ProductName) values ('Elma')  -- Bu sorgu �al��maz ��nk� With Check Option ile bir �art belirttik burada ekleme i�lemi yaparken bu �art� bildirmedi�imizden dolay� bu i�lem ger�ekle�tirilmiyor.

Insert vw_CategoryId (ProductName,CategoryID) values ('Elma',1) -- Bu sorgu �al��maz ��nk� Witch Check Option ile belirtti�imiz CategoryID de�eri 7 idi. Fakat biz burda bu de�eri 1 olarak g�nderdik. Bu sebepten dolay� sorgumuz �al��mayacakt�r.

Insert vw_CategoryId(ProductName,CategoryID) VALUES ('Elma',7)

Select * from Products


-- View with schemabinding ile olu�turulan kolonlar korumaya al�n�r. Kolonlar ilgili view da hi� bir �ekilde de�i�tirelemez ve silinemez. 
-- NOT: with schemabinding ile olu�turulan View larda tablo isimlerinin ba��na "dbo" ibaresini eklememiz gerekmektedir. Bu ibare �zerinden tablonun �ema bilgisini okunuyor.

Create view vw_UrunTedKat1
with schemabinding
as
	Select p.ProductName,c.CategoryName,s.CompanyName from dbo.Products p 
	inner join dbo.Categories c on p.CategoryID = c.CategoryID
	inner join dbo.Suppliers s on p.SupplierID = s.SupplierID

Select * from vw_UrunTedKat1


--View larda Order By sorgular� TOP deyimi olmadan kullan�lmaz.

Create View vw_StoktaEksikOlanUrunler
as
	Select top 10 p.ProductName,p.UnitsInStock,p.UnitsOnOrder from Products p Order By p.UnitsInStock desc

Select * from vw_StoktaEksikOlanUrunler