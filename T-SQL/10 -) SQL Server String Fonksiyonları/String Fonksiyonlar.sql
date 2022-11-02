
SELECT 5+9 as Toplam , 5-9 as Fark , 5*9 Çarpým, 5/3 Bölüm , 5 % 2 as [Mod]
-- NOT : Select ile mutlaka bir tablo adý kullanmak zorunda deðiliz!...

Select 'SQL SERVER DERSLERÝ' as Mesaj
Print 'SQL SERVER DERSLERÝ'

-- STRING FONKSÝYONLARI --

Select ASCII('A') as 'ASCII KODU' -- Ascii kodunu verir.
Select CHAR(65) as Karakter -- Ascii kodu verilen karakteri söyler.


--emrecan.ayar@hotmail.com
Select CHARINDEX('@','emrecan.ayar@hotmail.com') as Konum -- Aratmak istediðimiz karakteri veya mentnin bulunduðu yeri verir. Eðer bulamazsa geriye 0 döndürür.

Select LEFT('Emre Can',4) as [Soldan Karakter Sayýsý] -- Parametre olarak belirtilen karakter sayýsý kadar soldan baþlayarak metinden parça alýr ve geriye döner.

Select RIGHT('Emre Can',6) as [Saðdan Karakter Sayýsý] -- Parametre olarak belirtilen karakter sayýsý kadar saðdan baþlayarak metinden parça alýr ve geriye döner.

Select LEN('Emre Can Ayar') as [Karakter Sayýsý] -- LEN içerisine verilen parametrenin toplam karakter sayýsýný geri döner.

Select LOWER('eMre cAN aYAR') as 'Hepsi Küçük' -- LOWER içerisine verilen parametreyi ne olursa olsun küçük harfe çevirir.

Select UPPER('eMre caN AYar') as 'Hepsi Büyük' -- UPPER içerisine verilen parametreyi ne olursa olsun büyük harfe çevirir.

Select LTRIM('                Emre Can Ayar') as 'Soldaki Boþluklarý Siler'
Select RTRIM('Emre Can Ayar            ') as 'Saðdaki Boþluklaru Siler'
Select TRIM (       'Emre Can Ayar'       ) as 'Tüm Boþluklarý Siler' -- Hem baþtan hem de sondan

-- Eðer kullandýðýmýz SQL Server versiyonunda TRIM fonksiyonu yoksa bunun yaptýðý iþi aþaðýdaki script ile yapabiliriz.

Select LTRIM(RTRIM('      Emre Can Ayar     ')) as [Tüm Boþluklarý Siler] 

Select REPLACE('Birbirbirbirbirlerine','bir','üç') as 'Metinlerin yerine yenilerini atar'

Select SUBSTRING('Emre Can Ayar Center Biliþim Teknolojileri',4,6) as 'SubString''le parçalama iþlemi'
Select SUBSTRING('34199335',1,2) as 'SubString''le parçalama iþlemi'

-- SUBSTRING() fonksiyonu metinsel ifadeyi parçalamak için kullanýlýr.
-- Ýlk parametre parçalanacak metin
-- Ýkinci parametre parça alýnacak kýsmýn hangi index ten baþlayaðý
-- Üçüncü parametre parça alýnacak kýsmýn baþlangýç indexinden sonra kaç karakter alýnacaðý

-- NOT : Yanyana iki tane týrnak yazdýðýmýzda, bu ifadeyi metin içerisindeki týrnakmýþ gibi algýlatabiliriz. (Tek týrnaðýn SQL Server da özel bir anlamý olduðundan dolayý bu yolu tercih ediyoruz.)

Select REVERSE('Emre Can Ayar') as [Metni Tersine Çevirir]

Select  'Emre Can' + SPACE(30) + 'AYAR' as 'Space içerisinde belirtilen miktar kadar boþluk koyar'

Select REPLICATE('Emre Can ',5) as 'Belirtilen metni, belirtilen adet kadar çoðaltýr.'