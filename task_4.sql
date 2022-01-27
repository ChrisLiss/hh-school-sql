WITH max_vac (date_vac) AS (
    SELECT to_char(date_publication, 'month YYYY' )AS date_vac
    FROM vacancy
    GROUP BY date_vac
    ORDER BY count(DISTINCT vacancy_id) DESC
    LIMIT 1
), max_res (date_res) AS (
    SELECT to_char(date_publication, 'month YYYY' ) AS date_res
    FROM resume
    GROUP BY date_res
    ORDER BY count(DISTINCT resume_id) DESC
    LIMIT 1
)
SELECT date_vac AS max_mounth_vacancy, date_res AS max_mounth_resume
FROM max_vac
FULL JOIN max_res ON true;