/*  =======================Мельник Степан Валентинович 2254 ПРОЕКТ ТБД=======================*/

/*  ==============================================СОЗДАНИЕ ТАБЛИЦ==============================================*/
--реализация 8 пункта проекта (некоторые помещения имею максимальное время пребывания + фиксация инцидентов превышения времени пребывания)


--Таблица работников
CREATE TABLE employee (
	id_empl SERIAL NOT NULL,
	name_empl VARCHAR(255) NOT NULL,
	surname VARCHAR(255) NOT NULL,
	patronymic VARCHAR(255) NOT NULL,  --отчество
	post VARCHAR(255) NOT NULL,  -- должность
	login VARCHAR(255) NOT NULL UNIQUE, -- логин для входа
	pass VARCHAR(255) NOT NULL UNIQUE,	-- пароль для входа
	CONSTRAINT employee_pk PRIMARY KEY (id_empl)
);

--Таблица комнат
CREATE TABLE room (
	id_room SERIAL NOT NULL,
	name_room VARCHAR(255) NOT NULL,
	max_time INTERVAL HOUR TO SECOND, -- максимальное разрешенное время в этой комнате
	CONSTRAINT room_pk PRIMARY KEY (id_room)
);

--Таблица дотсупа в комнаты
CREATE TABLE room_access (
	id SERIAL NOT NULL,
	id_empl_ac INT NOT NULL,
	id_room_ac INT NOT NULL,
	usage_time VARCHAR(255) NOT NULL,  -- права доступа

	CONSTRAINT room_access_pk PRIMARY KEY (id),
	CONSTRAINT room_access_fk1 FOREIGN KEY (id_empl_ac)
        REFERENCES employee (id_empl),
	CONSTRAINT room_access_fk2 FOREIGN KEY (id_room_ac)
        REFERENCES room (id_room)
);

--Активность пользователя
CREATE TABLE employee_activity (
	id SERIAL NOT NULL,
	id_empl_act INT NOT NULL,
	id_room_act INT NOT NULL,
	entry_time TIMESTAMP NOT NULL,
	exit_time TIMESTAMP,
	violation_limit_time BOOLEAN NOT NULL, -- если превысил время то true, иначе false, возможен null, если еще в помещении

	CONSTRAINT employee_activity_pk PRIMARY KEY (id),
	CONSTRAINT employee_activity_fk1 FOREIGN KEY (id_empl_act)
        REFERENCES employee (id_empl),
	CONSTRAINT employee_activity_fk2 FOREIGN KEY (id_room_act)
        REFERENCES room (id_room)
);


/*  ==============================================НАПОЛНЕНИЕ ТАБЛИЦ==============================================*/
-- реалиазиция 1 и 2 пункта


-- Добавление сотрудников в таблицу employee
BEGIN;
INSERT INTO employee (name_empl, surname, patronymic, post, login, pass)
	VALUES ('Владимир', 'Иванов', 'Витальевич', 'Директор', 'Ivanov1', 'abesodas2');
COMMIT;

BEGIN;
INSERT INTO employee (name_empl, surname, patronymic, post, login, pass)
	VALUES ('Игорь', 'Дубов', 'Анатальевич', 'Администратор', 'Dubov1', 'admindbker3');
COMMIT;

BEGIN;
INSERT INTO employee (name_empl, surname, patronymic, post, login, pass)
	VALUES ('Сергей', 'Егоров', 'Федорович', 'Старший сотрудник', 'Egorov1', 'egorSerg1');
COMMIT;

BEGIN;
INSERT INTO employee (name_empl, surname, patronymic, post, login, pass)
	VALUES ('Станислав', 'Сергеев', 'Сергеевич', 'Сотрудник', 'Sergeev1', 'serrrhight3');
COMMIT;

BEGIN;
INSERT INTO employee (name_empl, surname, patronymic, post, login, pass)
	VALUES ('Алексей', 'Курин', 'Владимирович', 'Младший сотрудник', 'Kyrin1', 'kyrinarrs1');
COMMIT;

BEGIN;
INSERT INTO employee (name_empl, surname, patronymic, post, login, pass)
	VALUES ('Станислав', 'Курин', 'Владимирович', 'Младший сотрудник', 'Kyrin2', 'StassKyrineqw2');
COMMIT;

-- Добавление комнат в таблицу room

BEGIN;
INSERT INTO room (name_room, max_time)
	VALUES ('Помещение 1', '01:30:00');
COMMIT;

BEGIN;
INSERT INTO room (name_room, max_time)
	VALUES ('Помещение 2', null);
COMMIT;

BEGIN;
INSERT INTO room (name_room, max_time)
	VALUES ('Помещение 3', '00:30:00');
COMMIT;


--Записи в таблице прав доступа в помещения room_access

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (1, 1, 'постоянное');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (1, 2, 'постоянное');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (1, 3, 'постоянное');
COMMIT;


BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (3, 1, 'постоянное');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (3, 2, 'постоянное');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (3, 3, 'постоянное');
COMMIT;


BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (4, 1, 'Временное');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (4, 2, 'постоянное');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (4, 3, 'Временное');
COMMIT;


BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (5, 2, 'Временное');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (5, 3, 'Временное');
COMMIT;



BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (6, 1, 'Разовое');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (6, 2, 'Временное');
COMMIT;

BEGIN;
INSERT INTO room_access (id_empl_ac, id_room_ac, usage_time)
	VALUES (6, 3, 'Временное');
COMMIT;



--Записи в таблице активности пользователей  employee_activity

BEGIN;
INSERT INTO employee_activity (id_empl_act, id_room_act, entry_time, exit_time, violation_limit_time)
	VALUES (1, 1, '2022-04-20 08:00:00+00', '2022-04-20 09:00:00+00', 'false');
COMMIT;

BEGIN;
INSERT INTO employee_activity (id_empl_act, id_room_act, entry_time, exit_time, violation_limit_time)
	VALUES (3, 1, '2022-05-01 10:00:00+00', '2022-05-01 12:00:00+00', 'true');
COMMIT;

BEGIN;
INSERT INTO employee_activity (id_empl_act, id_room_act, entry_time, exit_time, violation_limit_time)
	VALUES (6, 3, '2022-05-03 14:00:00+00', '2022-05-03 14:25:00+00', 'false');
COMMIT;

BEGIN;
INSERT INTO employee_activity (id_empl_act, id_room_act, entry_time, exit_time, violation_limit_time)
	VALUES (3, 2, '2022-05-03 16:00:00+00', '2022-05-03 19:00:00+00', 'false');
COMMIT;

BEGIN;
INSERT INTO employee_activity (id_empl_act, id_room_act, entry_time, exit_time, violation_limit_time)
	VALUES (3, 2, '2022-05-20 16:00:00+00', null, null);
COMMIT;

BEGIN;
INSERT INTO employee_activity (id_empl_act, id_room_act, entry_time, exit_time, violation_limit_time)
	VALUES (4, 3, '2022-04-23 10:00:00+00', '2022-04-23 12:00:00+00', 'true');
COMMIT;




/*  ==============================================ЗАПРОСЫ==============================================*/


--6.      Администратор. Просмотр списка всех пользователей с поиском
--по: правам, фамилии/имени/отчеству, по активности. Сортировка по:
--активности последней, пагинация.

-- Просмотр всех пользователей :
SELECT *
FROM employee;

-- Просмотр всех пользователей и их активности в определенных комнатах:
SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act;

-- Просмотр пользователей и их прав в определенные комнаты:
SELECT id_empl, name_empl, surname, patronymic,
r.name_room, r.max_time, r_a.usage_time
FROM employee emp
JOIN room_access r_a
ON  emp.id_empl = r_a.id_empl_ac
JOIN room r
ON r.id_room = r_a.id_room_ac;

-- Поиск пользователей с определенными правами:

-- постоянное:
SELECT id_empl, name_empl, surname, patronymic,
r.name_room, r.max_time, r_a.usage_time
FROM employee emp
JOIN room_access r_a
ON  emp.id_empl = r_a.id_empl_ac
JOIN room r
ON r.id_room = r_a.id_room_ac
WHERE r_a.usage_time = 'постоянное'; 


-- Временное:
SELECT id_empl, name_empl, surname, patronymic,
r.name_room, r.max_time, r_a.usage_time
FROM employee emp
JOIN room_access r_a
ON  emp.id_empl = r_a.id_empl_ac
JOIN room r
ON r.id_room = r_a.id_room_ac
WHERE r_a.usage_time = 'Временное';

-- Разовое:
SELECT id_empl, name_empl, surname, patronymic,
r.name_room, r.max_time, r_a.usage_time
FROM employee emp
JOIN room_access r_a
ON  emp.id_empl = r_a.id_empl_ac
JOIN room r
ON r.id_room = r_a.id_room_ac
WHERE r_a.usage_time = 'Разовое';

-----------------------------------------

-- Поиск пользователей по имени
SELECT *
FROM employee emp
WHERE name_empl = 'Станислав';

-- Поиск пользователей по фамилии
SELECT *
FROM employee emp
WHERE surname = 'Егоров';

-- Поиск пользователей по отчеству
SELECT *
FROM employee emp
WHERE patronymic = 'Владимирович';

-----------------------------------------

-- Поиск по активности, если время выхода null то активен в данный момент

SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act
WHERE exit_time ISNULL;

-----------------------------------------
---Сортировка от последней до первой активности
SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act
ORDER BY emp_act.exit_time DESC;

---Сортировка от первой до последней активности
SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act
ORDER BY emp_act.exit_time ASC;

---Последняя активность
SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act
ORDER BY emp_act.exit_time DESC
LIMIT 1;

--7.      Администратор. Просмотр всех действий конкретного пользователя
--(время входа, время выхода; поиск по помещению, пагинация)
-- В качестве примера - пользователь с id_empl = 3

--вся история активности
SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act
WHERE emp.id_empl = 3;

--Последняя активность
SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act
WHERE emp.id_empl = 3
ORDER BY emp_act.exit_time DESC
LIMIT 1;

-- Поиск по помещению 
SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act
WHERE r.name_room = 'Помещение 1'; -- or 'Помещение 2' or 'Помещение 3'


--9.      Администратор. Забрать права (Предусмотреть случай, когда
--сотрудник вошёл в помещение и у него забрали права на выход).

-- Заберем права на доступ в помещение c id 2 у сотрудника с id = 3 
--условием удаления является то, что последняя активность exit_time не null
-- так как он еще в помещении, удаления не произойдет
BEGIN;
DELETE FROM room_access USING employee_activity emp_act
WHERE id_empl_ac = 3 AND id_room_ac = 2 
AND exit_time in(
	Select exit_time
 	FROM employee_activity
	WHERE id_empl_act = 3 AND id_room_act = 2
	ORDER BY exit_time DESC	
	LIMIT 1				
) IS NOT NULL;
COMMIT;

--проверка
SELECT *
FROM room_access
WHERE id_empl_ac = 3;

--10.   Администратор. Просмотр всех инцидентов (сортировка по дате,
--сотруднику). Возможность решить инцидент 

SELECT id_empl, name_empl, surname, patronymic, r.name_room, r.max_time, 
emp_act.entry_time, emp_act.exit_time, emp_act.violation_limit_time
FROM employee emp
JOIN employee_activity emp_act
ON  emp.id_empl = emp_act.id_empl_act
JOIN room r
ON r.id_room = emp_act.id_room_act
WHERE  emp_act.violation_limit_time = true;

-- Администратор должен сообщить об инциденте руководству, 
-- которое примет решение, и к нарушителю будут применены соответствующие меры,
-- либо лишение прав на доступ в это помещение:

BEGIN;
DELETE FROM room_access USING employee_activity emp_act
WHERE id_empl_ac = 3/*id сотрудника*/ AND id_room_ac = 2/*id помещения*/
AND exit_time in(
	Select exit_time
 	FROM employee_activity
	WHERE id_empl_act = 3/*id сотрудника*/ AND id_room_act = 2/*id помещения*/
	ORDER BY exit_time DESC	
	LIMIT 1				
) IS NOT NULL;
COMMIT;

-- проверка
SELECT *
FROM room_access
WHERE id_empl_ac = 3;

-- либо ограничение прав:

BEGIN;
UPDATE room_access 
SET usage_time = 'Временное' /*Разовое*/
WHERE id_empl_ac = 3/*id сотрудника*/ AND id_room_ac = 2/*id помещения*/;
COMMIT;

-- проверка
SELECT *
FROM room_access
WHERE id_empl_ac = 3;