---VIEWS---

-- View'lar oluþturulurken dýþarýdan parametre almaz. (StoredProcedure ve UserDefinedFunctions lar alabilir.)
-- View'lar veri tabaný nesnesidir. (Create,Alter,Drop ile kullanýlýr.) 
-- View'lar veriyi hiç bir zaman kendi üzerinde taþýmazlar.
-- Veri yine kendi gerçek tablosunda durur ve Select sorgusunun sonucunu güncel olarak getirir.
-- View'lar sadece SELECT sorgularýyla kullanýlabilir.

/*

Not: View'lar NO COLUMN NAME hatasý verir. Yani bir view oluþtururken isimiz kolon býrakmamalýsýnýz.
StoreProcedure ve UserDefinedFunctions'lar NO COLUMN NAME hatasý vermez. Yani isimsiz kolonlara izin verirler.

Viewlar en temelde ve en genelde raporlama için kullanýlýrlar.

 1-) KISALTMAK ÝÇÝN (Performans)

 Sistemde çok falza kullanacaðýmýz SELECT sorgularý varsa biz bunlarý view diyerek kaydedebiliyoruz.
 Yani view aslýnda kaydedilmiþ SELECT sorgularýndan ibarettir.
 Ýstediðimiz sorguyu yazýp bunu bir view olarak kaydedebiliriz.


 2-) GÜVENLÝK ÝÇÝN 

 View i tanýmlama sebebimiz sadece sorgunun çok fazla kullanýlýyor olmasý deðil, ayný zamanda güvenlik sebebiyle de view tanýmlabilir, herkes SQL SERVER'da her þeyi görmemelidir.

 Örneðin sekreterim çalýþanlarýma ulaþabilmeli fakat çalýþanlarýmýn maaþlarýný görmemeli. Çünkü bu durum çalýþanlar arasýnda bir çekememezlik yaratabilir. Bu nedenle sekreterin eriþtiði alanlarý kýsýtlamak amacýyla da bir view oluþturabilir.

 View, verileri tek tablodan alýyorsa eðer Insert,Update,Delete iþlemlerini view üzerinden gerçekleþtirebilirim.

 Eðer birden fazla tablo varsa,
 iki satýr etkileniyorsa Insert,Update,Delete yapamam. Sadece Select yapabilirim.
 tek tabloya ekleme yapacaksam Insert,Update,Delete yapabilirim.
*/

Select * from [Order Details]

-- View Oluþturma
Create View vw_AraToplamlar
as
	Select od.OrderID,od.ProductID,od.UnitPrice,od.Quantity,od.Discount,
	od.UnitPrice * od.Quantity * (1-Discount) 'Sub Total'
	from [Order Details] od


-- Oluþturulan View'ý Çaðýrma Ýþlemi
Select * from vw_AraToplamlar

Insert into [Order Details] (OrderID,ProductID,UnitPrice,Quantity,Discount)
Values(10248,30,100,3,0)


-- View Üzerinden Veri Ekleme (Oluþturulan View tek tablodan olmalý!....)
Insert vw_AraToplamlar (OrderID,ProductID,UnitPrice,Quantity,Discount)
values(10285,15,12,12,0.5)

Select * from vw_AraToplamlar Where OrderID = 10285

--Ürünün Kategorilerini ve Tedarikçikerini getiren bir view yazýnýz.(UrunKategorileriVeTedarikcileri)
-- Ürün Adý, Kategori Adý, Tedarikçi Adý gözüksün

create view vw_UrunTedKat
as
	Select p.ProductName,c.CategoryName,s.CompanyName from Products p
	inner join Categories c on p.CategoryID = c.CategoryID
	inner join Suppliers s on p.SupplierID = s.SupplierID

Select * from vw_UrunTedKat

Select * from vw_UrunTedKat where UnitInStock > 50 -- Burasý çalýþmaz çünkü UnitInStock view içerisinde yer almýyor.

Insert vw_UrunTedKat values ('Hede','Beverages','Hudo') -- Burasý çalýþmaz çünkü view içerisinde tek bir tablo yok. Birden fazla tablo yapýsý olduðundan dolayý view üzerinden veri ekleme iþlemi gerçekleþtirilemez.


-- With encryption => Eðer view oluþturulurken bu parametreyi belirtirsek encrypt edilen bir nesnenin içerisinde kodlar görünmez. Bu sebepten dolayý ilgili view in kodlarý Design dan ulaþýlamaz olur.

create view vw_UrunTekKatStock
with encryption
as
	Select p.ProductName,p.UnitsInStock,c.CategoryName,s.CompanyName from Products p
	inner join Categories c on p.CategoryID = c.CategoryID
	inner join Suppliers s on p.SupplierID = s.SupplierID

Select * from vw_UrunTekKatStock Where UnitsInStock > 50 Order By UnitsInStock DESC


-- With Check Option => View üzerinden ilgili tabloya veri eklerken sadece, view in select sorgusundaki where koþuluna uyan kayýtlarýn giribilmesi için kullanýlan parametredir.

Create View vw_CategoryId
as
	Select * from Products Where CategoryID = 7
	with check option

Select * from vw_CategoryId

Insert vw_CategoryId (ProductName) values ('Elma')  -- Bu sorgu çalýþmaz çünkü With Check Option ile bir þart belirttik burada ekleme iþlemi yaparken bu þartý bildirmediðimizden dolayý bu iþlem gerçekleþtirilmiyor.

Insert vw_CategoryId (ProductName,CategoryID) values ('Elma',1) -- Bu sorgu çalýþmaz çünkü Witch Check Option ile belirttiðimiz CategoryID deðeri 7 idi. Fakat biz burda bu deðeri 1 olarak gönderdik. Bu sebepten dolayý sorgumuz çalýþmayacaktýr.

Insert vw_CategoryId(ProductName,CategoryID) VALUES ('Elma',7)

Select * from Products


-- View with schemabinding ile oluþturulan kolonlar korumaya alýnýr. Kolonlar ilgili view da hiç bir þekilde deðiþtirelemez ve silinemez. 
-- NOT: with schemabinding ile oluþturulan View larda tablo isimlerinin baþýna "dbo" ibaresini eklememiz gerekmektedir. Bu ibare üzerinden tablonun þema bilgisini okunuyor.

Create view vw_UrunTedKat1
with schemabinding
as
	Select p.ProductName,c.CategoryName,s.CompanyName from dbo.Products p 
	inner join dbo.Categories c on p.CategoryID = c.CategoryID
	inner join dbo.Suppliers s on p.SupplierID = s.SupplierID

Select * from vw_UrunTedKat1


--View larda Order By sorgularý TOP deyimi olmadan kullanýlmaz.

Create View vw_StoktaEksikOlanUrunler
as
	Select top 10 p.ProductName,p.UnitsInStock,p.UnitsOnOrder from Products p Order By p.UnitsInStock desc

Select * from vw_StoktaEksikOlanUrunler