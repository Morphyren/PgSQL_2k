/*===============Групповые функции=====================*/
/*===============Мельник_С._В._2254=====================*/

--Выведите на экран номера групп и количество студентов, обучающихся в них
SELECT group_st, COUNT(n_z)
FROM student
GROUP BY group_st;

/*===============2 пункт=====================*/

SELECT group_st, MAX(score)
FROM student
GROUP BY group_st;

/*===============3 пункт=====================*/

SELECT surname, COUNT(n_z)
FROM student
GROUP BY surname;

/*===============4 пункт=====================*/
--возьмем только часть даты  (по условию - год), сгруппируем по дате и выведем количество студентов

SELECT date_part('year', date_birth) as year, COUNT(n_z)
FROM student
GROUP BY year;


/*===============5 пункт=====================*/

-- переведем group_st в текс и обрежем до первого символа, который означает курс
SELECT substr(group_st::varchar(255), 1, 1) as course, AVG(score)
FROM student
GROUP BY course;

/*===============6 пункт=====================*/

SELECT substr(group_st::VARCHAR(8),1,1) as course, MAX(score) AS max_score, group_st
FROM student 
WHERE CAST (group_st as VARCHAR(8)) 
	LIKE '3%'--выбранный курс
GROUP BY course, group_st
ORDER BY max_score DESC
LIMIT 1;

/*===============7 пункт=====================*/

SELECT group_st, AVG(score) AS avg_score
FROM student 
GROUP BY group_st
HAVING AVG(score) <= 3.5
ORDER BY avg_score ASC;

/*===============8 пункт=====================*/

SELECT group_st, count(n_z), MAX(score) AS max_score, AVG(score) AS avg_score, MIN(score) AS min_score
FROM student 
GROUP BY group_st
ORDER BY group_st ASC;
/*===============9 пункт=====================*/
-- добавим еще одного студента для проверки выполнения условия "вывод студентов"

INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES('Иван', 'Сургов', 2254, 5, 'Людово', '07.03.2002') 

SELECT *
FROM student 
WHERE (group_st, score) IN (
	SELECT group_st, MAX(score)
	FROM student
	WHERE group_st = 2254 --доступные группы 1254, 2254, 3220, 3240, 4120
	GROUP BY group_st
	);

/*===============10 пункт=====================*/

SELECT * 
FROM student 
WHERE (group_st, score) IN(
	SELECT group_st, MAX(score)
	FROM student
	GROUP BY group_st
);
