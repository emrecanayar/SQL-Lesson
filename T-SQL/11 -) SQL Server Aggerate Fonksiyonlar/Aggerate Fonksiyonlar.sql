-- Aggregate Fonksiyonlar (Toplam Fonksiyonlarý, Gruplamalý Fonksiyonlar)

-- COUNT (Sütun adý | *) : Bir tablodaki kayýt sayýsýný görmek yada öðrenmek için kullanýlýr.

Select COUNT(*) from Employees -- Bir tablodaki toplam kayýt sayýsýný bu þekilde öðrenebiliriz.

Select COUNT(EmployeeID) from Employees -- EmployeeID sütunundaki kayýt sayýsý

Select Count(Region) from Employees

-- Region sütunundaki kayýt sayýsý (Region sütunu null geçilebildiði için bir tablodaki kayýt sayýsýný bu sütundan yola çýkarak öðrenmek yanlýþ sonuçlar oluþturabilir. Çünkü aggregate fonksiyonlaru NULL deðer içeren kayýtlarý dikkate almaz. Bu nedenle kayýt sayýsýný öðrenebilmek için ya * karakterini ya da NULL deðer geçilemeyen sütunlardan birinin adýný kullanmamýz gerekir.)

Select COUNT(City) from Employees -- 9 yazar ancak bazý þehirler birden fazla tekrar etmiþtir.

Select COUNT(Distinct City) as 'Farklý Þehir' from Employees -- Farklý olan þehirlerin sayýsýný verir.

-- SUM (Sütun Adý) : Bir sütundaki deðerlerin toplamýný veriyor.
Select SUM(EmployeeID) as 'Id''lerin toplamý' from Employees

-- Çalýþanlarýn yaþlarýnýn toplamýný bulunuz.

-- I.Yol

Select SUM(YEAR(GETDATE()) - YEAR(BirthDate)) as 'Yaþlarýn Toplamý'  from Employees

-- II.Yol

Select SUM(DATEDIFF(YEAR,BirthDate,GETDATE())) as [Yaþlarýn Toplamý] from Employees

Select SUM(FirstName) from Employees -- NOT : SUM fonksiyonunu sayýsal sütunlarda kullanabiliriz. Aksi diðer sütunlarda kullanýlamaz. HATA VERÝR!


-- AVG (Sütun Adý)  : Bir sütundaki deðerlerin ortalamasýný verir.

Select AVG(EmployeeID) as 'Ortalama' from Employees

-- Çalýþanlarýn yaþlarýnýn ortalamasýný 2. yoldan yapalým

Select AVG(DATEDIFF(YEAR,BirthDate,GETDATE())) as [Yaþlarýn Ortalamasý] from Employees

Select AVG(FirstName) from Employees -- NOT : AVG fonksiyonunu sayýsal sütunlarda kullanabiliriz. Aksi diðer sütunlarda kullanýlamaz. HATA VERÝR!


-- MAX (Sütun Adý) : Bir sütundaki en büyük deðeri verir.

Select MAX(EmployeeID) from Employees

Select MAX(FirstName) from Employees -- Sütunun sayýsal sütun olmasýna gerek yok, alfabetik olaran en büyük deðeri de verir.


-- MIN (Sütun Adý) : Bir sütundaki en küçük deðeri verir.

Select MIN(EmployeeID) from Employees

Select MIN(FirstName) from Employees -- Sütunun sayýsal sütun olmasýna gerek yok, alfabetik olarak en küçük deðeri de verir.