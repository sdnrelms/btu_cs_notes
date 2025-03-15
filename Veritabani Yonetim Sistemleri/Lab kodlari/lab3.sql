--lab3

CREATE TABLE ogrenciler (
    ogrenci_id INT,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    bolum VARCHAR(50),
    not_ortalamasi FLOAT
);

INSERT INTO ogrenciler (ogrenci_id, ad, soyad, bolum, not_ortalamasi) VALUES (1, 'Ahmet', 'Yilmaz', 'Bilgisayar Muhendisligi', 85.5);

-- İkinci satır
INSERT INTO ogrenciler (ogrenci_id, ad, soyad, bolum, not_ortalamasi)
VALUES (2, 'Mehmet', 'Kaya', 'Elektrik Elektronik Muhendisligi', 78.2);

-- Üçüncü satır
INSERT INTO ogrenciler (ogrenci_id, ad, soyad, bolum, not_ortalamasi)
VALUES (3, 'Ayse', 'Demir', 'Makine Muhendisligi', 92.0);


CREATE TABLE ogrenciler2 (
    ogrenci_id INT PRIMARY KEY,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    bolum VARCHAR(50),
    not_ortalamasi FLOAT
);

INSERT INTO ogrenciler2 (ogrenci_id, ad, soyad, bolum, not_ortalamasi)
VALUES (1, 'Ahmet', 'Yilmaz', 'Bilgisayar Muhendisligi', 85.5),
       (2, 'Mehmet', 'Kaya', 'Elektrik Elektronik Muhendisligi', 78.2),
       (3, 'Ayse', 'Demir', 'Makine Muhendisligi', 92.0);
	   
	   
--ALIŞTIRMA 1
INSERT INTO ogrenciler2 (ogrenci_id, ad, soyad, bolum, not_ortalamasi)
VALUES (3, 'Sudenur', 'Elmas', 'Pc Muhendisligi', 92.0);
--	#1062 - Duplicate entry '3' for key 'PRIMARY' bu hatayı aldık


CREATE TABLE ogrenciler3 (
    ogrenci_id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    bolum VARCHAR(50),
    not_ortalamasi FLOAT
);

INSERT INTO ogrenciler3 (ad, soyad, bolum, not_ortalamasi)
VALUES ('Ahmet', 'Yilmaz', 'Bilgisayar Muhendisligi', 85.5),
       ('Mehmet', 'Kaya', 'Elektrik Elektronik Muhendisligi', 78.2),
       ('Ayse', 'Demir', 'Makine Muhendisligi', 92.0);
	   
	   
CREATE TABLE ogrenciler4 (
    ogrenci_id INT AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    bolum VARCHAR(50),
    not_ortalamasi FLOAT
) AUTO_INCREMENT = 100;

INSERT INTO ogrenciler4 (ad, soyad, bolum, not_ortalamasi) 
VALUES ('Sudenur', 'Elmas', 'Bilgisayar Muhendisligi', 85.5), 
	   ('Gul', 'Demirel', 'Elektrik Elektronik Muhendisligi', 78.2), 
	   ('Sevde', 'Karakaş', 'Makine Muhendisligi', 92.0);
--bunu yapınca id'ler 100 den başladı



--ALIŞTIRMA 2
--id'lerin 1000'den başladığı kod
CREATE TABLE ogrenciler5 (
    ogrenci_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    bolum VARCHAR(50),
    not_ortalamasi FLOAT
) AUTO_INCREMENT = 1000;



--PRIMARY KEY olmadan AUTO_INCREMENT denemesi
CREATE TABLE ogrenciler6 (
    ogrenci_id INT AUTO_INCREMENT,
    ad VARCHAR(50),
    soyad VARCHAR(50),
    bolum VARCHAR(50),
    not_ortalamasi FLOAT
) AUTO_INCREMENT = 10;
--	#1075 - Incorrect table definition; there can be only one auto column and it must be defined as a key
--auto increment özelliği primary key ile birlikte kullanılmalıymış


--Numerik olmayan veriyi AUTO_INCREMENT PRIMARY KEY yapma denemesi
CREATE TABLE ogrenciler7 (
    ogrenci_id INT,
    ad VARCHAR(50) AUTO_INCREMENT PRIMARY KEY,
    soyad VARCHAR(50),
    bolum VARCHAR(50),
    not_ortalamasi FLOAT
) AUTO_INCREMENT = 100;
--	#1063 - Incorrect column specifier for column 'ad'
--auto increment sadece numerik verilerle kullanılmalıymış