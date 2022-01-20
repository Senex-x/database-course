-- Without repeating rows
SELECT *
FROM test.set_1
INTERSECT
SELECT *
FROM test.set_2
ORDER BY value;

-- With repeating rows
SELECT *
FROM test.set_1
INTERSECT ALL
SELECT *
FROM test.set_2
ORDER BY value;

-- Without repeating rows
SELECT *
FROM test.set_1
UNION
SELECT *
FROM test.set_2
ORDER BY value;

-- With repeating rows
SELECT *
FROM test.set_1
UNION ALL
SELECT *
FROM test.set_2
ORDER BY value;