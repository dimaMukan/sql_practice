DROP TABLE if exists employee CASCADE;

CREATE TABLE employee
(
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(200),
    department    VARCHAR(200),
    salary        INT,
    starting_date DATE,
    city          VARCHAR(200)
);

INSERT INTO employee (name, department, salary, starting_date, city)
VALUES ('Alice', 'HR', 40000, '2020-03-15', 'Лондон'),
       ('Боб', 'IT', 55000, '2019-07-10', 'Манчестер'),
       ('Чарли', 'Finance', 48000, '2021-01-05', 'Лондон'),
       ('Диана', 'IT', 61000, '2018-12-20', 'Бирмингем'),
       ('Ева', 'Marketing', 45000, '2022-06-01', 'Лидс'),
       ('Фрэнк', 'Finance', 52000, '2020-09-17', 'Ливерпуль'),
       ('Грейс', 'IT', 70000, '2017-03-09', 'Лондон'),
       ('Генри', 'HR', 39000, '2021-01-11', 'Манчестер'),
       ('Ирина', 'Marketing', 46000, '2019-05-23', 'Лондон'),
       ('Джек', 'Finance', 52000, '2018-10-02', 'Лидс');

-- SELECT e.name, e.salary
-- FROM employee e
-- WHERE e.department = 'IT' and e.salary >= 60000;
--
-- SELECT e.name, e.starting_date
-- FROM employee e
-- WHERE e.starting_date >= '2020-09-17'
-- ORDER BY e.starting_date DESC ;
--
-- SELECT e.department, count(e.id)
-- FROM employee e
-- GROUP BY e.department;
--
-- SELECT e.department, avg(e.salary)
-- FROM employee e
-- GROUP BY e.department
-- HAVING avg(e.salary) >= 50000;
--
-- SELECT e.department, max(e.salary)
-- FROM employee e
-- GROUP BY e.department;
--
-- SELECT e.name , e.salary
-- FROM employee e
-- WHERE e.department = 'Finance' and e.salary >= (SELECT avg(salary) FROM employee);
--
-- SELECT e.city, min(e.salary), max(e.salary)
-- FROM employee e
-- GROUP BY e.city;
--
-- SELECT e.name , e.salary
-- FROM employee e
-- WHERE e.salary = (SELECT MAX(em.salary) FROM employee em);
--
-- SELECT e.name, e.salary
-- FROM employee e
-- ORDER BY e.salary DESC
-- LIMIT 2;
--
-- SELECT e.name, e.department, e.salary
-- FROM employee e
-- WHERE e.salary >= (
--     SELECT avg(salary)
--     FROM employee
--     WHERE department = e.department
--     );
--
--
-- SELECT e.city, e.name, e.salary
-- FROM employee e
-- WHERE e.salary <= (
--     SELECT avg(salary)
--     FROM employee em
--     WHERE e.city = em.city
--     );

-- -- Показать топ-2 сотрудников по зарплате в каждом отделе.
SELECT name, salary, department,rank_in_dept
FROM (SELECT e.name,
             e.salary,
             e.department,
             row_number() over (partition by e.department ORDER BY e.salary DESC ) as rank_in_dept
      FROM employee e) ranked
WHERE rank_in_dept <=2;

-- -- Пронумеровать сотрудников внутри каждого отдела по уровню зарплаты (от большего к меньшему).

SELECT id_dept, name, salary, department
FROM (SELECT e.name,
             e.salary,
             e.department,
             row_number() over (partition by e.department order by e.salary DESC) as id_dept
      FROM employee e) temp;

SELECT id_dept, name, salary, department
FROM (SELECT e.name,
             e.salary,
             e.department,
             rank() over (partition by e.department order by e.salary DESC) as id_dept
      FROM employee e) temp;

SELECT e.name, e.department, e.salary, e.salary - avg(salary) over () as salary_comparison,
       row_number() over (order by e.salary DESC ) as ID
FROM employee e;

SELECT e.name, e.department, e.salary,
       round(e.salary * 100.0 / avg(e.salary) OVER (), 1),
       row_number() over (order by e.salary DESC ) as id
FROM employee e;

SELECT e.name, e.department, e.salary,
         e.salary - max(salary) over () as compr,
       row_number() over (order by e.salary DESC ) as id
FROM employee e;


-- Найти отдел, который тратит больше всего на зарплаты.
SELECT department, temp.tot_sal,
       row_number() over (order by temp.tot_sal DESC ) as id
FROM (SELECT e.department, sum(e.salary) as tot_sal
      FROM employee e
      GROUP BY e.department
      ) temp
LIMIT 1;

-- Показать сотрудников, которые работают в городах, где средняя зарплата выше средняя зарплата.
SELECT city, temp.total_sal
FROM (SELECT e.city, avg(e.salary) as total_sal
      FROM employee e
      GROUP BY e.city) temp
WHERE temp.total_sal >= (SELECT avg(salary) FROM employee)
ORDER BY temp.total_sal DESC;

-- Вывести сотрудников, у которых зарплата ниже средней по городу, но выше средней по отделу.
SELECT temp.avg_dep, temp.avg_city, salary, city
FROM (SELECT e.city, e.salary, avg(e.salary) over (partition by e.city) avg_city,  avg(e.salary) over (partition by e.department) as avg_dep
      FROM employee e
      ) temp
WHERE temp.avg_city > salary and salary > temp.avg_dep;

--Найди сотрудников, чья зарплата выше средней по их должности (position), но ниже средней по всему городу, где они работают.
SELECT name, city, department, salary, temp.avg_city, temp.avg_dep,
       row_number() over (partition by department order by salary DESC ) as rank
FROM (SELECT e.salary, e.city, e.department, e.name,
             avg(e.salary) over (partition by e.department) as avg_dep,
             avg(e.salary) over (partition by e.city) as avg_city
      FROM employee e) as temp
WHERE salary > avg_dep and salary < avg_city;


-- Определить, сотрудников из каждого отдела было нанято после 2020 года.
SELECT department, name, starting_date,
                    row_number() over (partition by department order by starting_date) as rank
-- FROM (SELECT e.name, e.department, e.starting_date
--       FROM employee e ) as temp
FROM employee
WHERE starting_date > '2020-01-01';

-- Определить, сколько сотрудников из каждого отдела было нанято после 2020 года.
SELECT department, max(rank)
FROM (SELECT e.name, e.department, e.starting_date,
             row_number() over (partition by department order by starting_date) as rank
      FROM employee e
      WHERE starting_date > '2020-01-01') as temp
GROUP BY department
ORDER BY max(rank);


-- Определить, сколько сотрудников из каждого отдела было нанято после 2020 года.
SELECT DISTINCT department, rank
FROM (SELECT e.name, e.department, e.starting_date,
             count(*) over (partition by department) as rank
      FROM employee e
      WHERE starting_date > '2020-01-01') as temp;

-- Для каждого города показать, какой отдел в нём платит в среднем больше всех.
SELECT city, temp.avg_sal, department
FROM(SELECT e.city,e.department,e.name,
            avg(e.salary) over (partition by e.city,e.department) as avg_sal,
            rank() over (partition by e.city order by e.salary DESC) as rank
FROM employee e) temp
WHERE temp.rank = 1;


-- Для каждого города определить,
-- в каком отделе работает самый высокооплачиваемый сотрудник,
-- и показать среднюю зарплату этого отдела в этом городе.

SELECT  name,city,department, temp.max_city, avg(salary) over (partition by city,department) as avg_per_city
FROM (SELECT e.name,e.city, e.department,e.salary, max(e.salary) over (partition by e.city) as max_city
      FROM employee e) temp
WHERE salary = temp.max_city
ORDER BY temp.max_city DESC












