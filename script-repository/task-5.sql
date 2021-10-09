-- Shops and their departments together,
-- excluding shops without departments.
SELECT shop.id,
       shop.name,
       department.name
FROM shop
         INNER JOIN shop_department AS department
                    ON shop.id = department.shop_id
ORDER BY shop.id;

-- All shops with their departments,
-- whether they have them or not.
SELECT shop.id,
       shop.name,
       shop.contact_email,
       department.name
FROM shop
         LEFT JOIN shop_department AS department
                   ON shop.id = department.shop_id
ORDER BY shop.id;

-- Local suppliers for each shop.
-- Checks if there is some shops which don't have local suppliers.
SELECT supplier.id,
       shop.location,
       supplier.name,
       shop.id,
       shop.name
FROM supplier
         RIGHT JOIN shop
                    ON supplier.location = shop.location
ORDER BY location;

-- All products and their discounts,
-- no matter if they are actually assigned to some products.
SELECT product.id,
       product.name,
       discount.id,
       discount.percentage
FROM department_product AS product
         FULL JOIN product_discount AS discount
                   ON product.id = discount.department_product_id;

-- All possible combinations of shops and their suppliers.
-- Can be used to search for local suppliers.
SELECT supplier.id,
       supplier.name,
       supplier.location locale,
       shop.id,
       shop.name,
       shop.location
FROM supplier
         CROSS JOIN shop
ORDER BY locale;

-- Suppliers which have at least one local office.
SELECT id,
       location
FROM supplier
         NATURAL JOIN supplier_main_office
ORDER BY id;

-- Chiefs and their subordinates.
SELECT w1.id,
       w1.name,
       w1.surname,
       w2.id,
       w2.name,
       w2.surname
FROM department_worker AS w1
         JOIN department_worker AS w2
              ON w1.id = w2.boss_id
ORDER BY w1.id;

-- All shops which have departments.
SELECT *
FROM shop
WHERE EXISTS(
              SELECT *
              FROM shop_department AS department
              WHERE shop.id = department.shop_id
          )
ORDER BY shop.id;