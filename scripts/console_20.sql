DROP TABLE IF EXISTS employees;

CREATE TABLE employees(
   id INT GENERATED ALWAYS AS IDENTITY,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   balance integer NOT NULL,
   PRIMARY KEY(id)
);

BEGIN TRANSACTION;
    DELETE
    FROM employees
        WHERE first_name = 'TEMP1'
          AND first_name = 'TEMP2'
          AND first_name = 'TEMP3'
          AND first_name = 'TEMP4'
          AND first_name = 'TEMP5';

    INSERT INTO employees (first_name, last_name,balance)
    VALUES
        ('TEMP1', 'TEMP1',77777),
        ('TEMP2', 'TEMP2',77777),
        ('TEMP3', 'TEMP3',77777),
        ('TEMP4', 'TEMP4',77777),
        ('TEMP5', 'TEMP5',77777);

    SAVEPOINT my_savepoint;

    BEGIN;

        UPDATE employees
        SET balance = 1
        WHERE first_name = 'TEMP1' OR first_name = 'TEMP2' OR first_name = 'TEMP3' OR first_name = 'TEMP4' OR first_name = 'TEMP5';

    ROLLBACK TO my_savepoint;

    COMMIT;
END TRANSACTION;

SELECT *
FROM employees;

