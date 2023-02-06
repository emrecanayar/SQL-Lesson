--- PIVOT => Sat�r bazl� gelen sonucu s�tun bazl� g�stermeye yarar.

-- Nakliye �irketlerinin ta��d��� sipari� say�s�
Select ShipVia, COUNT(*) as 'Total Order' from Orders
GROUP BY ShipVia

-- Yukar�daki sorgunun pivot olarak kullan�m�
Select * from (Select ShipVia, COUNT(*) as TotalOrder from Orders
GROUP BY ShipVia) as tbl
pivot
(
SUM(TotalOrder)
FOR ShipVia in ([1],[2],[3])
) as ptbl

-- System Procedure
-- sp_executesql => String (metinsel) sql sorgular�n� �al��t�r.

declare @query nvarchar(50) = 'select * from Categories'
exec sp_executesql @query


declare @kolonAdi nvarchar(Max)
declare @sorgu nvarchar(Max)

-- IIF fonksiyonu mant�ksal ifadesinin sonucuna g�re iki durumdan birinin geri d�nd�r�lmesini sa�lar. Mant�ksak ko�ul sa�lan�yorsa ilk de�er sa�lanm�yorsa ikinci de�er d�nd�r�l�r.

-- QUOTENAME verilen string ifadeyi k��eli parantez [] i�ine almaya yarar.

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
-- Pivot Kullan�m�
Select * from (Select iif(Title is null,'Department Not Found',Title) as Title, COUNT(*) as EmployeeCount from Employees
Group By Title) as tbl
pivot
(
SUM(EmployeeCount)
for Title in ([Inside Sales Coordinator],[Sales Manager],[Sales Representative],[Vice President, Sales],[Department Not Found])
) as pvTable


--UnPivot kullanm�
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