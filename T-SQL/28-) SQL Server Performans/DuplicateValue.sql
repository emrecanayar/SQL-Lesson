-- Tablo ad� ve kolonlara de�i�tirerek bir tabloda tekrar eden kay�tlar� bulmak i�in olu�turulmu� scripttir.

SELECT
    name, email, COUNT(*)
FROM
    users
GROUP BY
    name, email
HAVING 
    COUNT(*) > 1
