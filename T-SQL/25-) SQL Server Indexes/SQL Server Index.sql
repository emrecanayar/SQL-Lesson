-- SQL SERVER INDEX KULLANIMI --
-- Index kullan�m� bize performans sa�lar.
-- �ok kay�tl� tablolarda verilerin getirilmesi bazen dakikalar alabilir, biz index yap�lar�n� kullanarak dakikalarca s�ren sorgulardan d�nen datalar� saniyeler i�erisinde elde edebilriz.
-- Index kullan�l�rken hard disk te yer kaplar. Bu durum da maliyeti artt�r�r. Bu sebepten dolay� her tablo i�in index d���n�lmez sadece �ok kullan�lan ve h�z gerektirecek olan tablolar belirlenip onlar �zerinde index kullan�m� ger�ekle�tirilmelidir.


create database IndexDeneme
go

use IndexDeneme
go
create table Kisi(
Id int primary key identity,
Ad nvarchar(50),
Soyad nvarchar(50),
TelNo char(11)
)


declare @i int = 1
while @i<250000   -- Buray� de�i�tirerek veri taban�na olduk�a fazla kay�t ekleyin.
begin 

	insert Kisi select Ad = 'Emre Can'+CAST(@i as nvarchar(30)),
	Soyad = 'Ayar' + CAST(@i as nvarchar(30)),
	TelNo = Cast(@i as char(11))
	set @i+=1

end

Select Count(*) from Kisi

set statistics IO on -- Sorgunun ka� logical read yapt���n� g�sterir.
set statistics Time on -- Sorgunun ka� ms de yap�ld���n� g�rebiliriz.
Select * from Kisi


set statistics IO on
set statistics Time On
Select * from Kisi Where Id = 999

-- E�er tablo olu�tururken Id alan�n� primary key ve Identity olarak belirtirsek Clustred Index SQL Server taraf�ndan bizim i�in otomatik olu�turulur.
-- Clustered index olu�turma (Genelde Id alanlar� i�in olu�turulur.)
create clustered index KisiIndexle
on Kisi(Id)


-- Var olan clustred index i de�i�tirme
create clustered index KisiIndexle
On Kisi(Id)
with drop_existing, -- Var olan indexi siler yerine tekrar olu�turur.
FillFactor = 60, -- Doluluk oran�
Pad_Index -- Intermatid lavel olarak d�zenlenir.


set statistics IO on
set statistics Time on
Select * from Kisi Where TelNo = '84934'

-- Non-Clustered index olu�turma
create nonclustered index TeleGoreIndexle on Kisi(TelNo)

set statistics IO on
set statistics Time on
Select Ad,Soyad,TelNo from Kisi Where TelNo = '84934'

-- Var olan Non-Clustered index i de�i�tirme
create nonclustered index TeleGoreIndexle on Kisi(TelNo)
with drop_existing,
fillfactor = 60,
pad_index

set statistics IO on
set statistics Time on
Select Ad,Soyad,TelNo from Kisi Where TelNo = '84934'

-- Database hakk�nda performans bilgilerini getirir.
dbcc showcontig

-- Kisi tablosu hakk�nda performans bilgilerini getirir.
dbcc showcontig (Kisi)

-- Kisi tablosu hakk�nda k�sa bilgi almak isterseniz.
dbcc showcontig (Kisi,1) with fast

-- Kisi tablosunun TeleGoreIndexle indexi hakk�nda bilgi alal�m.
dbcc showcontig (Kisi,TeleGoreIndexle)

-- Mevcut veri taban�n�n t�m table ve indexleri hakk�nda bilgi alal�m.
dbcc showcontig with tableresults,all_indexes