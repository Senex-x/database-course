-- All routes from node 'S' to node 'Y' within the 10-step boundary
WITH recursive all_paths_cte (path_end_node_id, steps, distance, way) AS (
    SELECT DISTINCT start_node_id,
                    0,
                    0,
                    CAST(start_node_id AS varchar(128))
    FROM edges
    WHERE start_node_id = 'S'
    UNION ALL
    SELECT end_node_id,
           current_state.steps + 1,
           current_state.distance + next_node.weight,
           CAST(current_state.way || next_node.end_node_id AS varchar(128))
    FROM edges AS next_node
             INNER JOIN all_paths_cte AS current_state
                        ON current_state.path_end_node_id = next_node.start_node_id
                            AND current_state.steps < 10
)
SELECT steps,
       distance,
       way
FROM all_paths_cte
WHERE path_end_node_id = 'Y';

-- Shortest route between node 'S' and node 'Y'
WITH recursive
    shortest_path_cte (path_end_node_id, steps, distance, way) AS (
        SELECT DISTINCT start_node_id,
                        0,
                        0,
                        CAST(start_node_id AS varchar(128))
        FROM edges
        WHERE start_node_id = 'S'
        UNION ALL
        SELECT end_node_id,
               current_state.steps + 1,
               current_state.distance + next_node.weight,
               CAST(current_state.way || next_node.end_node_id AS varchar(128))
        FROM edges AS next_node
                 INNER JOIN shortest_path_cte AS current_state
                            ON current_state.path_end_node_id = next_node.start_node_id
                                AND current_state.steps < 10 -- Depends on amount of nodes in graph
    ),
    shortest(distance) AS (
        SELECT MIN(distance)
        FROM shortest_path_cte
        WHERE path_end_node_id = 'Y'
    )
SELECT path_end_node_id,
       way,
       cte.distance
FROM shortest_path_cte cte
         INNER JOIN shortest
                    ON cte.DISTANCE = shortest.DISTANCE
                        AND path_end_node_id = 'Y';

