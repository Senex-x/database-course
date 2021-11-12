-- Task 3

-- Get the longest duration flight row
SELECT *
FROM flights
         INNER JOIN (
    SELECT MAX(duration) max_duration_column
    FROM flights
) max_duration_table ON duration = max_duration_table.max_duration_column;

-- Task 4

-- Get all flights for each airport
WITH all_flights AS (
    SELECT airports.id AS airport_id, flights.id, flights.date
    FROM airports
             JOIN flights
                  ON airports.id = flights.departure_airport_id
                      OR airports.id = flights.arrival_airport_id
),
     -- Filter flights for each airport by the specified day
     all_flights_for_specified_day AS (
         SELECT *
         FROM all_flights
         WHERE all_flights.date = '2021-11-11'
     ),
     -- Get the number of flights for each airport
     all_flights_count_for_specified_day AS (
         SELECT airport_id, count(*) AS flights_count
         FROM all_flights_for_specified_day
         GROUP BY airport_id
     )

SELECT *
FROM all_flights_count_for_specified_day
ORDER BY airport_id;

-- Task 5

WITH all_flights AS (
-- Get all flight ids for all passengers
    SELECT id AS passenger_id, flight_id
    FROM flight_passengers
             JOIN passengers
                  ON flight_passengers.passenger_id = passengers.id
),
     -- Get flight durations for every flight for all passengers
     all_flight_durations AS (
         SELECT passenger_id, flights.duration
         FROM all_flights
                  JOIN flights
                       ON all_flights.flight_id = flights.id
     ),
     -- Get summarized total flight durations for all passengers
     passenger_ids_total_durations AS (
         SELECT passenger_id,
                SUM(duration) AS total_duration
         FROM all_flight_durations
         GROUP BY passenger_id
     ),
     -- Get two the most and the least total durations of all
     extremum_durations AS (
         SELECT MAX(total_duration) AS max_duration,
                MIN(total_duration) AS min_duration
         FROM passenger_ids_total_durations
     ),
     -- Get two passengers with the most and the least total durations
     passenger_ids_extremum_durations AS (
         SELECT passenger_id, total_duration
         FROM passenger_ids_total_durations
                  JOIN extremum_durations
                       ON total_duration = max_duration
                           OR total_duration = min_duration
     ),
     -- Expression is just for pretty print with names.
     -- I deliberately didn't take any columns except the id
     -- from the original table at the beginning of the query,
     -- because I think it is bad, due to the redundancy of the other columns
     -- in terms of reusability and not just printing.
     passengers_extremum_durations AS (
         SELECT passenger_id, name AS passenger_name, total_duration
         FROM passengers
                  INNER JOIN passenger_ids_extremum_durations
                             ON id = passenger_id
     )

SELECT *
FROM passengers_extremum_durations
ORDER BY total_duration DESC;


-- Task 6

-- Get only pilots from all crew members
WITH pilots AS (
    -- name column is put here deliberately
    SELECT id, name AS pilot_name
    FROM crew_members
    WHERE position = 'pilot'
),
     -- Get all flight ids for all pilots
     all_flight_ids AS (
         SELECT id AS pilot_id, flight_id
         FROM pilots
                  JOIN flight_crew_members
                       ON flight_crew_members.crew_member_id = pilots.id
     ),
     -- Get all visited airport ids
     all_airport_ids AS (
         SELECT pilot_id, departure_airport_id, arrival_airport_id
         FROM all_flight_ids
                  JOIN flights
                       ON all_flight_ids.flight_id = flights.id
     ),
     -- Get locations of visited airports
     all_visited_locations AS (
         SELECT pilot_id, airports.location_city AS visited_location
         FROM all_airport_ids
                  JOIN airports
                       ON all_airport_ids.departure_airport_id = airports.id
                           OR all_airport_ids.arrival_airport_id = airports.id
     ),
     -- Aggregate pilot locations into one row
     pilot_id_routes AS (
         SELECT pilot_id, STRING_AGG(visited_location, ' -> ') route
         FROM all_visited_locations
         GROUP BY pilot_id
     ),
     -- Just for the pretty printing with names.
     -- I deliberately did not take names from the original table in the beginning
     -- because i think that it is bad thing to do due to reusability reducing
     pilot_routes AS (
         SELECT pilot_id, pilot_name, route
         FROM pilot_id_routes
                  JOIN pilots
                       ON pilot_id_routes.pilot_id = pilots.id
     )
SELECT *
FROM pilot_routes
ORDER BY pilot_id;

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
