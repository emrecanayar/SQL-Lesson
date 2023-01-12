--- TRIGGERS -- 
/*

1-) DML Triggers (Insert,Update,Delete) -- Tablo seviyesinde çalýþýr.
2-) DDL Triggers (Create,Alter,Drop) -- Veri tabaný seviyesinde çalýþýr
3-) Logon Triggers

Trigger lar otomatik olarak çalýþan SP (Store Procedure) lerdir.
Klasörleme yapýsýnda þimþek ikonu ile gösterilirler.

TRIGGER

Bir tablo üzerinde INSERT,DELETE ve UPDATE iþlemlerinden biri yapýldýðýnda otomatik olarak devreye girmesini istediðimiz iþlemlerimiz varsa bunu Trigger kullanarak gerçekleþtirebiliriz.

Bu otomatik iþlemlerde bize yardýmcý olacak iki tane sanal tablo vardýr. Bunlar INSERTED ve DELETED tablolarý.

Bu tablolar trigger in üzerinde tanýmlý olduðu base tablo ile birebir ayný yapýdadýr. Yani böylece girilen bir kaydýn INSERTED tablosundan, silinen bir kaydý da DELETED tablosundan elde edebiliriz. UPDATE iþlemi için ise öncelikle var olan bir kaydýn silinmesi, daha sonra bu kaydýn tekrardan eklenerek tabloya girilmesi olduðundan dolayý UPDATE iþeleminde INSERTED ve DELETED tablolarýnýn ikisinden de faydalanýlýr. Yaný kýsaca UPDATED diye bir tablomuz yok.

Not : Trigger'lar otomatik olarak tetiklenirler. Biz kendimiz istediðimiz zaman tetikleyemeyiz.

Trigger lar SQL Server ýn önemli bileþenlerindendir. Trigger lar Database Adminlerin ellerindeki sihirli silahlardan sihirli güçlerden biridir. Tetikleyeci (trigger) yapýsý, iliþkisel veri tabaný yönetim sistemlerinde, bir tabloda belirli olaylar meydana geldiðinde veya gelmeden önce otomatik olarak çalýþan özel bir stored procedure türüdür.

Bir tabloda ekleme, güncelleme ve silme iþlemlerinden biri gerçekleþtiðinde veya gerçekleþmeden önce , ayný tabloda veya baþka bir tabloda belirli iþlemlerin otomatik olarak yapýlmasýný istediðimizde, trigger yapýsýný kullanýrýz. Örnek verecek olursak, satýþ tablosunda satýþ iþlemi gerçekleþtiðinde ürünün stok miktarýnýn eksiltilmesi, banka hesabýnda iþlem gerçekleþtikten sonra otomatik olarak email gönderilmesi gibi örnekler verilebilir.


DML Triggerlar'da AFTER(FOR) ve INSTEAD OF olmak üzere ikiye ayrýlýrlar.

AFTER Trigger'i : Yaptýðýmýz iþlemden (INSERT,UPDATE,DELETE) sonra devreye giren trigger çeþitidir.

*/


--1.) DML Trigger => After Triggers

create trigger trg_CalisanUyarisi
on Employees
after insert
as
	Select 'yeni çalýþan giriþini IK''ya bildiriniz' as Açýklama -- Trigger burada oluþturuldu.


Insert Employees (FirstName,LastName) values ('Ozan','Çiftçi')

Select * from Employees



-- Sipariþ verdiðimde sipariþ verdiðim miktar kadar stoktaki miktardan düþülsün.
create trigger trg_StokGuncelle
on [Order Details]
after insert
as
	declare @SatilanUrunId int, @SatilanUrunMiktar int
	Select @SatilanUrunId = ProductID, @SatilanUrunMiktar = Quantity from inserted
	--Trigger larda Inserted ve Deleted tablolarý vardýr. Ram de tek satýrlýk tablolar þeklinde oluþurlar.
	-- Update  tablosu yoktur. Çünkü update iþlemi delete ve insert iþlemlerinin ard arda çalýþmasýndan meydana gelir. Update iþlemleri için Deleted ve Inserted tablolarýndan faydanalanarak iþlemler gerçekleþtirilebilir.

	Update Products Set UnitsInStock -= @SatilanUrunMiktar Where ProductID = @SatilanUrunId

Select * from Products Where ProductID = 15

Insert [Order Details] (OrderID,ProductID,UnitPrice,Quantity,Discount)
Values (10252,15,5,10,0)

Select * from [Order Details] Where OrderID = 10252


-- Order Details tablosunda satýlan ürün miktarý güncellendiðinde ürünün stoðuda güncellensin.
create trigger trg_StokEkleCikar
on [Order Details]
after update
as
	declare @ProductId int, @EskiMiktar int, @YeniMiktar int
	Select  @ProductId = ProductId, @EskiMiktar = Quantity from deleted -- Quantity : 21 , ProductId : 11
	Select @YeniMiktar = Quantity from inserted							-- Quantity : 15

	Update Products Set UnitsInStock +=(@EskiMiktar - @YeniMiktar) Where ProductID = @ProductId


Select * from Products  Where ProductID = 11  
Select * from [Order Details] Where OrderID = 10248 and ProductID = 11

Update [Order Details] Set  Quantity = 20  Where OrderId = 10248 and ProductID = 11


-- Insert, Update, Delete iþlemlerinin izlenmesi
create trigger trg_MesajVer
on [Order Details]
for insert,update,delete
as
	if(Exists(select * from deleted) and Exists(select * from inserted))
		print 'Update iþlemi baþarýyla gerçekleþti.'
	else if(Exists(select * from deleted))
		print 'Delete iþlemi baþarýyla gerçekleþti.'
	else if (Exists(select * from inserted))
		print 'Insert iþlemi baþarýyla gerçekleþti.'
	

Select * from [Order Details]
Delete from [Order Details] Where OrderID = 10251

Insert [Order Details] (OrderID,ProductID,UnitPrice,Quantity,Discount)
Values (10251,10,5,10,0)

Update [Order Details] Set Quantity = 21 Where OrderID = 10248 and ProductID = 11


-- Çalýþanýn durumu hakkýnda bilgi veren trigger
create trigger trg_CalisaniMesajVer
on Employees
for insert,update,delete
as
	declare @eskiIsim nvarchar(50), @eskiSoyisim nvarchar(50)
	declare @yeniIsim nvarchar(50), @yeniSoyisim nvarchar(50)
	declare @employeeId int

	if(Exists(select * from inserted) and Exists(select * from deleted))
		begin
		
		select @eskiIsim = FirstName, @eskiSoyisim = LastName, @employeeId = EmployeeID from deleted
		select @yeniIsim = FirstName, @yeniSoyisim = LastName from inserted

		print Concat(Cast(@employeeId as nvarchar),' ',' numaralý ',@eskiIsim,' ',@eskiSoyisim,' adlý çalýþan ',@yeniIsim,' ',@yeniSoyisim,' ','olarak güncellemiþtir')

		end
	
	else if(Exists(select * from deleted))
		begin 
		select @eskiIsim=FirstName, @eskiSoyisim = LastName from deleted
		print @eskiIsim+' '+@eskiSoyisim+ ' adlý çalýþan iþten ayrýlmýþtýr'
		end

	else if(Exists(select * from inserted))
		begin
			select @yeniIsim=FirstName, @yeniSoyisim = LastName from inserted
			print @yeniIsim+' '+@yeniSoyisim+ ' adlý çalýþan iþe alýnmýþtýr'
		end

Select * from Employees

Update Employees Set FirstName = 'Büþra' , LastName = 'Ayar' Where EmployeeID = 4
Delete from Employees Where EmployeeID = 23
Insert Employees (FirstName,LastName) values ('Aden','Ayar')


Create database Yedek

create trigger KargoYedekle
on Shippers
after delete
as	
	declare @sirketAdi nvarchar(50), @cepTelefonu nvarchar(20)
	Select @sirketAdi = CompanyName, @cepTelefonu = Phone from deleted
	Insert Yedek.dbo.KargoYedek (SirketAdi,CepTelefonu) Values (@sirketAdi,@cepTelefonu)


Select * from Shippers
Delete from Shippers Where ShipperID = 18
Select * from Yedek.dbo.KargoYedek


-- 2. DDL Trigger
-- DDL Trigglar database üzerinde iþlem yapýlan trigger lardýr.
-- Eðer izlenen iþlemin yapýlmasý istenmiyorsa rollback deyimi ile geri alabiliriz.

create trigger ViewOlusturuldu
on Database
after Drop_View
as 
	print 'View Silindi.'


-- Serverdaki bütün databaseler üzerinde bir trigger oluþturmak istiyorsak all server parametresini kullanmalýyýz.

create trigger VeritabaniOlusturmaYetkisi
on all server
for create_database
as
	Raiserror('Yetkiniz bulunmamaktadýr',16,2)
	rollback


create database TestTrigger


disable trigger VeritabaniOlusturmaYetkisi on all server -- Var olan triggeri silmez sadece kullaným durumunu pasife çeker.

enable trigger VeritabaniOlusturmaYetkisi on all server -- Var olan triggerin durumu pasiften aktife çeker.