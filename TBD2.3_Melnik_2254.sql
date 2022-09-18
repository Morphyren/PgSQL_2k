--------- Многотабличные запросы------------
/*========== 1 запрос ============*/
--1 способ вывода запроса:

SELECT s.n_z, s.name_st, s.surname, Array_agg(h.hobby_name)
FROM student s,
     student_hobby sh,
	 hobby h	 
WHERE s.n_z= sh.n_z AND sh.hobby_id = h.id
GROUP BY s.n_z
ORDER BY s.n_z ASC;

--2 способ вывода запроса:
SELECT s.n_z, s.name_st, s.surname, Array_agg(h.hobby_name)
FROM student s
JOIN student_hobby sh
ON  s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
GROUP BY s.n_z
ORDER BY s.n_z ASC;


/*========== 2 запрос ============*/

SELECT s.*,
       CASE WHEN sh.date_finish isnull THEN (now()::date - sh.date_start)
            ELSE sh.date_finish - sh.date_start	
       END time_hobby
FROM student s
JOIN student_hobby sh
ON  s.n_z = sh.n_z
ORDER BY time_hobby DESC
LIMIT 1;

/*========== 3 запрос ============*/


SELECT s.n_z, s.name_st, s.surname, s.date_birth
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE (s.score) >
(
	SELECT AVG(score) 
	from student
)
and (sh.date_finish) NOTNULL
GROUP BY s.n_z
HAVING SUM(h.risk) > 0.9
ORDER BY s.n_z ASC;

/*========== 4 запрос ============*/


SELECT s.n_z ,s.name_st, s.surname, h.hobby_name, (sh.date_finish - sh.date_start)/30 as count_month
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE sh.date_finish NOTNULL
ORDER BY s.n_z	ASC;


/*========== 5 запрос ============*/

SELECT s.n_z ,s.name_st, s.surname, Array_agg(h.hobby_name),
EXTRACT(YEAR FROM AGE(now(), s.date_birth)), count(sh.date_start) - count(sh.date_finish) as cnt
from student s
JOIN student_hobby sh
ON s.n_z = sh.n_z 
JOIN hobby h
ON h.id = sh.hobby_id
GROUP BY s.n_z
HAVING count(sh.date_start) - count(sh.date_finish) > 1;

/*========== 6 запрос ============*/

SELECT s.group_st, avg(s.score)
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON 	h.id = sh.hobby_id
WHERE sh.date_finish isnull
GROUP BY s.group_st
HAVING count(sh.date_start) - count(sh.date_finish) >= 1;

/*========== 7 запрос ============*/


SELECT s.n_z, h.hobby_name, h.risk, (now()::date - sh.date_start)/30 as count_month
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE sh.date_finish isnull
ORDER BY count_month DESC
LIMIT 1;

/*========== 8 запрос ============*/ 

SELECT s.n_z, Array_agg(h.hobby_name), s.score
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE (s.score) =
(
	SELECT MAX(score)
	FROM student
)
GROUP BY s.n_z;

/*========== 9 запрос ============*/

SELECT s.n_z, h.hobby_name, score, s.group_st
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z 
JOIN  hobby h
ON h.id = sh.hobby_id
WHERE CAST (s.group_st as VARCHAR(8)) 
	LIKE '2%' 
	and score >= 2.5 
	and score <= 3.5 
	and sh.date_finish ISNULL;

/*========== 10 запрос ============*/
--выводит только курс, и номер зачетки студента, который имеет более 1 действующего хобби

SELECT substr((group_st::VARCHAR(255)), 1, 1)::integer as course, s.n_z,  Array_agg(sh.date_finish)
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE sh.date_finish isnull
GROUP  BY s.n_z
HAVING COUNT(sh.date_finish isnull) > 1;
/*========== 11 запрос ============*/

/* Не реализовано */

/*========== 12 запрос ============*/

SELECT substr((group_st::VARCHAR(255)), 1, 1)::integer as course, COUNT(DISTINCT sh.hobby_id)
FROM student st
JOIN student_hobby sh 
ON sh.n_z = st.n_z
GROUP BY course;


/*========== 13 запрос ============*/

SELECT st.n_z, surname, name_st, date_birth, substr((group_st::VARCHAR(8)), 1, 1)::integer as course
FROM student st
LEFT JOIN student_hobby sh
ON sh.n_z = st.n_z
WHERE sh.hobby_id ISNULL 
AND st.score >= 4.5
GROUP BY st.n_z
ORDER BY course ASC, date_birth DESC;

/*========== 14 запрос ============*/

CREATE OR REPLACE VIEW  student_view AS
SELECT st.n_z, name_st, surname, group_st, score, date_birth, sh.date_start, h.hobby_name, risk, EXTRACT(YEAR FROM age(now()::date, sh.date_start)) as Time_sport
FROM student st
JOIN student_hobby sh
ON st.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE date_finish is not null 
AND EXTRACT(YEAR FROM age(now()::date, sh.date_start)) > 5;

SELECT *
FROM student_view;


/*========== 15 запрос ============*/

SELECT h.hobby_name, COUNT(DISTINCT(sh.n_z)) AS cnt_students
FROM hobby h
JOIN student_hobby sh 
ON sh.hobby_id = h.id
GROUP BY h.hobby_name;


/*========== 16 запрос ============*/


SELECT h.hobby_name
FROM hobby h
JOIN student_hobby sh 
ON sh.hobby_id = h.id
GROUP BY h.hobby_name
ORDER BY COUNT(DISTINCT(sh.n_z)) DESC
LIMIT 1;

/*========== 17 запрос ============*/

/* правка таблицы повторяющеся элементы*/

DELETE 
FROM student_hobby sh 
WHERE sh.id = 24 OR sh.id = 25 OR sh.id = 26 OR sh.id = 23;


SELECT *
FROM student s
JOIN student_hobby sh 
ON sh.n_z = s.n_z
WHERE sh.hobby_id IN
(
	SELECT sh.hobby_id
	FROM hobby h
	JOIN student_hobby sh 
	ON sh.hobby_id = h.id
	GROUP BY sh.hobby_id
	ORDER BY COUNT(DISTINCT(sh.n_z)) DESC
	LIMIT 1
);

/*========== 18 запрос ============*/

SELECT h.id
FROM hobby h
ORDER BY h.risk DESC
LIMIT 3;

/*========== 19 запрос ============*/

SELECT s.*,
    CASE WHEN sh.date_finish isnull THEN (now()::date - sh.date_start)
        ELSE sh.date_finish - sh.date_start	
    END time_hobby
FROM student s
JOIN student_hobby sh
ON  s.n_z = sh.n_z
ORDER BY time_hobby DESC
LIMIT 10;

/*========== 20 запрос ============*/

SELECT DISTINCT(group_st)
FROM (
	SELECT s.*,
       CASE WHEN sh.date_finish ISNULL? THEN (now()::date - sh.date_start)
            ELSE sh.date_finish - sh.date_start	
       END time_hobby
	FROM student s
	JOIN student_hobby sh
	ON  s.n_z = sh.n_z
	ORDER BY time_hobby DESC
	LIMIT 10
) new_table;

/*========== 21 запрос ============*/
/*удалим предыдущее представление:*/

DROP VIEW student_view;

/*создадим новое*/

CREATE OR REPLACE VIEW student_view AS
SELECT st.n_z, surname, name_st
FROM student st
ORDER BY score DESC;

SELECT *
FROM student_view;

/*========== 22 запрос ============*/

/* не реализовано */

/*========== 23 запрос ============*/

CREATE OR REPLACE VIEW student_view_prew AS
SELECT h.hobby_name, COUNT(*) as er, array_agg(st.n_z), h.risk
FROM student st
RIGHT JOIN student_hobby sh 
ON sh.n_z = st.n_z
LEFT JOIN hobby h 
ON h.id = sh.hobby_id
WHERE substr((group_st::VARCHAR(8)), 1, 1)::INTEGER = 2
GROUP BY h.hobby_name, h.risk
ORDER BY COUNT(*) DESC, h.risk DESC;

SELECT hobby_name
FROM student_view_prew
WHERE er = 
(
	SELECT er
	FROM student_view_prew
	ORDER BY ER DESC
	LIMIT 1
)
ORDER BY risk DESC
LIMIT 1;

DROP VIEW student_view_prew;

/*========== 24 запрос ============*/


DROP VIEW student_view;

/* cnter - количество отличников */
CREATE OR REPLACE VIEW student_view AS
SELECT substr((st.group_st::VARCHAR(8)),1,1)::integer AS course, COUNT(*),EE.cnter	
FROM student st
LEFT JOIN (
    SELECT group_st, COUNT(*) cnter
    FROM student s
    WHERE score >= 4.5
    GROUP BY group_st
) AS EE
ON EE.group_st = st.group_st
GROUP BY course, EE.cnter
ORDER BY course ASC;

/*========== 25 запрос ============*/

DROP VIEW student_view;

CREATE OR REPLACE VIEW student_view AS
SELECT hobby_name, COUNT(*) AS cnt_person
FROM student s
JOIN student_hobby sh
ON  s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
GROUP BY hobby_name
ORDER BY cnt_person DESC 
LIMIT 1;

/*========== 26 запрос ============*/


DROP VIEW student_view;

CREATE OR REPLACE VIEW student_view AS
SELECT *
FROM student
WITH CHECK OPTION;

/*========== 27 запрос ============*/
SELECT LEFT(name_st, 1) as abc, MAX(score), MIN(score), AVG(score)
FROM student s
GROUP BY abc
HAVING MAX(score) > 3.6
ORDER BY abc;

/*========== 28 запрос ============*/

SELECT substr((group_st::VARCHAR(8)), 1, 1) AS course, surname, MAX(score), MIN(score)
FROM student s
GROUP BY course, surname
ORDER BY surname;

/*========== 29 запрос ============*/
SELECT EXTRACT(YEAR FROM st.date_birth) AS years, count(sh.hobby_id)
FROM student st
JOIN student_hobby sh
ON sh.n_z = st.n_z
GROUP BY years
ORDER BY years;

/*========== 30 запрос ============*/

SELECT LEFT(name_st, 1) AS abc, MAX(h.risk), MIN(h.risk)
FROM student st
JOIN student_hobby sh
ON sh.n_z = st.n_z
JOIN hobby h
ON h.id = sh.hobby_id
GROUP BY abc
ORDER BY abc;


/*========== 31 запрос ============*/

SELECT EXTRACT(MONTH FROM date_birth) as monthes, AVG(score)
FROM student st
JOIN student_hobby sh
ON sh.n_z = st.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE hobby_name = 'Футбол'
group by monthes;

/*========== 32 запрос ============*/

SELECT st.name_st AS Имя, st.surname AS Фамилия, st.group_st AS Группа
FROM student st
JOIN student_hobby sh ON sh.n_z = st.n_z
JOIN hobby h ON sh.hobby_id = h.id
GROUP BY st.n_z;

/*========== 33 запрос ============*/

SELECT surname, 
CASE
	WHEN strpos(surname, 'ов') != 0 THEN strpos(surname, 'ов')::VARCHAR(8)
	ELSE 'не найдено'
END AS char
FROM student;

/*========== 34 запрос ============*/

SELECT rpad(surname, 10, '#')
FROM student;

/*========== 35 запрос ============*/

CREATE OR REPLACE VIEW st_view AS
SELECT rpad(surname, 10, '#') AS sur
FROM student;

SELECT rtrim(sur, '#')
FROM st_view;

/*========== 36 запрос ============*/

SELECT EXTRACT(DAYS FROM date_trunc('month', '2018-04-01'::DATE) + interval '1 month - 1 day');

/*========== 37 запрос ============*/

SELECT date_trunc('week', CURRENT_DATE)::DATE + 5;

/*========== 38 запрос ============*/

SELECT EXTRACT('CENTURY' FROM CURRENT_DATE),
EXTRACT('WEEK' FROM CURRENT_DATE),
EXTRACT('DOY' FROM CURRENT_DATE);

/*========== 39 запрос ============*/

SELECT name_st, surname, h.hobby_name, 
CASE 
	WHEN sh.date_finish ISNULL THEN 'Занимается'
	ELSE 'Закончил'
END AS status
FROM student s
JOIN student_hobby sh
ON sh.n_z = s.n_z
JOIN hobby h
ON sh.hobby_id = h.id
ORDER BY hobby_name;


/*========== 40 запрос ============*/

/* не смог сделать объединение по группам */

SELECT DISTINCT(st.group_st),
CASE 
	WHEN score >=4.5 AND COUNT(n_z) is NOT NULL THEN COUNT(n_z)
	ELSE '0'
END as five,
CASE 
	WHEN score >=3.5 AND score < 4.5 AND COUNT(n_z) is NOT NULL THEN COUNT(n_z)
	ELSE '0'
END AS four,
CASE 
	WHEN score >=2.5 AND score < 3.5 AND COUNT(n_z) is NOT NULL THEN COUNT(n_z)
	ELSE '0'
END AS three,
CASE 
	WHEN score >=1.5 AND score < 2.5 AND COUNT(n_z) is NOT NULL THEN COUNT(n_z)
	ELSE '0'
END AS two
FROM student st
group by st.group_st, score
order by st.group_st;
