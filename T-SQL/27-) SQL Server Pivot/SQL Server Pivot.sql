--- PIVOT => Satýr bazlý gelen sonucu sütun bazlý göstermeye yarar.

-- Nakliye þirketlerinin taþýdýðý sipariþ sayýsý
Select ShipVia, COUNT(*) as 'Total Order' from Orders
GROUP BY ShipVia

-- Yukarýdaki sorgunun pivot olarak kullanýmý
Select * from (Select ShipVia, COUNT(*) as TotalOrder from Orders
GROUP BY ShipVia) as tbl
pivot
(
SUM(TotalOrder)
FOR ShipVia in ([1],[2],[3])
) as ptbl

-- System Procedure
-- sp_executesql => String (metinsel) sql sorgularýný çalýþtýr.

declare @query nvarchar(50) = 'select * from Categories'
exec sp_executesql @query


declare @kolonAdi nvarchar(Max)
declare @sorgu nvarchar(Max)

-- IIF fonksiyonu mantýksal ifadesinin sonucuna göre iki durumdan birinin geri döndürülmesini saðlar. Mantýksak koþul saðlanýyorsa ilk deðer saðlanmýyorsa ikinci deðer döndürülür.

-- QUOTENAME verilen string ifadeyi köþeli parantez [] içine almaya yarar.

select @kolonAdi = iif(@kolonAdi is null,'',@kolonAdi + ',')+ QUOTENAME(ShipperID) from Shippers

set @sorgu = '
Select * from (Select s.ShipperID,Count(*) as SiparisSayisi from Orders o
inner join Shippers s
on o.ShipVia = s.ShipperID
Group By s.ShipperID) as tbl
pivot
(
SUM(SiparisSayisi)
for ShipperID in ('+@kolonAdi+')
)
as ptbl'

exec sp_executesql @sorgu

Select * from Shippers


Select distinct Title from Employees
-- Pivot Kullanýmý
Select * from (Select iif(Title is null,'Department Not Found',Title) as Title, COUNT(*) as EmployeeCount from Employees
Group By Title) as tbl
pivot
(
SUM(EmployeeCount)
for Title in ([Inside Sales Coordinator],[Sales Manager],[Sales Representative],[Vice President, Sales],[Department Not Found])
) as pvTable


--UnPivot kullanmý
Select * from (Select iif(Title is null,'Department Not Found',Title) as Title, COUNT(*) as EmployeeCount from Employees
Group By Title) as tbl
pivot
(
SUM(EmployeeCount)
for Title in ([Inside Sales Coordinator],[Sales Manager],[Sales Representative],[Vice President, Sales],[Department Not Found])
) as pvTable
unpivot
(
EmployeeCount for Title in ([Inside Sales Coordinator],[Sales Manager],[Sales Representative],[Vice President, Sales],[Department Not Found])
) as unPivotTable