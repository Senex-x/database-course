CREATE VIEW magnet_shop
AS SELECT * FROM shop
   WHERE name LIKE 'Magnet'
        WITH CASCADED CHECK OPTION;

SELECT * FROM magnet_shop;

CREATE VIEW magnet_moscow_shop
AS SELECT * FROM magnet_shop
   WHERE location LIKE 'Kazan';

SELECT * FROM magnet_moscow_shop;

