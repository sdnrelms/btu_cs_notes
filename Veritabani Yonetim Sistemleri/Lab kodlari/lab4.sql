--TABLE1
CREATE TABLE Customers ( 
  CustomerID INT PRIMARY KEY, 
  CustomerName VARCHAR(255), 
  ContactName VARCHAR(255), 
  Address VARCHAR(255), 
  City VARCHAR(255), 
  PostalCode VARCHAR(10), 
  Country VARCHAR(255)
);
INSERT INTO Customers (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country) VALUES 
(1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209', 'Germany'), 
(2, 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Avda. de la Constitución 2222', 'México D.F.', '5021', 'Mexico'), 
(3, 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mataderos 2312', 'México D.F.', '5023', 'Mexico'), 
(4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP', 'UK'), 
(5, 'Berglunds snabbköp', 'Christina Berglund', 'Berguvsvägen 8', 'Luleå', 'S-958 22', 'Sweden');


--SELECT ifadesi veritabanından veri seçmek için kullanılır.

-- * tablodaki tüm sütunları seçer
SELECT * FROM Customers;

--Customers tablosundan CustomerID ve CustomerName'leri seçen kod
SELECT CustomerID, CustomerName FROM Customers;

--WHERE ifadesi kayıtları filtrelemek için kullanılır.

--Customers tablosundaki CustomerID'si 1 olanları getirir
SELECT * FROM Customers WHERE CustomerID=1;

--NOT: Sayısal değerler tırnağa alınmaz, metinsel değerler alınır.

--CustomerID'si 4'ten küçükler getirilir(4 dahil değildir) 
SELECT * FROM Customers
WHERE CustomerID < 4;

--CustomerID'si 2-4 arası olanlar getirilir(2'de 4'de dahil)
SELECT * FROM `Customers` WHERE CustomerID BETWEEN 2 AND 4;

-- 2-4 arası değerler dışındakiler getirilir
SELECT * FROM `Customers` WHERE CustomerID NOT BETWEEN 2 AND 4;

-- Text'lerde de geçerlidir, alfabe sırasıyla verileri getirir
SELECT * FROM `Customers` WHERE Country BETWEEN 'Mexico' AND 'Sweeden';

-- A ile başlayan CustomerName'leri getirir
SELECT * FROM Customers WHERE CustomerName LIKE 'A%'; 
-- N ile biten CustomerName'leri getirir
SELECT * FROM Customers WHERE CustomerName LIKE '%N'; 
-- Country'si UK ve Germany olan kişileri getirir
SELECT * FROM `Customers` WHERE Country IN ('UK','Germany');
-- Country'si UK ve Germany olmayan kişileri getirir
SELECT * FROM `Customers` WHERE Country NOT IN ('UK','Germany');

--GROUP BY ifadesi, aynı değerlere sahip satırları özet satırlara gruplar.

--her ülkenin müşteri sayısını verir
SELECT COUNT(CustomerID),Country
FROM Customers
GROUP BY Country;


--TABLE2
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    SupplierID INT,
    CategoryID INT,
    Unit VARCHAR(255),
    Price DECIMAL(10, 2)
);
INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, Unit, Price) VALUES
(1, 'Chais', 1, 1, '10 boxes x 20 bags', 18),
(2, 'Chang', 1, 1, '24 - 12 oz bottles', 19),
(3, 'Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10),
(4, 'Chef Anton''s Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22),
(5, 'Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.35);

--Products tablosundaki verileri Price'e göre sıralar
SELECT * FROM Products
ORDER BY Price;

/* Aynı işi yapar:
SELECT * FROM Products
ORDER BY Price ASC;*/

-- ORDER BY otomatik artan sıralar azalan sıralama kodu
SELECT * FROM Products
ORDER BY Price DESC;
--bu da aynı işi yapar
SELECT * FROM Products
ORDER BY -Price;

--String'ler için de geçerlidir
SELECT * FROM Products
ORDER BY ProductName;
--ya da şöyle
SELECT * FROM Products
ORDER BY ProductName DESC;
--bu stringlerde çalışmaz(phpMyAdmin'de)
SELECT * FROM Products
ORDER BY -ProductName;


--Bu kod ise önce Country'e göre sıralar aynı Country'ler için CustomerName'e göre sıralar
SELECT * FROM Customers
ORDER BY Country, CustomerName;

--Country'e göre artan, CustomerName'e göre azalan sıralar
SELECT * FROM Customers
ORDER BY Country ASC, CustomerName DESC;

--ALIŞTIRMA 1
SELECT * FROM `Products` WHERE Price BETWEEN 18 AND 20;
SELECT * FROM `Customers` WHERE CustomerName LIKE 'B%';

