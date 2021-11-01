create table supplier
(
    id serial
        constraint supplier_pk
            primary key,
    name varchar(64) not null,
    contact_number varchar(16),
    contact_email varchar(64) not null,
    location varchar(64)
);

alter table supplier owner to postgres;

create table shop
(
    id serial
        constraint shop_pk
            primary key,
    name varchar(64) not null,
    contact_email varchar(64) not null,
    location varchar(64)
);

alter table shop owner to postgres;

create table shop_department
(
    id serial
        constraint shop_department_pk
            primary key,
    shop_id integer not null
        constraint shop_department_shop_id_fk
            references shop,
    name varchar(64) not null
);

alter table shop_department owner to postgres;

create table department_worker
(
    id serial
        constraint department_worker_pk
            primary key,
    shop_department_id integer not null
        constraint department_worker_shop_department_id_fk
            references shop_department,
    name varchar(64) not null,
    salary integer not null,
    surname varchar(64) not null,
    boss_id integer
);

alter table department_worker owner to postgres;

create table department_product
(
    id serial
        constraint department_product_pk
            primary key,
    shop_department_id integer not null
        constraint department_product_shop_department_id_fk
            references shop_department,
    name varchar(64) not null,
    price integer not null,
    manufacture_date date not null,
    storage_life integer not null
);

alter table department_product owner to postgres;

create table product_discount
(
    id serial
        constraint product_discount_pk
            primary key,
    department_product_id integer not null
        constraint product_discount_department_product_id_fk
            references department_product,
    percentage integer not null
);

alter table product_discount owner to postgres;

create table supplier_shop_map
(
    id serial
        constraint supplier_shop_map_pk
            primary key,
    supplier_id integer not null,
    shop_id integer not null
);

alter table supplier_shop_map owner to postgres;

create table supplier_main_office
(
    location varchar(64) not null
        constraint supplier_main_office_pk
            primary key,
    workers_amount integer,
    salary_expenses integer,
    rent_expenses integer
);

alter table supplier_main_office owner to postgres;

create unique index supplier_main_office_location_uindex
    on supplier_main_office (location);

create view magnet_shop(id, name, contact_email, location) as
SELECT shop.id,
       shop.name,
       shop.contact_email,
       shop.location
FROM shop
WHERE shop.name::text ~~ 'Magnet'::text
        with local check option;

alter table magnet_shop owner to postgres;

create view magnet_moscow_shop(id, name, contact_email, location) as
SELECT magnet_shop.id,
       magnet_shop.name,
       magnet_shop.contact_email,
       magnet_shop.location
FROM magnet_shop
WHERE magnet_shop.location::text ~~ 'Kazan'::text
        with cascaded check option;

alter table magnet_moscow_shop owner to postgres;

create view magnet_moscow_shop_id_5(id, name, contact_email, location) as
SELECT magnet_moscow_shop.id,
       magnet_moscow_shop.name,
       magnet_moscow_shop.contact_email,
       magnet_moscow_shop.location
FROM magnet_moscow_shop
WHERE magnet_moscow_shop.id > 4;

alter table magnet_moscow_shop_id_5 owner to postgres;

