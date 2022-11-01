
-- Var olan bir database silme i�lemi
drop database Deneme

-- Yeni bir database olu�turma
create database Deneme


-- Primary key ile tablo olu�turma i�lemi.
use Deneme
create table Persons
(Id int NOT NULL primary key Identity(1,1),
FirstName nvarchar(15) Not null,
LastName nvarchar(15) not null,
Age tinyint,
City nvarchar(30),
District nvarchar(30),
IsDeleted bit
)


-- Var olan tabloyu g�ncelleyerek yeni bir alan ekleme
Use Deneme
alter table Persons
add Email nvarchar(30)

-- Var olan tabloyu g�ncelleyerek i�erisindeki bir alan� g�ncelleme i�lemi
Use Deneme
alter table Persons
alter column City nvarchar(30) not null

-- Var olan tablo �zerindeki istenmeyen alan� silme i�lemi
Use Deneme
alter table Persons
drop column District


-- E�er bir tabloda yer alan kolunun ismini de�i�tirme i�lemi
Exec sp_rename 'Persons.IsDeleted','Deleted','COLUMN'

--sp_Rename Stored Procedure kullanmak i�in 
-- �lk parametre => De�i�iklik yapmak istedi�imiz tabloAd�.KolonunAd�
-- �kinci parametre => De�i�tirilcek olan yeni isim
-- ���nc� parametre => bir kolon �zerinde isim de�i�ikli�i yapmak istedi�imiz i�in COLUMN olarak veriyoruz.