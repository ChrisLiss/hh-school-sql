INSERT INTO employment_type (timetable_type_title)
VALUES ('Полная занятость'),
       ('Частичная занятость'),
       ('Проектная работа'),
       ('Волонтерство'),
       ('Стажировка');

INSERT INTO timetable (timetable_title)
VALUES ('Полный день'),
       ('Сменный график'),
       ('Гибкий график'),
       ('Удаленная работа'),
       ('Вахтовый метод');

INSERT INTO education_type (education_type_title)
VALUES ('Среднее'),
       ('Среднее специальное'),
       ('Неоконченное высшее'),
       ('Высшее'),
       ('Бакалавр'),
       ('Магистр'),
       ('Кандидат наук'),
       ('Доктор наук');

INSERT INTO specialization (specialization_title)
VALUES ('Автомойщик'),
       ('Администратор'),
       ('Делопроизводитель'),
       ('Курьер'),
       ('Переводчик'),
       ('Охранник'),
       ('Юрист'),
       ('Программист, разработчик'),
       ('Системный инженер'),
       ('Тестировщик'),
       ('Офис-менеджер'),
       ('Аналитик');

INSERT INTO area (area_title)
VALUES ('Алтайский край'),
        ('Архангельская область'),
        ('Владимирская область'),
        ('Воронежская область'),
        ('Ивановская область'),
        ('Калининградская область'),
        ('Краснодарский край'),
        ('Ленинградская область'),
        ('Москва'),
        ('Московская область'),
        ('Нижегородская область'),
        ('Тульская область');

WITH test_data (id, title, id_area) AS (
    SELECT generate_series(1,1000) AS id,
           md5(random()::text) AS title,
           (((random()*100)::int) % 12) + 1 AS id_area
)
INSERT INTO employer (employer_name, area_id)
SELECT title, id_area
FROM test_data;

WITH test_data (id, title1, title2, totle3, phone, id_area, type_edu) AS (
    SELECT generate_series(1,10000) AS id,
           md5(random()::text) AS title,
           md5(random()::text) AS title2,
           md5(random()::text) AS title3,
           (((random()*100)::int) % 12) + 1 AS id_area,
           md5(random()::text) AS phone,
           (((random()*10)::int) % 8) + 1 AS type_edu
)
INSERT INTO candidate (first_name, second_name, middle_name,area_id, telephone, education_type_id)
SELECT title1, title2, totle3, phone, id_area, type_edu
FROM test_data;

WITH test_data (id, title, date_int, empl_id, salary, cand_id) AS (
    SELECT generate_series(1,100000) AS id,
           md5(random()::text) AS title,
           (random()*200)::int AS date_int,
           (((random() * 10)::int) % 5) + 1 AS empl_id,
           round((random() * 100000)::int, -3) AS salary,
           (((random() * 100000) ::int)% 10000) + 1 AS cand_id
)
INSERT INTO resume (resume_title, candidate_id, salary, employment_type_id, date_publication)
SELECT title, cand_id, salary, empl_id, current_date - date_int
FROM test_data;

WITH test_data (id, title, salary, empl_id, date_int, empl_tupe_id, timetable_id, gros) AS (
    SELECT generate_series(1,10000) AS id,
           md5(random()::text) AS title,
           round((random() * 100000)::int, -3) AS salary,
           (((random() * 10000) ::int) % 1000) + 1 AS empl_id,
           (random()*200)::int AS date_int,
           (((random() * 10)::int) % 5) + 1 AS empl_tupe_id,
           (((random() * 10)::int) % 5) + 1 AS timetable_id,
           (random()::int)::boolean AS gros
)
INSERT INTO vacancy (vacancy_title, compensation_from, compensation_to, employer_id, date_publication, employment_type_id, timetable_id, compensation_gross)
SELECT title, salary, salary + 10000, empl_id, current_date - date_int, empl_tupe_id, timetable_id, gros
FROM test_data;

WITH test_data (id, vac_id, spec_id) AS (
    SELECT generate_series(1,30000) AS id,
       (((random() * 100000) ::int) % 10000) + 1 AS vac_id,
       (((random() * 100) ::int) % 12) + 1 AS spec_id
)
INSERT INTO vacancy_specialization (vacancy_id, specialization_id)
SELECT vac_id, spec_id
FROM test_data;

WITH test_data (id, res_id, spec_id) AS (
    SELECT generate_series(1,300000) AS id,
       (((random() * 1000000) ::int)% 100000) + 1 AS res_id,
       (((random() * 100) ::int) % 12) + 1 AS spec_id
)
INSERT INTO resume_specialization (resume_id, specialization_id)
SELECT res_id, spec_id
FROM test_data;

WITH test_data (id, vac_id, res_id) AS (
    SELECT generate_series(1, 1000000) AS id,
           (((random() * 100000) ::int) % 10000) + 1 AS vac_id,
           (((random() * 1000000) ::int) % 100000) + 1 AS res_id
)
INSERT INTO response (vacancy_id, resume_id, date_response)
SELECT vac_id, res_id, vac.date_publication + (random() * 30)::int
FROM test_data test
INNER JOIN vacancy vac ON test.vac_id = vac.vacancy_id;
