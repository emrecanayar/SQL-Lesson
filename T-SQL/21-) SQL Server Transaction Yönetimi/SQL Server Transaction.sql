-- TRANSACTION --

-- TRY CATCH => SQL Server'da TRY CATCH hata ay�klamada kullan�lan bir mekanizmad�r. Yap�lan hatay� yakalamay� ve bu hata hakk�nda bilgi sahibi olmam�zda �nemli rol� vard�r. Genel olarak kullan�m mant��� a�a��daki gibidir.

/*
BEGIN TRY
	-- Hata olu�turabilecek kod blo�unu yaz�yoruz.
END TRY
BEGIN CATCH
	-- Hata olu�unca hatan�n yakaland��� k�s�m buraya yaz�l�r.

	SELECT ERROR_LINE		() AS 'Hata Sat�r�'
		   ERROR_NUMBER		() AS 'Hata Say�s�'
		   ERROR_SEVERITY   () AS 'Hata �nemi'
		   ERROR_STATE		() AS 'Hata Durumu'
		   ERROR_MESSAGE	() AS 'Hata Mesaj�'

END CATCH

ERROR_SEVERITY : () Fonksiyonunda hata dereceleri a�a��daki gibidir.
0 ve 10  : Kullan�c�n�n veri giri�inden kaynakl� hatalar.
11 - 16  : Kullan�c�n�n d�zeltebilece�i hatalar.
17		 : Yetersiz kaynak hatas� (Diskin dolu olmas� yada tablonun salt okunur olmas� vs. gibi)
18		 : Yaz�l�mdan kaynakl� hatalar
19	     : Constraint'lere tak�lan hatalar
20 - 25  : Kritik hatalar

RAISERROR => TRY CATCH ile yakalanamayan hatalar� kullan�c�lara bildirmek i�in TRY CATCH YAPISI i�erisinde RAISERROR fonksiyonu kullanabilirsiniz. Ayr�ca bu fonksiyon ile kullan�c�ya istedi�imiz mesaj� verme hakk�na da sahibiz.
*/


-- TRY CATCH KULLANIMI --
BEGIN TRY
Select Islem = 255/0;
END TRY
BEGIN CATCH
SELECT ERROR_LINE()	    AS 'Hata Sat�r�',
	   ERROR_NUMBER()   AS 'Hata Say�s�',
	   ERROR_SEVERITY() AS 'Hata �nemi',
	   ERROR_STATE()	AS 'Hata Durumu',
	   ERROR_MESSAGE()	AS 'Hata Mesaj�'
END CATCH



-- Configuration Functions 
Select @@VERSION				--> SQL Server'�n versiyonu hakk�nda bilgi verir.
Select @@LANGUAGE				--> SQL Server �zerinde kullan�lan dil hakk�nda bilgi verir.
Select @@SERVERNAME				--> SQL Server'�n ismini getirir.


-- BankDB ad�nda bir database olu�turun.
-- Bu database i�erisine Hesap (Id,Ad,Bakiye,TcKimlikNo) ad�nda bir tablo olu�turun
-- Olu�turdu�umuz bu tabloya en az 3 tane kay�t ekleyin.

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


-- Transaction kullan�rsak

begin try
	begin tran -- Transaction ba�lat�l�r.
Update Hesap Set Bakiye -=200 where TcKimlikNo = '34567891012'
raiserror ('Elektrikler kesildi',16,2)
Update Hesap Set Bakiye +=200 Where TcKimlikNo = '23456789101'
	commit tran -- Transaction ba�ar�l� bir �ekilde tamamlan�r.

end try
begin catch
Print 'Beklenmedik bir hata meydana geldi.'
rollback tran -- Transaction ba�ar�s�z bir �ekilde sonland�r�l�r ve yap�lan i�lemler geri al�n�r.
end catch


-- Transaction da checkpoint kullan�m�

Begin Try
	begin tran
	Insert Hesap Values ('B��ra',1000,'98765432101')
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

