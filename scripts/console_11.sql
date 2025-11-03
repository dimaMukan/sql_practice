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
('Lily', 'Bush',234),
('John','Smitt',567),
('Bred','Pitt',769),
('Angelina','Jolly',987);

--###################################

DO $$
DECLARE
    cur refcursor;
    rec record;
BEGIN
    OPEN cur FOR SELECT * FROM employees;
    MOVE cur; --пропускает первое
    FETCH cur INTO rec; --читает второе
    RAISE NOTICE '%',rec; --выводит второе
    CLOSE cur;
END
$$;

--###################################

DO $$
DECLARE
    cur refcursor;
    rec record;
BEGIN
    OPEN cur FOR SELECT * FROM employees;
    LOOP
        FETCH cur into rec;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%',rec;
    END loop;
    CLOSE cur;
END
$$;

--###################################

DO $$
DECLARE
    cur CURSOR FOR SELECT * FROM employees;
BEGIN
    FOR rec IN cur LOOP
        RAISE NOTICE '%',rec;
    end loop;
END
$$;

--###################################

DO $$
DECLARE
    cur CURSOR FOR SELECT * FROM employees;
BEGIN
    FOR rec IN cur LOOP
        MOVE cur;--с пропускрм в один
        RAISE NOTICE '%',rec;
    end loop;
END
$$;

