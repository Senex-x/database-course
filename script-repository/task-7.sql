-- Constraint example:
-- CHECK
CREATE TABLE IF NOT EXISTS product_discount
(
    id SERIAL
        CONSTRAINT product_discount_pk
            PRIMARY KEY,
    department_product_id INTEGER NOT NULL
        CONSTRAINT product_discount_department_product_id_fk
            REFERENCES department_product,
    percentage INTEGER NOT NULL
        CHECK ( percentage > 0 AND percentage < 100 )
);

-- Constraints example:
-- PRIMARY KEY, NOT NULL
CREATE TABLE IF NOT EXISTS supplier
(
    id SERIAL
        CONSTRAINT supplier_pk
            PRIMARY KEY,
    name varchar(64) NOT NULL,
    contact_number varchar(16),
    contact_email varchar(64) NOT NULL,
    location varchar(64)
);

-- Altered constraint example:
-- UNIQUE
ALTER TABLE supplier
    ADD CONSTRAINT uc_set_name_number_email
        UNIQUE (name, contact_number, contact_email);

-- Altered constraint example:
-- FOREIGN KEY
ALTER TABLE department_product
    ADD CONSTRAINT department_product_shop_department_id_fk
        FOREIGN KEY (shop_department_id)
            REFERENCES shop_department;






