-- 3

SELECT client.document_id, client.name
FROM loans
         INNER JOIN clients AS client
                    ON loans.is_closed = false
                        AND loans.document_id = client.document_id;


-- 4

WITH money_taken_per_branch AS (
    SELECT branch_id, SUM(money_amount_taken) AS money_taken_total
    FROM loans
    GROUP BY branch_id
),
     city_total_take AS (
         SELECT city, money_taken_total
         FROM branches
                  INNER JOIN
              money_taken_per_branch
              ON branches.id = money_taken_per_branch.branch_id
     ),
     unique_city_total_take AS (
         SELECT city, SUM(money_taken_total) AS money_taken_total
         FROM city_total_take
         GROUP BY city

     ),
     max AS (
         SELECT MAX(money_taken_total) AS max_money_taken
         FROM money_taken_per_branch
     )

SELECT city, max.max_money_taken
FROM unique_city_total_take
         INNER JOIN max
                    ON max.max_money_taken = money_taken_total;


-- 5

SELECT clients.name AS client_name, clients.address AS client_address, total_loan
FROM clients
         INNER JOIN (
    SELECT document_id, SUM(money_amount_taken) AS total_loan
    FROM loans
    WHERE expiration_date < CURRENT_DATE
      AND is_closed = false
    GROUP BY document_id
) AS client_ids_loans
                    ON clients.document_id = client_ids_loans.document_id
ORDER BY total_loan DESC;


-- Generated table definitions

create table credits.clients
(
    document_id serial
        constraint clients_pk
            primary key,
    name varchar(128) not null,
    address varchar(256) not null
);

alter table credits.clients owner to postgres;

create table credits.branches
(
    id integer default nextval('credits.branch_id_seq'::regclass) not null
        constraint branch_pk
            primary key,
    city varchar(128) not null
);

alter table credits.branches owner to postgres;

create table credits.loans
(
    document_id integer not null
        constraint loans_clients_document_id_fk
            references credits.clients,
    branch_id integer not null
        constraint loans_branches_id_fk
            references credits.branches,
    money_amount_taken integer not null
        constraint loans_money_amount_taken_check
            check (money_amount_taken <= 150000),
    expiration_date date not null,
    receiving_date date not null,
    is_closed boolean not null,
    closing_date date,
    money_amount_returned integer,
    constraint loans_check
        check (receiving_date <= closing_date),
    constraint loans_check2
        check (money_amount_taken <= money_amount_returned),
    constraint loans_check1
        check ((receiving_date + '61 days'::interval) >= expiration_date)
);

alter table credits.loans owner to postgres;
