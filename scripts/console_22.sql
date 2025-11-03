DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS Place;

CREATE TABLE Place(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(120) NOT NULL UNIQUE PRIMARY KEY ,
    salary integer NOT NULL
);

INSERT INTO Place(name, salary)
VALUES
('temp1',101),
('temp2',102),
('temp3',103),
('temp4',104),
('temp5',105);

CREATE TABLE employees(
   id INT GENERATED ALWAYS AS IDENTITY,
   full_name VARCHAR(120) NOT NULL,
   birtday date NOT NULL,
   name_fk VARCHAR(120) NOT NULL REFERENCES Place(name),
   PRIMARY KEY(id)
);

INSERT INTO employees (full_name, birtday,name_fk)
VALUES
('John Doe','1999-10-17','temp2'),
('Lily Bush','2001-03-01','temp1'),
('Andrew Cir','1989-02-09','temp2'),
('Clar Ray','2004-09-23','temp4'),
('Lary Mik','2004-05-10','temp5');

SELECT *
FROM employees,Place;

SELECT *
FROM Place
LEFT JOIN employees on Place.name = employees.name_fk;

SELECT *
FROM Place
RIGHT JOIN employees on Place.name = employees.name_fk;

SELECT *
FROM employees
RIGHT JOIN Place on Place.name = employees.name_fk;

SELECT *
FROM Place
LEFT JOIN employees on Place.name = employees.name_fk
WHERE salary = (SELECT MAX(salary) FROM Place);

