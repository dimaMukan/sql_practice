DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
   id INT GENERATED ALWAYS AS IDENTITY,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   balance integer NOT NULL,
   PRIMARY KEY(id)
);

INSERT INTO employees (first_name, last_name,balance)
VALUES
('John', 'Doe',123),
('Lily', 'Bush',234);

--####################################
BEGIN;
DELETE FROM employees
WHERE id = 1;

SELECT *
FROM employees;

ROLLBACK TRANSACTION ;

SELECT *
FROM employees;
COMMIT;
--####################################

BEGIN;

DELETE
FROM employees
WHERE first_name = 'TEMP';

INSERT INTO employees (first_name, last_name,balance)
VALUES
('TEMP', 'TEMP',1000);

UPDATE employees
SET balance = 2000
WHERE first_name = 'TEMP';
COMMIT;

BEGIN;
UPDATE employees
SET balance = 3000
WHERE first_name = 'TEMP';
-- COMMIT;
ROLLBACK TRANSACTION ;
-- COMMIT;
SELECT *
FROM employees;
--####################################

BEGIN TRANSACTION;
    DELETE
    FROM employees
    WHERE first_name = 'TEMP2';

    INSERT INTO employees (first_name, last_name,balance)
    VALUES
    ('TEMP2', 'TEMP2',1000);

    BEGIN;
        UPDATE employees
        SET balance = 9999
        WHERE first_name = 'TEMP2';
    COMMIT;

END TRANSACTION;

SELECT *
FROM employees;

--####################################
BEGIN;
    DELETE
    FROM employees
    WHERE first_name = 'TEMP3';

    INSERT INTO employees (first_name, last_name,balance)
    VALUES
    ('TEMP3', 'TEMP3',77777);

    SAVEPOINT my_savepoint;

    UPDATE employees
    SET balance = 98908000
    WHERE first_name = 'TEMP3';

    ROLLBACK TO my_savepoint;
COMMIT;

SELECT *
FROM employees;


