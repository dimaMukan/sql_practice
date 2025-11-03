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

CREATE OR REPLACE FUNCTION mkr1(n float) RETURNS float AS $$
DECLARE
    counter float = 1.0;
    res float = 0.0;
    BEGIN
        WHILE counter>64.0
            LOOP
                IF n = counter-1.0 THEN
                    RETURN 0.0;
                end if;
                counter = counter*2;
                res = res + ((n-counter)/(n-(counter-1)));
--                 SELECT res + ((n-counter)/(n-(counter-1))) INTO res;
            end loop;
        RETURN res;
    end;
    $$LANGUAGE plpgsql;

SELECT mkr1(6.0);


CREATE OR REPLACE FUNCTION fib(n int) RETURNS int AS $$
DECLARE
    counter int = 0;
    i int = 0;
    j int = 1;
    BEGIN
        IF n<1 THEN
            RETURN 0;
        end if;
        WHILE counter<=n
            LOOP
                counter = counter+1;
                SELECT j,i+j INTO i,j;
            end loop;
        RETURN i;
    end;
    $$LANGUAGE plpgsql;


SELECT fib(9)

