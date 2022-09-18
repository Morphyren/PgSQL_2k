/*================Однотабличные запросы===================*/
/*===============Мельник_С._В._2254===================*/
-- Вывести всеми возможными способами имена и фамилии студентов, средний балл которых от 4 до 4.5
SELECT name_st, surname  
FROM STUDENT
WHERE score BETWEEN 4 and 4.5;

SELECT name_st, surname  
FROM STUDENT
WHERE SCORE >= 4 AND SCORE<=4.5;

/*====================================*/
--Познакомиться с функцией CAST. Вывести при помощи неё студентов заданного курса (использовать Like)

SELECT name_st, surname, group_st
FROM STUDENT
WHERE CAST (group_st as VARCHAR(8)) 
	LIKE '1%'; -- вставить цифру курса
/*====================================*/
--Вывести всех студентов, отсортировать по убыванию номера группы и имени от а до я

SELECT name_st, surname, group_st
FROM STUDENT
ORDER BY group_st DESC;


SELECT name_st, surname, group_st
FROM STUDENT
ORDER BY name_st ASC;
/*====================================*/

--Вывести студентов, средний балл которых больше 4 и отсортировать по баллу от большего к меньшему

SELECT name_st, surname, group_st, score
FROM STUDENT
WHERE SCORE > 4
ORDER BY SCORE DESC;

/*====================================*/
--Вывести на экран название и риск футбола и хоккея

/*добавим футбол и хоккей в таблицу, поменяем некоторые значения студентов и отсортируем таблицу student_hobby*/


INSERT INTO HOBBY (hobby_name, risk) 
VALUES ('Футбол', 7.5),
	('Хоккей', 9.3);

UPDATE STUDENT_HOBBY SET HOBBY_ID = 4
WHERE id = 2 OR id = 4 OR id = 9;

UPDATE STUDENT_HOBBY SET HOBBY_ID = 5
WHERE id = 5 OR id = 6 OR id = 11;

SELECT *
FROM STUDENT_HOBBY
ORDER BY id ASC;
/*====================================*/
--выведем на экран название и риск футбола и хоккея 
SELECT hobby_name, risk
FROM hobby
WHERE hobby_name = 'Хоккей' or
hobby_name = 'Футбол';
/*====================================*/
-- пункт 6

SELECT n_z, hobby_id
FROM student_hobby
WHERE date_start BETWEEN '2011.10.08'AND '2017.10.08' AND
date_finish ISNULL;

/*====================================*/
-- пункт 7

SELECT N_Z, NAME_ST, SURNAME, GROUP_ST, SCORE
FROM STUDENT
WHERE SCORE > 4.5
ORDER BY SCORE DESC;

/*====================================*/
--пункт 8
--ВЫВЕДЕМ 2 ЗАПИСИ, ТАК КАК ОТЛИЧНИКОВ ВСЕГО 4

SELECT *
FROM STUDENT
WHERE SCORE > 4.5
GROUP BY N_Z
ORDER BY SCORE DESC
LIMIT 2;

SELECT *
FROM STUDENT
WHERE SCORE > 4.5
ORDER BY SCORE DESC
OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;

/*====================================*/
--Выведите хобби и с использованием условного оператора сделайте риск словами:

SELECT *,
	CASE
 		WHEN risk >= 8 THEN 'очень высокий'
		WHEN risk >= 6 AND risk < 8 THEN 'высокий'
		WHEN risk >= 4 AND risk < 6 THEN 'средний'
		WHEN risk >= 2 AND risk < 4 THEN 'низкий'
		WHEN risk < 2 THEN 'очень низкий'		
	END
	FROM hobby;

/*====================================*/
--Вывести 3 хобби с максимальным риском
SELECT * FROM HOBBY
ORDER BY risk DESC
LIMIT 3;