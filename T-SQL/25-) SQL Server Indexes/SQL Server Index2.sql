-- Araþtýrnýz => SQL Server'da index bakýmlarý nasýl yapýlýr.
-- Reorganize ve Rebuild nedir kod tarafýndan nasýl yapýlýr? Hangisinin yapýlmasý gerektiðine nasýl karar verilir?

Create database IndexDeneme2
go

use IndexDeneme2
GO
create table Customers (
Id int primary key identity,
Name nvarchar(50),
Surname nvarchar(50),
City nvarchar(50),
Town nvarchar(50),
BirthDate date,
Gender varchar(1)
)

declare @Index as Int = 0
While @Index < 250000
Begin
	declare @Name as nvarchar(50)
	declare @Surname as nvarchar(50)
	declare @City as nvarchar(50)
	declare @Town as nvarchar(50)
	declare @Birthdate datetime
	declare @Gender as nvarchar(1)
	declare @Rand as Int

	Set @Rand = RAND()*699 
	Select @Name= NAME ,@Gender = GENDER from NAMES WHERE ID = @Rand
	
	Set @Rand = RAND()*16000
	Select @Surname=SURNAME from SURNAMES WHERE ID = @Rand

	Set @Rand = RAND()*900
	Select @City = CITY, @Town=TOWN from CITY_DISTRICT WHERE ID = @Rand

	SET @Rand = RAND()*365*80
	SET @Birthdate = GETDATE() - @Rand

	INSERT INTO Customers (Name,Surname,BirthDate,City,Town,Gender)
	VALUES (@Name,@Surname,@Birthdate,@City,@Town,@Gender)

	Set @Index = @Index + 1
end

Select * from Customers
Select COUNT(*) from Customers


set statistics IO On
set statistics Time On
Select * from Customers Where [Name] = 'Mehmet'