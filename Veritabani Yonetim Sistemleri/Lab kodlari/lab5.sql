--tablo oluşturma
CREATE TABLE Customers( 
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


--CustomerID'si 1 olan kişinin city'sini Frankfurt yaptık
UPDATE Customers
SET ContactName= 'Alfred Schmidt', City= 'Frankfurt'
WHERE CustomerID = 1;


--Country'si Mexico olan herkesin ContactName'ini Juan yaptık
UPDATE Customers
SET ContactName='Juan'
WHERE Country='Mexico';

--Where belirtilmediği için herkesin ContactName'i Juan oldu
UPDATE Customers
SET ContactName='Juan';

--CustomerName değerine göre delete işlemi
DELETE FROM Customers WHERE CustomerName='Alfreds Futterkiste';
--CustomerID'si 4 olan satır silindi
DELETE FROM Customers WHERE CustomerID=4;

--Tablodaki tüm satırlar silindi (tablo duruyor)
DELETE FROM Customers;

--Tablo dahil her şeyi silmek için DROP kullanılır
DROP TABLE Customers;



--Alıştırma1
UPDATE Customers
SET CustomerName='Around the Horn'
WHERE Country='Mexico';

--Alıştırma2
UPDATE Customers
SET CustomerName='Satyam', Country='USA'
WHERE CustomerID=1;

--Alıştırma3.1
DELETE FROM gfg_employee WHERE name='Rithvik';
--Alıştırma3.2
DELETE FROM gfg_employee WHERE department='Development';
--Alıştırma3.3
DELETE FROM gfg_employee;