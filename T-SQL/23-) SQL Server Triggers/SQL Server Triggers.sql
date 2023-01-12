--- TRIGGERS -- 
/*

1-) DML Triggers (Insert,Update,Delete) -- Tablo seviyesinde �al���r.
2-) DDL Triggers (Create,Alter,Drop) -- Veri taban� seviyesinde �al���r
3-) Logon Triggers

Trigger lar otomatik olarak �al��an SP (Store Procedure) lerdir.
Klas�rleme yap�s�nda �im�ek ikonu ile g�sterilirler.

TRIGGER

Bir tablo �zerinde INSERT,DELETE ve UPDATE i�lemlerinden biri yap�ld���nda otomatik olarak devreye girmesini istedi�imiz i�lemlerimiz varsa bunu Trigger kullanarak ger�ekle�tirebiliriz.

Bu otomatik i�lemlerde bize yard�mc� olacak iki tane sanal tablo vard�r. Bunlar INSERTED ve DELETED tablolar�.

Bu tablolar trigger in �zerinde tan�ml� oldu�u base tablo ile birebir ayn� yap�dad�r. Yani b�ylece girilen bir kayd�n INSERTED tablosundan, silinen bir kayd� da DELETED tablosundan elde edebiliriz. UPDATE i�lemi i�in ise �ncelikle var olan bir kayd�n silinmesi, daha sonra bu kayd�n tekrardan eklenerek tabloya girilmesi oldu�undan dolay� UPDATE i�eleminde INSERTED ve DELETED tablolar�n�n ikisinden de faydalan�l�r. Yan� k�saca UPDATED diye bir tablomuz yok.

Not : Trigger'lar otomatik olarak tetiklenirler. Biz kendimiz istedi�imiz zaman tetikleyemeyiz.

Trigger lar SQL Server �n �nemli bile�enlerindendir. Trigger lar Database Adminlerin ellerindeki sihirli silahlardan sihirli g��lerden biridir. Tetikleyeci (trigger) yap�s�, ili�kisel veri taban� y�netim sistemlerinde, bir tabloda belirli olaylar meydana geldi�inde veya gelmeden �nce otomatik olarak �al��an �zel bir stored procedure t�r�d�r.

Bir tabloda ekleme, g�ncelleme ve silme i�lemlerinden biri ger�ekle�ti�inde veya ger�ekle�meden �nce , ayn� tabloda veya ba�ka bir tabloda belirli i�lemlerin otomatik olarak yap�lmas�n� istedi�imizde, trigger yap�s�n� kullan�r�z. �rnek verecek olursak, sat�� tablosunda sat�� i�lemi ger�ekle�ti�inde �r�n�n stok miktar�n�n eksiltilmesi, banka hesab�nda i�lem ger�ekle�tikten sonra otomatik olarak email g�nderilmesi gibi �rnekler verilebilir.


DML Triggerlar'da AFTER(FOR) ve INSTEAD OF olmak �zere ikiye ayr�l�rlar.

AFTER Trigger'i : Yapt���m�z i�lemden (INSERT,UPDATE,DELETE) sonra devreye giren trigger �e�itidir.

*/


--1.) DML Trigger => After Triggers

create trigger trg_CalisanUyarisi
on Employees
after insert
as
	Select 'yeni �al��an giri�ini IK''ya bildiriniz' as A��klama -- Trigger burada olu�turuldu.


Insert Employees (FirstName,LastName) values ('Ozan','�ift�i')

Select * from Employees



-- Sipari� verdi�imde sipari� verdi�im miktar kadar stoktaki miktardan d���ls�n.
create trigger trg_StokGuncelle
on [Order Details]
after insert
as
	declare @SatilanUrunId int, @SatilanUrunMiktar int
	Select @SatilanUrunId = ProductID, @SatilanUrunMiktar = Quantity from inserted
	--Trigger larda Inserted ve Deleted tablolar� vard�r. Ram de tek sat�rl�k tablolar �eklinde olu�urlar.
	-- Update  tablosu yoktur. ��nk� update i�lemi delete ve insert i�lemlerinin ard arda �al��mas�ndan meydana gelir. Update i�lemleri i�in Deleted ve Inserted tablolar�ndan faydanalanarak i�lemler ger�ekle�tirilebilir.

	Update Products Set UnitsInStock -= @SatilanUrunMiktar Where ProductID = @SatilanUrunId

Select * from Products Where ProductID = 15

Insert [Order Details] (OrderID,ProductID,UnitPrice,Quantity,Discount)
Values (10252,15,5,10,0)

Select * from [Order Details] Where OrderID = 10252


-- Order Details tablosunda sat�lan �r�n miktar� g�ncellendi�inde �r�n�n sto�uda g�ncellensin.
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


-- Insert, Update, Delete i�lemlerinin izlenmesi
create trigger trg_MesajVer
on [Order Details]
for insert,update,delete
as
	if(Exists(select * from deleted) and Exists(select * from inserted))
		print 'Update i�lemi ba�ar�yla ger�ekle�ti.'
	else if(Exists(select * from deleted))
		print 'Delete i�lemi ba�ar�yla ger�ekle�ti.'
	else if (Exists(select * from inserted))
		print 'Insert i�lemi ba�ar�yla ger�ekle�ti.'
	

Select * from [Order Details]
Delete from [Order Details] Where OrderID = 10251

Insert [Order Details] (OrderID,ProductID,UnitPrice,Quantity,Discount)
Values (10251,10,5,10,0)

Update [Order Details] Set Quantity = 21 Where OrderID = 10248 and ProductID = 11


-- �al��an�n durumu hakk�nda bilgi veren trigger
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

		print Concat(Cast(@employeeId as nvarchar),' ',' numaral� ',@eskiIsim,' ',@eskiSoyisim,' adl� �al��an ',@yeniIsim,' ',@yeniSoyisim,' ','olarak g�ncellemi�tir')

		end
	
	else if(Exists(select * from deleted))
		begin 
		select @eskiIsim=FirstName, @eskiSoyisim = LastName from deleted
		print @eskiIsim+' '+@eskiSoyisim+ ' adl� �al��an i�ten ayr�lm��t�r'
		end

	else if(Exists(select * from inserted))
		begin
			select @yeniIsim=FirstName, @yeniSoyisim = LastName from inserted
			print @yeniIsim+' '+@yeniSoyisim+ ' adl� �al��an i�e al�nm��t�r'
		end

Select * from Employees

Update Employees Set FirstName = 'B��ra' , LastName = 'Ayar' Where EmployeeID = 4
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
-- DDL Trigglar database �zerinde i�lem yap�lan trigger lard�r.
-- E�er izlenen i�lemin yap�lmas� istenmiyorsa rollback deyimi ile geri alabiliriz.

create trigger ViewOlusturuldu
on Database
after Drop_View
as 
	print 'View Silindi.'


-- Serverdaki b�t�n databaseler �zerinde bir trigger olu�turmak istiyorsak all server parametresini kullanmal�y�z.

create trigger VeritabaniOlusturmaYetkisi
on all server
for create_database
as
	Raiserror('Yetkiniz bulunmamaktad�r',16,2)
	rollback


create database TestTrigger


disable trigger VeritabaniOlusturmaYetkisi on all server -- Var olan triggeri silmez sadece kullan�m durumunu pasife �eker.

enable trigger VeritabaniOlusturmaYetkisi on all server -- Var olan triggerin durumu pasiften aktife �eker.