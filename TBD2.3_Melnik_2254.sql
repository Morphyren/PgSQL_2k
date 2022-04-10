----------запрос 1.  1 способо вывода запроса
SELECT s.n_z, s.name_st, s.surname, Array_agg(h.hobby_name)
FROM student s,
     student_hobby sh,
	 hobby h	 
WHERE s.n_z= sh.n_z AND sh.hobby_id = h.id
GROUP BY s.n_z
ORDER BY s.n_z ASC;

-- 2 способо вывода запроса
SELECT s.n_z, s.name_st, s.surname, Array_agg(h.hobby_name)
FROM student s
JOIN student_hobby sh
ON  s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
GROUP BY s.n_z
ORDER BY s.n_z ASC;


------------запрос 2. 

SELECT s.*,
       CASE WHEN sh.date_finish isnull THEN (now()::date - sh.date_start)
            ELSE sh.date_finish - sh.date_start	
       END time_hobby
FROM student s
JOIN student_hobby sh
ON  s.n_z = sh.n_z
ORDER BY time_hobby DESC
LIMIT 1;

------------запрос 3. 


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
ORDER BY s.n_z ASC

------------запрос 4. 


SELECT s.n_z ,s.name_st, s.surname, h.hobby_name, (sh.date_finish - sh.date_start)/30 as count_month
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE sh.date_finish NOTNULL
ORDER BY s.n_z	ASC


------------запрос 5. 

SELECT s.n_z ,s.name_st, s.surname, Array_agg(h.hobby_name),
EXTRACT(YEAR FROM AGE(now(), s.date_birth)), count(sh.date_start) - count(sh.date_finish) as cnt
from student s
JOIN student_hobby sh
ON s.n_z = sh.n_z 
JOIN hobby h
ON h.id = sh.hobby_id
GROUP BY s.n_z
HAVING count(sh.date_start) - count(sh.date_finish) > 1;

------------запрос 6. 

SELECT s.group_st, avg(s.score)
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON 	h.id = sh.hobby_id
WHERE sh.date_finish isnull
GROUP BY s.group_st
HAVING count(sh.date_start) - count(sh.date_finish) >= 1;

------------запрос 7. 


SELECT s.n_z, h.hobby_name, h.risk, (now()::date - sh.date_start)/30 as count_month
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE sh.date_finish isnull
ORDER BY count_month DESC
LIMIT 1;

------------запрос 8. 

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

------------запрос 9. 
--Добавим троечников второго курса:


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


--Запрос 10 
--выводит только курс, и номер зачетки студента, который имеет более 1 действующего хобби

SELECT substr((group_st::VARCHAR(255)), 1, 1)::integer as course, s.n_z,  Array_agg(sh.date_finish)
FROM student s
JOIN student_hobby sh
ON s.n_z = sh.n_z
JOIN hobby h
ON h.id = sh.hobby_id
WHERE sh.date_finish isnull
GROUP  BY s.n_z
HAVING COUNT(sh.date_finish isnull) > 1