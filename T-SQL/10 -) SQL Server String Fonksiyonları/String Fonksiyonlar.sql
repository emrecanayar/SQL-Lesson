
SELECT 5+9 as Toplam , 5-9 as Fark , 5*9 �arp�m, 5/3 B�l�m , 5 % 2 as [Mod]
-- NOT : Select ile mutlaka bir tablo ad� kullanmak zorunda de�iliz!...

Select 'SQL SERVER DERSLER�' as Mesaj
Print 'SQL SERVER DERSLER�'

-- STRING FONKS�YONLARI --

Select ASCII('A') as 'ASCII KODU' -- Ascii kodunu verir.
Select CHAR(65) as Karakter -- Ascii kodu verilen karakteri s�yler.


--emrecan.ayar@hotmail.com
Select CHARINDEX('@','emrecan.ayar@hotmail.com') as Konum -- Aratmak istedi�imiz karakteri veya mentnin bulundu�u yeri verir. E�er bulamazsa geriye 0 d�nd�r�r.

Select LEFT('Emre Can',4) as [Soldan Karakter Say�s�] -- Parametre olarak belirtilen karakter say�s� kadar soldan ba�layarak metinden par�a al�r ve geriye d�ner.

Select RIGHT('Emre Can',6) as [Sa�dan Karakter Say�s�] -- Parametre olarak belirtilen karakter say�s� kadar sa�dan ba�layarak metinden par�a al�r ve geriye d�ner.

Select LEN('Emre Can Ayar') as [Karakter Say�s�] -- LEN i�erisine verilen parametrenin toplam karakter say�s�n� geri d�ner.

Select LOWER('eMre cAN aYAR') as 'Hepsi K���k' -- LOWER i�erisine verilen parametreyi ne olursa olsun k���k harfe �evirir.

Select UPPER('eMre caN AYar') as 'Hepsi B�y�k' -- UPPER i�erisine verilen parametreyi ne olursa olsun b�y�k harfe �evirir.

Select LTRIM('                Emre Can Ayar') as 'Soldaki Bo�luklar� Siler'
Select RTRIM('Emre Can Ayar            ') as 'Sa�daki Bo�luklaru Siler'
Select TRIM (       'Emre Can Ayar'       ) as 'T�m Bo�luklar� Siler' -- Hem ba�tan hem de sondan

-- E�er kulland���m�z SQL Server versiyonunda TRIM fonksiyonu yoksa bunun yapt��� i�i a�a��daki script ile yapabiliriz.

Select LTRIM(RTRIM('      Emre Can Ayar     ')) as [T�m Bo�luklar� Siler] 

Select REPLACE('Birbirbirbirbirlerine','bir','��') as 'Metinlerin yerine yenilerini atar'

Select SUBSTRING('Emre Can Ayar Center Bili�im Teknolojileri',4,6) as 'SubString''le par�alama i�lemi'
Select SUBSTRING('34199335',1,2) as 'SubString''le par�alama i�lemi'

-- SUBSTRING() fonksiyonu metinsel ifadeyi par�alamak i�in kullan�l�r.
-- �lk parametre par�alanacak metin
-- �kinci parametre par�a al�nacak k�sm�n hangi index ten ba�laya��
-- ���nc� parametre par�a al�nacak k�sm�n ba�lang�� indexinden sonra ka� karakter al�naca��

-- NOT : Yanyana iki tane t�rnak yazd���m�zda, bu ifadeyi metin i�erisindeki t�rnakm�� gibi alg�latabiliriz. (Tek t�rna��n SQL Server da �zel bir anlam� oldu�undan dolay� bu yolu tercih ediyoruz.)

Select REVERSE('Emre Can Ayar') as [Metni Tersine �evirir]

Select  'Emre Can' + SPACE(30) + 'AYAR' as 'Space i�erisinde belirtilen miktar kadar bo�luk koyar'

Select REPLICATE('Emre Can ',5) as 'Belirtilen metni, belirtilen adet kadar �o�alt�r.'