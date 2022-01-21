--DDL

create sequence member_id_seq
    as integer;

alter sequence member_id_seq owner to postgres;

create sequence event_id_seq
    as integer;

alter sequence event_id_seq owner to postgres;

create sequence priority_id_seq
    as integer;

alter sequence priority_id_seq owner to postgres;

create sequence type_id_seq
    as integer;

alter sequence type_id_seq owner to postgres;

create sequence type_priority_id_seq
    as integer;

alter sequence type_priority_id_seq owner to postgres;

create table members
(
    id integer default nextval('exam_schema_1.member_id_seq'::regclass) not null
        constraint member_pk
            primary key,
    name varchar(128)
);

alter table members owner to postgres;

alter sequence member_id_seq owned by members.id;

create table priorities
(
    id integer default nextval('exam_schema_1.priority_id_seq'::regclass) not null
        constraint priority_pk
            primary key,
    name varchar(128) not null,
    level smallint not null
);

alter table priorities owner to postgres;

alter sequence priority_id_seq owned by priorities.id;

create unique index priority_name_uindex
    on priorities (name);

create table types
(
    id integer default nextval('exam_schema_1.type_id_seq'::regclass) not null
        constraint type_pk
            primary key,
    name varchar(128) not null,
    priority_id integer default nextval('exam_schema_1.type_priority_id_seq'::regclass) not null
        constraint type_priority_id_fk
            references priorities
);

alter table types owner to postgres;

alter sequence type_id_seq owned by types.id;

alter sequence type_priority_id_seq owned by types.priority_id;

create table arrangements
(
    id serial
        constraint arrangement_pk
            primary key,
    name varchar(128) not null,
    description varchar(4096),
    team_id integer not null,
    type_id integer not null
        constraint arrangement_type_id_fk
            references types,
    start_timestamp timestamp not null,
    end_timestamp timestamp not null,
    constraint arrangements_check
        check (start_timestamp < end_timestamp)
);

alter table arrangements owner to postgres;

create table events
(
    id integer default nextval('exam_schema_1.event_id_seq'::regclass) not null
        constraint event_pk
            primary key,
    name varchar(128) not null,
    description varchar(2048),
    end_timestamp timestamp not null,
    start_timestamp timestamp not null,
    arrangement_id integer not null
        constraint events_arrangements_id_fk
            references arrangements,
    constraint events_check1
        check (start_timestamp < end_timestamp)
);

alter table events owner to postgres;

alter sequence event_id_seq owned by events.id;

create table teams
(
    id serial
        constraint team_pk
            primary key,
    head_id integer not null,
    suitable_type_id integer not null
        constraint teams_types_id_fk
            references types
);

alter table teams owner to postgres;

create table staff
(
    id serial
        constraint staff_pk
            primary key,
    name varchar(128),
    monthly_salary integer not null,
    suitable_type_id integer not null
        constraint staff_type_id_fk
            references types,
    team_id integer
        constraint staff_teams_id_fk
            references teams
);

alter table staff owner to postgres;

alter table teams
    add constraint teams_staff_id_fk
        foreign key (head_id) references staff;

create table arrangements_members
(
    arrangement_id integer not null
        constraint events_members_event_id_fk
            references arrangements,
    member_id integer not null
        constraint events_members_member_id_fk
            references members,
    constraint events_members_pk
        primary key (arrangement_id, member_id)
);

alter table arrangements_members owner to postgres;