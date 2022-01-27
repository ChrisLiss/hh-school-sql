SELECT area_id,
       round(avg(compensation_from), -3) AS avg_comp_from,
       round(avg(compensation_to), -3) AS avg_comp_to,
       round(avg((compensation_from + compensation_to) / 2), -3) AS avg_mid_comp
FROM employer e
        LEFT JOIN vacancy v ON e.employer_id = v.employer_id
GROUP BY area_id;