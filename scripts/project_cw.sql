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

