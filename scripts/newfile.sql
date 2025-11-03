CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

-- Добавить пару записей
INSERT INTO users (name, email) VALUES
('Dmytro', 'dmytro@example.com');