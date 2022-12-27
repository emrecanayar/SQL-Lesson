-- TRANSACTION --

-- TRY CATCH => SQL Server'da TRY CATCH hata ayýklamada kullanýlan bir mekanizmadýr. Yapýlan hatayý yakalamayý ve bu hata hakkýnda bilgi sahibi olmamýzda önemli rolü vardýr. Genel olarak kullaným mantýðý aþaðýdaki gibidir.

/*
BEGIN TRY
	-- Hata oluþturabilecek kod bloðunu yazýyoruz.
END TRY
BEGIN CATCH
	-- Hata oluþunca hatanýn yakalandýðý kýsým buraya yazýlýr.

	SELECT ERROR_LINE		() AS 'Hata Satýrý'
		   ERROR_NUMBER		() AS 'Hata Sayýsý'
		   ERROR_SEVERITY   () AS 'Hata Önemi'
		   ERROR_STATE		() AS 'Hata Durumu'
		   ERROR_MESSAGE	() AS 'Hata Mesajý'

END CATCH

ERROR_SEVERITY : () Fonksiyonunda hata dereceleri aþaðýdaki gibidir.
0 ve 10  : Kullanýcýnýn veri giriþinden kaynaklý hatalar.
11 - 16  : Kullanýcýnýn düzeltebileceði hatalar.
17		 : Yetersiz kaynak hatasý (Diskin dolu olmasý yada tablonun salt okunur olmasý vs. gibi)
18		 : Yazýlýmdan kaynaklý hatalar
19	     : Constraint'lere takýlan hatalar
20 - 25  : Kritik hatalar

RAISERROR => TRY CATCH ile yakalanamayan hatalarý kullanýcýlara bildirmek için TRY CATCH YAPISI içerisinde RAISERROR fonksiyonu kullanabilirsiniz. Ayrýca bu fonksiyon ile kullanýcýya istediðimiz mesajý verme hakkýna da sahibiz.
*/


-- TRY CATCH KULLANIMI --
BEGIN TRY
Select Islem = 255/0;
END TRY
BEGIN CATCH
SELECT ERROR_LINE()	    AS 'Hata Satýrý',
	   ERROR_NUMBER()   AS 'Hata Sayýsý',
	   ERROR_SEVERITY() AS 'Hata Önemi',
	   ERROR_STATE()	AS 'Hata Durumu',
	   ERROR_MESSAGE()	AS 'Hata Mesajý'
END CATCH



-- Configuration Functions 
Select @@VERSION				--> SQL Server'ýn versiyonu hakkýnda bilgi verir.
Select @@LANGUAGE				--> SQL Server üzerinde kullanýlan dil hakkýnda bilgi verir.
Select @@SERVERNAME				--> SQL Server'ýn ismini getirir.


-- BankDB adýnda bir database oluþturun.
-- Bu database içerisine Hesap (Id,Ad,Bakiye,TcKimlikNo) adýnda bir tablo oluþturun
-- Oluþturduðumuz bu tabloya en az 3 tane kayýt ekleyin.

Create Database BankDB

use BankDB
create table Hesap(
Id int primary key identity,
Ad nvarchar(50),
Bakiye money,
TcKimlikNo char(11)
)

Insert Hesap (Ad,Bakiye,TcKimlikNo)
Values ('Miran',1000,'12345678910'),('Merve',0,'23456789101'),('Aden',500,'34567891012')

Select * from Hesap


-- Transaction kullanmazsak.

begin try
Update Hesap Set Bakiye -=200 where TcKimlikNo = '34567891012'

raiserror ('Elektrikler kesildi',16,2)

Update Hesap Set Bakiye +=200 Where TcKimlikNo = '23456789101'
end try
begin catch

Print 'Beklenmedik bir hata meydana geldi.'
end catch


-- Transaction kullanýrsak

begin try
	begin tran -- Transaction baþlatýlýr.
Update Hesap Set Bakiye -=200 where TcKimlikNo = '34567891012'
raiserror ('Elektrikler kesildi',16,2)
Update Hesap Set Bakiye +=200 Where TcKimlikNo = '23456789101'
	commit tran -- Transaction baþarýlý bir þekilde tamamlanýr.

end try
begin catch
Print 'Beklenmedik bir hata meydana geldi.'
rollback tran -- Transaction baþarýsýz bir þekilde sonlandýrýlýr ve yapýlan iþlemler geri alýnýr.
end catch


-- Transaction da checkpoint kullanýmý

Begin Try
	begin tran
	Insert Hesap Values ('Büþra',1000,'98765432101')
	commit save tran BakiyeOlustu -- check point
	Update Hesap Set Bakiye -=500 where TcKimlikNo = '98765432101'
	raiserror ('Elektrikler kesildi',16,2)
	Update Hesap Set Bakiye +=500 Where TcKimlikNo = '23456789101'
	commit tran

End Try
Begin Catch
Print 'Beklenmedik bir hata meydana geldi.'
Rollback tran BakiyeOlustu
End Catch

