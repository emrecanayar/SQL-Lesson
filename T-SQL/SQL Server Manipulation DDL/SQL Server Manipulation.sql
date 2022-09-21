
-- Var olan bir database silme iþlemi
drop database Deneme

-- Yeni bir database oluþturma
create database Deneme


-- Primary key ile tablo oluþturma iþlemi.
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


-- Var olan tabloyu güncelleyerek yeni bir alan ekleme
Use Deneme
alter table Persons
add Email nvarchar(30)

-- Var olan tabloyu güncelleyerek içerisindeki bir alaný güncelleme iþlemi
Use Deneme
alter table Persons
alter column City nvarchar(30) not null

-- Var olan tablo üzerindeki istenmeyen alaný silme iþlemi
Use Deneme
alter table Persons
drop column District


-- Eðer bir tabloda yer alan kolunun ismini deðiþtirme iþlemi
Exec sp_rename 'Persons.IsDeleted','Deleted','COLUMN'

--sp_Rename Stored Procedure kullanmak için 
-- Ýlk parametre => Deðiþiklik yapmak istediðimiz tabloAdý.KolonunAdý
-- Ýkinci parametre => Deðiþtirilcek olan yeni isim
-- Üçüncü parametre => bir kolon üzerinde isim deðiþikliði yapmak istediðimiz için COLUMN olarak veriyoruz.