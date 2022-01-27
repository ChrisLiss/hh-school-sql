-- Подсчет откликов, которые были сделаны в определенный интервал времени.
-- Таблица откликов - 1 000 000 записей
-- Примерное время выполнения без индекса: 100-110 мс
-- Примерное время выполнения с индексом по полю date_response: 47-62 мс

SELECT count(vacancy_id)
FROM response
WHERE date_response BETWEEN CURRENT_DATE-10 AND CURRENT_DATE - 5;

CREATE INDEX  date_resp_idx ON response (date_response);