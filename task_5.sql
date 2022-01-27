SELECT vac.vacancy_id AS id, vacancy_title
FROM vacancy vac
INNER JOIN response r ON vac.vacancy_id = r.vacancy_id
    AND (r.date_response - vac.date_publication) <= 7
GROUP BY id
HAVING count(r.vacancy_id) > 5;