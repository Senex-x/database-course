create table airports
(
    id serial
        constraint airports_pk
            primary key,
    name varchar(64) not null,
    location_city varchar(64) not null
);

alter table airports owner to postgres;

create unique index airports_name_uindex
    on airports (name);

create table airplanes
(
    id serial
        constraint airplanes_pk
            primary key,
    model varchar(64) not null
);

alter table airplanes owner to postgres;

create table passengers
(
    id serial
        constraint passengers_pk
            primary key,
    name varchar(128) not null
);

alter table passengers owner to postgres;

create table crew_members
(
    id serial
        constraint crew_members_pk
            primary key,
    name varchar(128) not null,
    position varchar(128) not null
);

alter table crew_members owner to postgres;

create table flights
(
    id serial
        constraint flights_pk
            primary key,
    departure_airport_id integer not null
        constraint flights_airports_id_fk
            references airports,
    arrival_airport_id integer not null
        constraint flights_airports_id_fk_2
            references airports,
    airplane_id integer not null
        constraint flights_airplanes_id_fk
            references airplanes,
    duration integer not null,
    date date not null
);

alter table flights owner to postgres;

create table flight_crew_members
(
    flight_id integer not null
        constraint flight_crew_members_flights_id_fk
            references flights,
    crew_member_id integer not null
        constraint flight_crew_members_crew_members_id_fk
            references crew_members
);

alter table flight_crew_members owner to postgres;

