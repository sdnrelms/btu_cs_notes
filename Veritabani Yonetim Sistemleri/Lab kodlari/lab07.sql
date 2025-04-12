-- Tabloları oluşturma
CREATE TABLE Calisanlar (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name varchar(255),
    City varchar(255),
    Salary int
);

CREATE TABLE Musteriler (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name varchar(255),
    City varchar(255),
    Budget int
);

-- Tabloları doldurma
INSERT INTO calisanlar (Name, City, Salary)
VALUES ('John', 'New York', 50000),
	   ('Sarah', 'Los Angeles', 55000),
       ('Michael', 'Chicago', 60000),
       ('Emily', 'Houston', 48000),
       ('David', 'Atlanta', 62000);

INSERT INTO musteriler (Name, City, Budget)
VALUES ('Alice', 'Houston', 10000),
	   ('Bob', 'Dallas', 15000),
       ('Charlie', 'Boston', 12000),
       ('Diana', 'Seattle', 9000),
       ('Emily', 'San Francisco', 11000);

-- tekrarsız şehirler
SELECT City FROM calisanlar
UNION
SELECT City FROM musteriler;

--tekrarlı isimler
SELECT Name FROM calisanlar
UNION ALL
SELECT Name FROM musteriler;

-- max bütçe
SELECT MAX(Budget) AS TheBiggest FROM musteriler;
-- min maaş
SELECT MIN(Salary) AS TheSmallest FROM calisanlar;
-- ortalama maaş
SELECT AVG(Salary) FROM calisanlar;