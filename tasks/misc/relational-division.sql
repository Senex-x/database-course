SELECT aspirant.name
FROM test.aspirant AS aspirant
         INNER JOIN test.skills AS skills
                    ON aspirant.skill_id = skills.skill_id
GROUP BY aspirant.name
HAVING COUNT(aspirant.skill_id) = (
    SELECT COUNT(skills.skill_id)
    FROM test.skills AS skills
)
ORDER BY aspirant.name;