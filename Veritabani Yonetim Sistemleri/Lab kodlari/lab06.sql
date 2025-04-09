--ALIŞTIRMA 2
SELECT *
FROM employees
WHERE hire_date > '1999-01-31'
ORDER BY hire_date
LIMIT 150;
--Gösterilen satır 0 - 149 (toplam 150, Sorgu 0,1777 saniye sürdü.) [hire_date: 1999-02-01... - 1999-02-23...]


SELECT *
FROM employees
WHERE hire_date > '1999-01-31'
ORDER BY hire_date
LIMIT 150 OFFSET 150;
--Gösterilen satır 150 - 299 (toplam 150, Sorgu 0,1832 saniye sürdü.) [hire_date: 1999-02-23... - 1999-03-19...]



--ALIŞTIRMA 3 
SELECT COUNT(*)
FROM players
WHERE name LIKE '%bt%';
-- Telefon kronometresiyle : 01.59

SELECT COUNT(*)
FROM players
WHERE name LIKE 'bt%';
-- Telefon kronometresiyle : 01.19 


--Index oluşturma
CREATE INDEX idx_name ON players (name);


SELECT COUNT(*)
FROM players
WHERE name LIKE '%bt%';
--- Telefon kronometresiyle : 01.57

SELECT COUNT(*)
FROM players
WHERE name LIKE 'bt%';
--- Telefon kronometresiyle : 00.73



--YORUMLAR
--İndex oluşturduktan sonra iki sorgu için de sürelerde belirgin bir değişiklik gözlemlediniz mi? Gözlemlerinizin sebebi ne olabilir?
name like 'bt%' sorgusunda belirgin bir hızlanma oldu, çünkü bu sorguda index kullanılabiliyor, fakat name like '%bt%' sorgusunda pek bi fark oluşmadı. Bunun sebebi indexin baştan eşleme gerektirmesi olabilir, ortadan arama yapılamaz.


--İndex varken, b şıkkındaki sorgunun çalışma süresi ile a şıkkındaki sorgunun çalışma süresi arasında dikkat çeken bir fark var mıdır? Yorumunuzu olası sebepleri belirterek ifade ediniz.
Evet, b şıkkındaki sorguda index sayesinde daha hızlı sonuç alındı, a şıkkında ise index işe yaramadı çünkü % karakteri kelimenin başında olduğu için index devre dışı kaldı.