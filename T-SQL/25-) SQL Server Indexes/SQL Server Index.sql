-- SQL SERVER INDEX KULLANIMI --
-- Index kullanýmý bize performans saðlar.
-- Çok kayýtlý tablolarda verilerin getirilmesi bazen dakikalar alabilir, biz index yapýlarýný kullanarak dakikalarca süren sorgulardan dönen datalarý saniyeler içerisinde elde edebilriz.
-- Index kullanýlýrken hard disk te yer kaplar. Bu durum da maliyeti arttýrýr. Bu sebepten dolayý her tablo için index düþünülmez sadece çok kullanýlan ve hýz gerektirecek olan tablolar belirlenip onlar üzerinde index kullanýmý gerçekleþtirilmelidir.


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
while @i<250000   -- Burayý deðiþtirerek veri tabanýna oldukça fazla kayýt ekleyin.
begin 

	insert Kisi select Ad = 'Emre Can'+CAST(@i as nvarchar(30)),
	Soyad = 'Ayar' + CAST(@i as nvarchar(30)),
	TelNo = Cast(@i as char(11))
	set @i+=1

end

Select Count(*) from Kisi

set statistics IO on -- Sorgunun kaç logical read yaptýðýný gösterir.
set statistics Time on -- Sorgunun kaç ms de yapýldýðýný görebiliriz.
Select * from Kisi


set statistics IO on
set statistics Time On
Select * from Kisi Where Id = 999

-- Eðer tablo oluþtururken Id alanýný primary key ve Identity olarak belirtirsek Clustred Index SQL Server tarafýndan bizim için otomatik oluþturulur.
-- Clustered index oluþturma (Genelde Id alanlarý için oluþturulur.)
create clustered index KisiIndexle
on Kisi(Id)


-- Var olan clustred index i deðiþtirme
create clustered index KisiIndexle
On Kisi(Id)
with drop_existing, -- Var olan indexi siler yerine tekrar oluþturur.
FillFactor = 60, -- Doluluk oraný
Pad_Index -- Intermatid lavel olarak düzenlenir.


set statistics IO on
set statistics Time on
Select * from Kisi Where TelNo = '84934'

-- Non-Clustered index oluþturma
create nonclustered index TeleGoreIndexle on Kisi(TelNo)

set statistics IO on
set statistics Time on
Select Ad,Soyad,TelNo from Kisi Where TelNo = '84934'

-- Var olan Non-Clustered index i deðiþtirme
create nonclustered index TeleGoreIndexle on Kisi(TelNo)
with drop_existing,
fillfactor = 60,
pad_index

set statistics IO on
set statistics Time on
Select Ad,Soyad,TelNo from Kisi Where TelNo = '84934'

-- Database hakkýnda performans bilgilerini getirir.
dbcc showcontig

-- Kisi tablosu hakkýnda performans bilgilerini getirir.
dbcc showcontig (Kisi)

-- Kisi tablosu hakkýnda kýsa bilgi almak isterseniz.
dbcc showcontig (Kisi,1) with fast

-- Kisi tablosunun TeleGoreIndexle indexi hakkýnda bilgi alalým.
dbcc showcontig (Kisi,TeleGoreIndexle)

-- Mevcut veri tabanýnýn tüm table ve indexleri hakkýnda bilgi alalým.
dbcc showcontig with tableresults,all_indexes