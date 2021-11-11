-- Task 3

-- Get the longest duration flight row
SELECT *
FROM flights
         INNER JOIN (
    SELECT MAX(duration) max_duration_column
    FROM flights
) max_duration_table ON duration = max_duration_table.max_duration_column;

-- Task 4

-- Queries are split into subexpressions for easier readability step-by-step
-- Get all flights for each airport
SELECT airports.id airport_id, flights.id flight_id, flights.date flight_date
FROM airports
         JOIN flights
              ON airports.id = flights.departure_airport_id
                  OR airports.id = flights.arrival_airport_id
ORDER BY airports.id;

-- Get flights for each airport on the specified day
SELECT airports.id airport_id, flights.id flight_id, flights.date flight_date
FROM airports
         JOIN flights
              ON airports.id = flights.departure_airport_id
                  OR airports.id = flights.arrival_airport_id
WHERE date = '2021-11-11';

-- Get the number of flights for each airport on the specified day
SELECT airport_id, count(*) flights_count
FROM (
         SELECT airports.id airport_id, flights.id flight_id, flights.date flight_date
         FROM airports
                  JOIN flights
                       ON airports.id = flights.departure_airport_id
                           OR airports.id = flights.arrival_airport_id
         WHERE date = '2021-11-11'
     ) all_flights
GROUP BY airport_id
ORDER BY airport_id;

-- Task 4, but there is a nuance

-- Same job done by using 'with' to separate queries
-- in a logical order and without duplications
WITH all_flights AS (
    SELECT airports.id airport_id, flights.id flight_id, flights.date flight_date
    FROM airports
             JOIN flights
                  ON airports.id = flights.departure_airport_id
                      OR airports.id = flights.arrival_airport_id
),
     all_flights_for_specified_day AS (
         SELECT *
         FROM all_flights
         WHERE flight_date = '2021-11-11'
     )

SELECT airport_id, count(*) flights_count
FROM all_flights_for_specified_day
GROUP BY airport_id
ORDER BY airport_id;

-- Task 5
-- Step-by-step explanation

-- Get all flight ids for all passengers
SELECT passenger_id, flight_id
FROM flight_passengers
         JOIN passengers
              ON flight_passengers.passenger_id = passengers.id
ORDER BY flight_id;

-- Get flight durations for every flight
-- by join with 'flights' table
SELECT passenger_id, flights.duration
FROM (
         SELECT passenger_id, flight_id
         FROM flight_passengers
                  JOIN passengers
                       ON flight_passengers.passenger_id = passengers.id
     ) all_flights
         JOIN flights
              ON all_flights.flight_id = flights.id
ORDER BY flight_id;

-- Get passenger ids and their summarized total flight durations
SELECT passenger_id, sum(duration) total_duration
FROM (
         SELECT passenger_id, flights.duration
         FROM (
                  SELECT passenger_id, flight_id
                  FROM flight_passengers
                           JOIN passengers
                                ON flight_passengers.passenger_id = passengers.id
              ) all_flights
                  JOIN flights
                       ON all_flights.flight_id = flights.id
     ) all_flight_durations
GROUP BY passenger_id
ORDER BY passenger_id;

-- Get two passengers with the most and the least total durations
SELECT name, total_duration
FROM passengers
         INNER JOIN (
    WITH total_durations AS (
        SELECT passenger_id, sum(duration) total_duration
        FROM (
                 SELECT passenger_id, flights.duration
                 FROM (
                          SELECT passenger_id, flight_id
                          FROM flight_passengers
                                   JOIN passengers
                                        ON flight_passengers.passenger_id = passengers.id
                      ) all_flights
                          JOIN flights
                               ON all_flights.flight_id = flights.id
             ) all_flight_durations
        GROUP BY passenger_id
    )
    SELECT passenger_id, total_duration
    FROM total_durations
             JOIN (
        SELECT MAX(total_duration) max_duration, MIN(total_duration) min_duration
        FROM total_durations
    ) max_duration_table
                  ON total_duration = max_duration
                      OR total_duration = min_duration
) extremum_total_durations ON id = extremum_total_durations.passenger_id
ORDER BY total_duration DESC;

-- By the way
-- Where is the mistake??
SELECT *
FROM (
         SELECT passenger_id, sum(duration) total_duration
         FROM (
                  SELECT passenger_id, flights.duration
                  FROM (
                           SELECT passenger_id, flight_id
                           FROM flight_passengers
                                    JOIN passengers
                                         ON flight_passengers.passenger_id = passengers.id
                       ) all_flights
                           JOIN flights
                                ON all_flights.flight_id = flights.id
              ) all_flight_durations
         GROUP BY passenger_id
     ) total_durations
         INNER JOIN (
    SELECT MAX(total_duration) max_col
    FROM total_durations
) max_dur_tbl ON total_durations.total_duration = max_dur_tbl.max_col;

-- Task 6