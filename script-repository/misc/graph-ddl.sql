create table if not exists nodes
(
    id varchar(4) not null
        constraint nodes_pk
            primary key
);

alter table nodes
    owner to postgres;

create table if not exists edges
(
    start_node_id varchar(4) not null,
    end_node_id   varchar(4) not null,
    weight        integer    not null,
    constraint edges_pk
        primary key (start_node_id, end_node_id)
);

alter table edges
    owner to postgres;
