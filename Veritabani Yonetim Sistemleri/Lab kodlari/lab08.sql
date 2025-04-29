SELECT *
FROM users
JOIN orders ON users.id = orders.user_id;
-- users tablosunun yanına ordersi ekle ve eklerken users.id'si orders'in user_id'siyle eşleyerek yap, boylece siparisi olmayan eklenmez

SELECT *
FROM users
LEFT JOIN orders ON users.id = orders.user_id;
-- usttekiyle aynı sırada tablo olustu fakat burada siparis vermeyen de var en alt satırda, cunku usersin hepsini alıyor ondan sonra ordersla esleme yapıyor, bu yuzdende siparis vermeyen musteri null donduruyor

SELECT *
FROM users
RIGHT JOIN orders ON users.id = orders.user_id;
-- yine aynı tablo sadece burda da siparis vermeyen kisi yok. Sebebi left yapinca kisilere urun ekliyo yani bosta olsa o kisi olmalı, rightte ise urune kisiyi esliyo, urun zaten kisiyle var oluyor


-- Not: WHERE kelimesinin ardından yazılabilen tüm mantıksal ifadeler ON kelimesinin ardından da yazılabilir.
-- ON : tabloların nasıl birleştirileceğini belirten mantıksal ifadeler için,
-- WHERE : sorgu sonuç listesine hangi satırların dahil edileceğini belirten mantıksal ifadeler için kullanılır.
-- JOIN kullanıldığında, WHERE kelimesi kullanılacaksa ON kelimelerinden sonra kullanılmalıdır.


SELECT users.username, orders.product_name
FROM users
RIGHT JOIN orders ON users.id = orders.user_id;
-- burada sutun seciyorsun ve sadece alan kisi adiyla urun adı goruyosun


SELECT U.username, U.email, O.product_name
FROM users U
RIGHT JOIN orders O ON U.id = O.user_id;
-- tablo adları kısaltılabilir



-- Soru 1 : Tüm öğrencileri (ders almayanlar da dahil), aldıkları dersler ile eşleşmiş şekilde, sütun tekrarları olmadan listeleyiniz.
SELECT students.student_id, students.student_name,courses.course_id,courses.course_name
FROM students
LEFT JOIN student_courses ON students.student_id = student_courses.student_id
LEFT JOIN courses ON student_courses.course_id = courses.course_id;



-- Soru 2 : Tüm dersleri (alınmamış olanlar da dahil), tüm öğrenciler (ders almayanlar da dahil) ile eşleşmiş şekilde, sütun tekrarları olmadan listeleyiniz.
SELECT students.student_id, students.student_name, courses.course_id, courses.course_name
FROM students
LEFT JOIN student_courses ON students.student_id = student_courses.student_id
LEFT JOIN courses ON student_courses.course_id = courses.course_id

UNION

SELECT NULL, NULL, courses.course_id, courses.course_name
FROM courses
LEFT JOIN student_courses ON courses.course_id = student_courses.course_id
WHERE student_courses.student_id IS NULL;
