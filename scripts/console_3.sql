-- CREATE DATABASE lab_4_db;
--
--
--
-- (1,'2021-08-01','Andrew Buga','Porshe','Carl Noy'),
-- (2,'2021-09-02','Andrew Buga','Volkswagen','Nikol Geroivna'),
-- (3,'2021-09-01','Andrew Buga','Mercedes','Ira Koval'),
-- (4,'2021-06-15','Dima Mukan','BMW','Vlada Gusakova'),
-- (5,'2021-08-27','Andrew Buga','Toyota','Oleg Novich'),
-- (6,'2021-07-28','Dima Mukan','Toyota','Andrew Diari'),
-- (7,'2021-08-07','Andrew Buga','BMW','Alex Mikula'),
-- (8,'2021-08-11','Andrew Buga','Rolls-Royce','Vlodimir Zelenskiy'),
-- (9,'2021-08-31','Andrew Buga','Volkswagen','Alena Kuleba'),
-- (10,'2021-08-15','Dima Mukan','BMW','Alex Joy');



DROP TABLE IF EXISTS car_sell;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS customer;

CREATE TABLE car_sell
(
    id integer NOT NULL PRIMARY KEY,
    date date NOT NULL,
    employee_id integer NOT NULL,
    car_id integer NOT NULL,
    customer_id integer NOT NULL
);

CREATE TABLE car
(
    id integer NOT NULL PRIMARY KEY,
    mark varchar(50) NOT NULL,
    category varchar(50) NOT NULL,
    cost integer NOT NULL
);

CREATE TABLE employee
(
    id integer NOT NULL PRIMARY KEY,
    surname varchar(30) NOT NULL,
    name varchar(30) NOT NULL,
    patronymic varchar(30)
);

CREATE TABLE customer
(
    id integer NOT NULL PRIMARY KEY,
    surname varchar(30) NOT NULL,
    name varchar(30) NOT NULL,
    patronymic varchar(30),
    city varchar(30) NOT NULL,
    age integer NOT NULL
);

INSERT INTO car_sell
VALUES
(1,'2021-07-31',1,1,1),
(2,'2021-08-01',2,2,2),
(3,'2021-08-31',2,3,3),
(4,'2021-07-19',1,4,4),
(5,'2021-08-15',1,5,5),
(6,'2021-08-02',1,7,1);


INSERT into car
VALUES
(1,'BMW','sport car',200000),
(2,'Rolls-Royce','lux car',450000),
(3,'Toyota','universal',15000),
(4,'Porsche','jeep',50000),
(5,'Volkswagen','hatchback',25000),
(6,'Volkswagen','universal',11000),
(7,'Volkswagen','hatchback',15000);

INSERT into customer
VALUES
(1,'Dima','Mukan',DEFAULT,'Kyiv',20),
(2,'Vlada','Gusakova','Kirilivna','Kyiv',21),
(3,'Nikol','Geroivna',DEFAULT,'Kyiv',17),
(4,'Ira','Koval','Vasilivna','Ivano Frankivsk',18),
(5,'Oleg','Novich','Vasiliovich','Lviv',19);

INSERT into employee
VALUES
(1,'Andrew','Buga','Dmitreevich'),
(2,'Tom','Kuleba','Ivanovich');


SELECT *
FROM employee,car;

SELECT employee.id,employee.name,employee.surname,c.id,c.mark,cu.surname,cs.date
FROM employee
RIGHT JOIN car_sell cs on employee.id = cs.employee_id
RIGHT JOIN customer cu on cu.id = cs.customer_id
RIGHT JOIN car c on c.id = cs.car_id
WHERE date > '2021-07-31' AND date < '2021-09-01';


SELECT employee.id,employee.name,employee.surname,c.id,c.mark,cu.surname,cs.date
FROM employee
LEFT JOIN car_sell cs on employee.id = cs.employee_id
LEFT JOIN customer cu on cu.id = cs.customer_id
LEFT JOIN car c on c.id = cs.car_id
WHERE date > '2021-07-31' AND date < '2021-09-01';


------------------example(difference RIGHT and LEFT JOIN)-------------------------------
SELECT employee.id,employee.name,employee.surname,c.id,c.mark,cu.surname,cs.date
FROM employee
RIGHT JOIN car_sell cs on employee.id = cs.employee_id
RIGHT JOIN customer cu on cu.id = cs.customer_id
RIGHT JOIN car c on c.id = cs.car_id;

SELECT employee.id,employee.name,employee.surname,c.id,c.mark,cu.surname,cs.date
FROM employee
LEFT JOIN car_sell cs on employee.id = cs.employee_id
LEFT JOIN customer cu on cu.id = cs.customer_id
LEFT JOIN car c on c.id = cs.car_id;
------------------example(difference RIGHT and LEFT JOIN)-------------------------------

