-- Tablo adý ve kolonlara deðiþtirerek bir tabloda tekrar eden kayýtlarý bulmak için oluþturulmuþ scripttir.

SELECT
    name, email, COUNT(*)
FROM
    users
GROUP BY
    name, email
HAVING 
    COUNT(*) > 1
