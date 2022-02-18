--таблица студентов
CREATE TABLE student (
	n_z SERIAL NOT NULL,
	name_st VARCHAR(255) NOT NULL,
	surname VARCHAR(255) NOT NULL,
	group_st INT NOT NULL,
	score REAL CHECK (score >= 2 AND score <=5),
	locality VARCHAR(255),
	date_birth DATE,
	CONSTRAINT STUDENT_PK PRIMARY KEY (n_z)
);

--таблица хобби
CREATE TABLE hobby (
	id SERIAL NOT NULL,
	hobby_name VARCHAR(255) NOT NULL,
	risk DECIMAL(3,2) NOT NULL,
	CONSTRAINT HOBBY_PK PRIMARY KEY (id)
);

--промежуточная таблица
CREATE TABLE student_hobby (
	id SERIAL NOT NULL,
	n_z INT NOT NULL,
	hobby_id INT NOT NULL,
	date_start DATE NOT NULL,
	date_finish DATE,
	CONSTRAINT student_hobby_pk PRIMARY KEY (id),
	CONSTRAINT student_hobby_fk1 FOREIGN KEY (n_z)
        REFERENCES student (n_z),
	CONSTRAINT student_hobby_fk2 FOREIGN KEY (hobby_id)
        REFERENCES hobby (id)
);
----------------заполнение таблицы student ---------

INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Владимир', 'Иванов', 1254, 4.2, null, '1.3.2003');	

INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Егор', 'Егоров', 3220, 3.9, 'Иваново', '4.2.2000');

INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Андрей', 'Амазин', 1254, 3.2, null, '5.3.2005');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Данил', 'Вологдов', 3240, 4.7, 'Кимры', '5.5.2000');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Данила', 'Дурнов', 1254, 2.2, null, '9.7.2004');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Петр', 'Дорохов', 4120, 4.9, 'Люблино', '2.3.2000');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Иван', 'Иванов', 3240, 5.0, null, '6.6.2001');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Сергей', 'Петров', 2254, 5.0, 'Торопцево', '7.5.2002');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Дмитрий', 'Заблев', 4120, 3.1, null, '7.7.1999');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Алексей', 'Злой', 2254, 3.9, 'Дубна', '10.9.2003');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Антон', 'Дугов', 2254, 4.3, 'Болгово', '1.1.2002');
	
INSERT INTO student (name_st, surname, group_st, score, locality, date_birth)
	VALUES ('Алексей', 'Зайцев', 4120, 2.9, 'Профимово', '2.4.2001');

----------------заполнение таблицы hobby ---------

INSERT INTO hobby (hobby_name, risk)
	VALUES ('Баскетбол', 7.25);

INSERT INTO hobby (hobby_name, risk)
	VALUES ('Волейбол', 3.22);
	
INSERT INTO hobby (hobby_name, risk)
	VALUES ('Шахматы', 0.50);
	
----------------заполнение таблицы student_hobby ---------

INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (1, 1, '10.2.2010', NULL);
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (1, 3, '2.1.2012', '3.3.2013');
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (5, 2, '7.1.2011', NULL);
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (5, 3, '1.7.2012', '3.9.2016');
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (3, 3, '5.2.2015', NULL);
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (7, 1, '3.7.2016', '1.3.2018');
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (7, 3, '11.8.2013', NULL);
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (10, 2, '3.1.2018', '3.11.2021');
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (11, 3, '11.3.2015', '10.4.2016');
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (9, 1, '12.1.2013', NULL);
	
INSERT INTO student_hobby (n_z, hobby_id, date_start, date_finish)
	VALUES (9, 2, '2.3.2016', '7.7.2017');
