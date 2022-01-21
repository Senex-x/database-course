SELECT suitable_type_id, SUM(monthly_salary)
FROM exam_schema_1.staff
GROUP BY suitable_type_id
ORDER BY suitable_type_id;

-- All head ids
SELECT teams.head_id AS id, name
FROM teams
         INNER JOIN staff
                    ON teams.head_id = staff.id;

-- IN test
-- Behaves like ordinary join
WITH head_ids AS (
    SELECT teams.head_id AS head_id
    FROM teams
             INNER JOIN staff
                        ON teams.head_id = staff.id
)
SELECT *
FROM staff
WHERE staff.id IN (
    SELECT head_ids.head_id
    FROM head_ids
)
ORDER BY staff.id;

-- EXISTS test
-- All staff who are neither member nor head of any team
SELECT *
FROM staff
WHERE team_id IS NULL
  AND NOT EXISTS(
        SELECT staff.id
        FROM teams
        WHERE staff.id = teams.head_id
    );

