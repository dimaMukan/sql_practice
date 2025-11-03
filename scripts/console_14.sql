CREATE DATABASE lab_2_DB;

DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS buyer;

CREATE TABLE buyer
(
id integer NOT NULL PRIMARY KEY,
surname varchar(30) NOT NULL,
name varchar(30) NOT NULL,
patronymic varchar(30),
passport_info varchar(30) NOT NULL,
address varchar(30),
city varchar(30) NOT NULL,
age integer NOT NULL,
gender varchar(30) NOT NULL
);

CREATE TABLE employee
(
id integer NOT NULL PRIMARY KEY,
surname varchar(30) NOT NULL,
name varchar(30) NOT NULL,
patronymic varchar(30),
work_experience varchar(30),
salary integer
-- CONSTRAINT fk_buyer
--     FOREIGN KEY(id)
--     REFERENCES "buyer"(id)
);

INSERT into buyer
VALUES
(1,'Dima','Mukan',DEFAULT,'978649','Regeneratornaya 4 72','Kyiv',18,'Boy'),
(2,'Vlada','Gusakova','Kirilivna','583794','Regeneratornaya 4 25','Kyiv',18,'Girl'),
(3,'Nikol','Geroivna',DEFAULT,'1237488','Prospect Pobedi 8a','Kyiv',17,'Girl'),
(4,'Ira','Koval','Vasilivna','0983609',DEFAULT,'Ivano Frankivsk',18,'Girl'),
(5,'Oleg','Novich','Vasiliovich','639390083','Lobanovskogo 3','Lviv',19,'Men');

INSERT into employee
VALUES
(1,'Dima','Mukan','Sergiyovich','1y',13800),
(2,'Vlada','Gusakova',DEFAULT,DEFAULT,DEFAULT),
(3,'Nikol','Geroivna','Dmitrivna',DEFAULT,DEFAULT),
(4,'Ira','Koval','Vasilivna','3y',15000),
(5,'Oleg','Novich','Vasiliovich','4y',11000)

