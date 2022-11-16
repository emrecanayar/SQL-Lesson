-- HAVING KULLANIMI -- 

-- Sorgu sonucu gelen sonuç kümesi üzerinde Aggreagete Fonksiyonlara baðlý olacak þekilde bir filtreleme iþlemi yapacaksak Where yerine Having anahtar kelimesini kullanýrýz.
-- Bu sayede Aggregate Fonksiyonlarýda filtreleme iþlemlerine katabiliriz.

-- Not : HAVING kullanabilmek için GROUP BY ile alakalý bir sorguya sahip olmamýz gerekir.
		-- HAVING Aggreagete Fonksiyonlar için kullanýlýr ve GROUP BY dan sonra yazýlýr.


-- Toplam tutarý 2500 ile 3500 arasýnda olan sipariþlerin sýralanmasý. (Order Detail tablosu)
-- Tutar Hesabý : UnitPrice * Quantity * (1-Discount)
Select OrderId,SUM(UnitPrice * Quantity * (1-Discount)) as 'Toplam Tutar' from [Order Details]
GROUP BY OrderID
HAVING SUM(UnitPrice * Quantity * (1-Discount)) BETWEEN 2500 and 3500
Order By 'Toplam Tutar' Desc


-- Her bir sipariþteki toplam ürün sayýsý 200'den az olanlarý ekranda listeleylim.
Select [Sipariþ Kodu] = OrderID,SUM(Quantity) 'Toplam Adet' from [Order Details]
GROUP BY OrderID
HAVING SUM(Quantity) < 200
ORDER BY 2