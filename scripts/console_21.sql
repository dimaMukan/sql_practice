
-- CREATE DATABASE lab_4_db;


CREATE TABLE car_sell
(
    id integer NOT NULL PRIMARY KEY,
    date date NOT NULL,
    employee text NOT NULL,
    car text NOT NULL,
    customer text NOT NULL
);

INSERT INTO car_sell
VALUES
(1,'2021-08-01','Dima Mukan','Porshe','Carl Noy'),
(2,'2021-09-02','Andrew Buga','Volkswagen','Nikol Geroivna'),
(3,'2021-09-01','Andrew Buga','Mercedes','Ira Koval'),
(4,'2021-06-15','Dima Mukan','BMW','Vlada Gusakova'),
(5,'2021-08-27','Andrew Buga','Toyota','Oleg Novich'),
(6,'2021-07-28','Dima Mukan','Toyota','Andrew Diari'),
(7,'2021-08-07','Andrew Buga','BMW','Alex Mikula'),
(8,'2021-08-11','Andrew Buga','Rolls-Royce','Vlodimir Zelenskiy'),
(9,'2021-08-31','Andrew Buga','Volkswagen','Alena Kuleba'),
(10,'2021-08-15','Dima Mukan','BMW','Alex Joy');

SELECT *
FROM car_sell
WHERE date > '2021-07-31' AND date < '2021-09-01';


