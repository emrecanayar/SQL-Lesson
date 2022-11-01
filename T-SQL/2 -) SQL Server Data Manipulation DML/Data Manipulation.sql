-- Not: Sorgularýmýzý yazarken küçük-büyük harfe dikkat etmemize gerek yok.


-- DML => Data Manipulation Language

Use Northwind -- Northwind veri tabaný üzerinde sorgulamalar yapacaðýmýz için ya bu þekilde ya da sol üst köþedeki ComboBox'ý kullanarak çalýþmak istediðimiz veri tabanýný seçebiliriz.

-- Tekli yorum satýrý

/*
Çoklu
Yorum
Satýrý
*/

-- NOT: Yorum satýrýnda yer alan bölümler çalýþmaz.

-- Ctrl + K + C => seçili alaný yorum satýrýna alýr. (Windows)
-- Command + K + C => seçili alaný yorum satýrýna alýr. (Mac)

-- Ctrl + K + U => seçili alaný yorum satýrýndan geri alýr. (Windows)
-- Command + K + U => seçili alaný yorum satýrýndan geri alýr. (Mac)

-- Ctrl + R ile iþlem sonucunda çýkan result ekranýný açýp kapatabilirsiniz.

-- Yazdýðýmýz sorguyu çalýþtýrmak için , (execute) F5, Alt + X veya ribon menüde yer alan "Execute" butonuna týklayabilirsiniz.

-- DML => Data Manipulation Language
-- Amaç : Tablolarý sorgulamak

-- Syntax => Select <sütun_adlarý> from <tablo_adý> (sütun adlarý arasýna virgül konur.)

-- Employess tablosundaki tüm kayýtlarý listeyelim..
Select * from Employees

-- Employess tablosundan, çalýþanlara ait ad,soyad,görev ve doðum tarihi bilgilerini listeleyelim.
Select FirstName,LastName,Title,BirthDate from Employees -- Seçmek istediðimiz sütunlarý aralarýna virgül koyarak belirtiyoruz.

-- Sütun isimlerinin Intellisense menüsü ile gelmesi için Select ifadesinden sonra From <tablo_Adý> yazýp, daha sonra Select ile From arasýna sütun isimlerini yazarsak, sütun isimleri bize açýlýr pencerede listelenir.
Select FirstName,LastName,Title,BirthDate from Employees


-- Employess tablosunun sütunlarýný sürükle býrak yardýmý ile de ekleyebiliriz.
-- Employess tablosunun altýndaki Columns klasörünü sürükleyip býrakýrsak bütün sütunlar listelenir.
Select [EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]  from Employees


-- SÜTUNLARIN ÝSÝMLENDÝRÝLMESÝ
-- 1.Yol

Select FirstName as Ad, LastName as Soyad, Title as Görev from Employees -- Sorgu sonucu oluþacak olan sonuç kümesindeki (result-set) sütun isimleri deðiþtirilecektir, tablodaki orjinal sütun isimlerinin deðiþtirilmesi gibi bir durum söz konusu deðildir.

-- 2.Yol
-- Birden fazla kelimeden oluþan bir sütun ismi oluþturduðumuzda bunu köþeli parantezler içerisinde yada tek týrnak içerisinde belirtmemiz gerekir. SQL Server'da Metinsel ifadeler tek týrnak içerisinde belirtilir.

Select Ad = FirstName, Soyad= LastName, Görev=Title, [Doðum Tarihi] = BirthDate from Employees

Select Ad = FirstName, Soyad= LastName, Görev=Title, 'Doðum Tarihi' = BirthDate from Employees

-- 3.Yol

Select Ad=FirstName, LastName Soyad,Title as Görev, HireDate as [Ýþe Baþlama Tarihi] from Employees -- Sütunlar ile belirttiðimiz isimler arasýnda 'as' kullanmamýza gerek yok. (LastName Soyad)


-- TEKÝL KAYITLARI LÝSTELEMEK

Select City from Employees -- Ayný deðere sahip olan þehirler listelenir.

Select DISTINCT City from Employees -- Farklý olan þehirler (tekil deðerlerin) listelenmesi saðlanýr.

Select FirstName,City from Employees

Select Distinct FirstName,City from Employees

-- Üsteki ile ayný sonucu getirir, sebebi ise ayný ad ve þehir deðerine sahip kayýtlarýn olmamasýdýr. Eðer FirstName = Steven City = London olan baþka bir kayýt daha girilirse tabloya, bu kayýtlardan sadece biri listelenecektir.


-- METÝNLERÝ BÝRLEÞTÝRMEK

Select TitleOfCourtesy,FirstName,LastName from Employees

Select (TitleOfCourtesy + ' ' +FirstName+ ' ' +LastName) as Ýsim from Employees

-- + operatörü ile metinlerimizi birleþtirebiliriz. ' ' ile araya boþluk ekliyoruz. Eðer as Ýsim demeseydik, tablomuzda sorguda yazdýðýmýz gibi bir sütun olmadýðý için sütun baþlýðý olarak No Column Name ifadesi yazacaktý.

-- CONCAT => SQL Server üzerinde metinsel ifadeleri birleþtirmek için kullanýlýr.

Select Ýsim =  CONCAT(TitleOfCourtesy,' ',FirstName,' ',LastName) from Employees