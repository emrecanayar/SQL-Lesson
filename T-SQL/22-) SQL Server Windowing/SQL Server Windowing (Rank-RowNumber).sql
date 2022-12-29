-- SQL Server Windowing -- 

-- Row_Number () sat�rlar i�in sanal Id olu�turur. (Fiziksel olarak veri taban�nda yer almaz.)
Select ROW_NUMBER() Over(Order By c.ContactTitle) as 'Index', c.ContactTitle,c.CompanyName from Customers c

-- Ayn� de�erelere sahip datalar i�in s�rayla Id verme i�lemi.
Select ROW_NUMBER() Over(Partition By ContactTitle Order by ContactTitle) as 'Index', ContactTitle from Customers

-- Rank() : SQL Server'da Rank fonksiyonu ayn� de�ere sahip olan sat�rlara ayn� s�ra numaras�n� verir. Fakat sonraki farkl� sat�rlar i�in s�ra numaras� verirken tekrar eden sat�r kadar numara atlanarak numara verilir.

Select Rank() Over(Order by ContactTitle) as S�ra, ContactTitle from Customers

-- Dense_Rank() : Dense_Rank fonksiyonu ise bu numara atlamak i�lemini yapmadan numaraland�rma i�lemine kald��� yerden devam edecektir.
Select DENSE_RANK() Over(order by ContactTitle) S�ra, ContactTitle from Customers


-- Distinct ile kullan�m� -- 

Select distinct Rank() Over(Order by ContactTitle) S�ra,  ContactTitle from Customers

Select distinct dense_Rank() Over(Order by ContactTitle) S�ra,  ContactTitle from Customers

-- RowNumber ile Derived  bir tablo olu�turarak sayfalama yapma

Select * from (
Select ROW_NUMBER() Over(order by CustomerID) as Sat�rNo, CompanyName,ContactTitle,City from Customers
) as tbl
Where tbl.Sat�rNo between 30 and 40