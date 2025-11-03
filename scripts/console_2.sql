-- ========================================
-- 1. Создаём таблицу студентов
-- ========================================

DROP TABLE IF EXISTS student_courses; -- сначала many-to-many, чтобы не было зависимостей
DROP TABLE IF EXISTS student_profiles; -- потом one-to-one
DROP TABLE IF EXISTS courses;         -- потом курсы
DROP TABLE IF EXISTS students;        -- наконец студенты

CREATE TABLE students (
    id SERIAL PRIMARY KEY, -- уникальный идентификатор студента
    name VARCHAR(50) NOT NULL,
    age INT
);

-- ========================================
-- 2. Создаём таблицу профилей (One-to-One)
-- каждый студент имеет только один профиль
-- ========================================
CREATE TABLE student_profiles (
    id SERIAL PRIMARY KEY,
    student_id INT UNIQUE, -- связь один-к-одному
    email VARCHAR(100),
    phone VARCHAR(20),
    CONSTRAINT fk_student
        FOREIGN KEY(student_id)
        REFERENCES students(id)
        ON DELETE CASCADE
);

-- ========================================
-- 3. Создаём таблицу курсов (One-to-Many)
-- один курс может быть у нескольких студентов (через таблицу регистрации)
-- ========================================
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL
);

-- ========================================
-- 4. Таблица регистрации студентов на курсы (Many-to-Many)
-- один студент может быть на многих курсах, один курс может иметь много студентов
-- ========================================
CREATE TABLE student_courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id), -- составной ключ
    CONSTRAINT fk_student
        FOREIGN KEY(student_id)
        REFERENCES students(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course
        FOREIGN KEY(course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE
);

-- ========================================
-- 5. Вставляем данные
-- ========================================
INSERT INTO students (name, age) VALUES
('Alice', 21),
('Bob', 22),
('Charlie', 20);

INSERT INTO student_profiles (student_id, email, phone) VALUES
(1, 'alice@example.com', '123-456'),
(2, 'bob@example.com', '234-567'),
(3, 'charlie@example.com', '345-678');

INSERT INTO courses (course_name) VALUES
('Math'),
('Physics'),
('Computer Science');

INSERT INTO student_courses (student_id, course_id) VALUES
(1, 1), -- Alice на Math
(1, 3), -- Alice на Computer Science
(2, 1), -- Bob на Math
(2, 2), -- Bob на Physics
(3, 2), -- Charlie на Physics
(3, 3); -- Charlie на Computer Science

-- ========================================
-- 6. Примеры запросов
-- ========================================

-- Получить всех студентов с их профилями
SELECT s.id, s.name, s.age, p.email, p.phone
FROM students s
LEFT JOIN student_profiles p ON s.id = p.student_id;

-- Получить список студентов и курсов (Many-to-Many)
SELECT s.name AS student, c.course_name AS course
FROM students s
JOIN student_courses sc ON s.id = sc.student_id
JOIN courses c ON sc.course_id = c.id
ORDER BY s.id;

-- Найти всех студентов, которые записаны на курс "Math"
SELECT s.name
FROM students s
JOIN student_courses sc ON s.id = sc.student_id
JOIN courses c ON sc.course_id = c.id
WHERE c.course_name = 'Math';


---------------------------------------------------------


DROP TABLE if exists student CASCADE;
DROP TABLE if exists student_profile CASCADE;
DROP TABLE if exists course CASCADE;
DROP TABLE if exists student_course CASCADE;



CREATE TABLE student
(
    id   serial primary key,
    name varchar(200),
    age  int
);

CREATE TABLE student_profile
(
    id         serial primary key,
    student_id int unique,
    email      varchar(100),
    phone      varchar(100),
    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
            REFERENCES student (id)
            on delete CASCADE
);

CREATE TABLE course
(
    id          serial primary key,
    course_name varchar(200)
);

create table student_course
(
    student_id int,
    course_id  int,
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT fk_student
        foreign key (student_id)
            references student (id)
            on delete cascade,
    CONSTRAINT fk_course
        foreign key (course_id)
            references course (id)
            on delete cascade
);

INSERT INTO student(name, age)
VALUES ('Alice', 21),
       ('Bob', 22),
       ('Charlie', 20),
       ('GAP', 20);

INSERT INTO student_profile(student_id, email, phone)
VALUES (1, 'alice@example.com', '123-456'),
       (2, 'bob@example.com', '234-567'),
       (3, 'charlie@example.com', '345-678');

INSERT INTO courses(course_name)
VALUES ('Math'),
       ('Physics'),
       ('Computer Science');


INSERT INTO student_course(student_id, course_id)
VALUES (1, 1),
       (1, 3),
       (2, 1),
       (2, 2),
       (3, 2),
       (3, 3);

SELECT s.*
FROM student s;

SELECT sp.*
FROM student_profile sp;

SELECT s.*, sp.*
FROM  student_profile sp
LEFT JOIN student s ON s.id = sp.student_id;


SELECT s.id, s.name, sp.email, sp.phone
FROM students s
JOIN student_profile sp on s.id = sp.student_id;


SELECT s.name, c.course_name
FROM students s
JOIN student_course sc ON s.id = sc.student_id
JOIN courses c ON sc.course_id = c.id
ORDER BY  s.name DESC;


SELECT s.name
FROM students s
JOIN student_course sc ON s.id = sc.student_id
JOIN course c ON sc.course_id = c.id
WHERE c.course_name='Math';















