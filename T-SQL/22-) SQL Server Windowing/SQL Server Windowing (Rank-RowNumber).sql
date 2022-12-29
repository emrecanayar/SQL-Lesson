-- SQL Server Windowing -- 

-- Row_Number () satýrlar için sanal Id oluþturur. (Fiziksel olarak veri tabanýnda yer almaz.)
Select ROW_NUMBER() Over(Order By c.ContactTitle) as 'Index', c.ContactTitle,c.CompanyName from Customers c

-- Ayný deðerelere sahip datalar için sýrayla Id verme iþlemi.
Select ROW_NUMBER() Over(Partition By ContactTitle Order by ContactTitle) as 'Index', ContactTitle from Customers

-- Rank() : SQL Server'da Rank fonksiyonu ayný deðere sahip olan satýrlara ayný sýra numarasýný verir. Fakat sonraki farklý satýrlar için sýra numarasý verirken tekrar eden satýr kadar numara atlanarak numara verilir.

Select Rank() Over(Order by ContactTitle) as Sýra, ContactTitle from Customers

-- Dense_Rank() : Dense_Rank fonksiyonu ise bu numara atlamak iþlemini yapmadan numaralandýrma iþlemine kaldýðý yerden devam edecektir.
Select DENSE_RANK() Over(order by ContactTitle) Sýra, ContactTitle from Customers


-- Distinct ile kullanýmý -- 

Select distinct Rank() Over(Order by ContactTitle) Sýra,  ContactTitle from Customers

Select distinct dense_Rank() Over(Order by ContactTitle) Sýra,  ContactTitle from Customers

-- RowNumber ile Derived  bir tablo oluþturarak sayfalama yapma

Select * from (
Select ROW_NUMBER() Over(order by CustomerID) as SatýrNo, CompanyName,ContactTitle,City from Customers
) as tbl
Where tbl.SatýrNo between 30 and 40