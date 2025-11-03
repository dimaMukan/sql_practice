CREATE DATABASE module;

DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS mark;



CREATE TABLE mark
(
    id integer NOT NULL UNIQUE,
    category varchar(50) NOT NULL,
    mark varchar(50) NOT NULL UNIQUE PRIMARY KEY
);

INSERT INTO mark
VALUES
(1,'middle class car','Volkswagen'),
(2,'luxury','Rolls-Royce'),
(3,'sport car','Porsche'),
(4,'sport car','BMW'),
(5,'middle class car','Toyota');

CREATE TABLE car
(
    id integer NOT NULL PRIMARY KEY,
    mark_fk VARCHAR(256) NOT NULL REFERENCES "mark"(mark),
    cost integer NOT NULL
);

INSERT into car
VALUES
(1,'BMW',200000),
(2,'BMW',50000),
(3,'BMW',70000),
(4,'Rolls-Royce',450000),
(5,'Rolls-Royce',500000),
(6,'Toyota',15000),
(7,'Porsche',50000),
(8,'Porsche',40000),
(9,'Volkswagen',25000),
(10,'Volkswagen',11000),
(11,'Volkswagen',15000);



CREATE TABLE employee
(
id integer NOT NULL PRIMARY KEY,
surname varchar(30) NOT NULL,
name varchar(30) NOT NULL,
patronymic varchar(30),
work_experience integer,
salary integer,
date date
);


INSERT into employee
VALUES
(1,'Dima','Mukan','Sergiyovich',1,13800,'2022-10-11'),
(2,'Vlada','Gusakova',DEFAULT,1,10000,'2022-09-19'),
(3,'Nikol','Geroivna','Dmitrivna',0,DEFAULT,DEFAULT),
(4,'Ira','Koval','Vasilivna',3,15000,'2022-10-03'),
(5,'Oleg','Novich','Vasiliovich',4,11000,'2022-07-21'),
(6,'Andrew','Buga','Dmitreevich',3,12999,'2022-01-22'),
(7,'Tom','Kuleba','Ivanovich',6,40000,'2022-10-01');

SELECT *
FROM employee
WHERE date>'2022-09-13'
ORDER BY work_experience;


SELECT *
FROM car
LEFT JOIN mark on mark.mark = car.mark_fk;

SELECT car.id,cost,category,mark
FROM car
LEFT JOIN mark on mark.mark = car.mark_fk
WHERE mark = 'BMW'