-- HAVING KULLANIMI -- 

-- Sorgu sonucu gelen sonu� k�mesi �zerinde Aggreagete Fonksiyonlara ba�l� olacak �ekilde bir filtreleme i�lemi yapacaksak Where yerine Having anahtar kelimesini kullan�r�z.
-- Bu sayede Aggregate Fonksiyonlar�da filtreleme i�lemlerine katabiliriz.

-- Not : HAVING kullanabilmek i�in GROUP BY ile alakal� bir sorguya sahip olmam�z gerekir.
		-- HAVING Aggreagete Fonksiyonlar i�in kullan�l�r ve GROUP BY dan sonra yaz�l�r.


-- Toplam tutar� 2500 ile 3500 aras�nda olan sipari�lerin s�ralanmas�. (Order Detail tablosu)
-- Tutar Hesab� : UnitPrice * Quantity * (1-Discount)
Select OrderId,SUM(UnitPrice * Quantity * (1-Discount)) as 'Toplam Tutar' from [Order Details]
GROUP BY OrderID
HAVING SUM(UnitPrice * Quantity * (1-Discount)) BETWEEN 2500 and 3500
Order By 'Toplam Tutar' Desc


-- Her bir sipari�teki toplam �r�n say�s� 200'den az olanlar� ekranda listeleylim.
Select [Sipari� Kodu] = OrderID,SUM(Quantity) 'Toplam Adet' from [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) < 200
ORDER BY 2