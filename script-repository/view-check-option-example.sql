CREATE VIEW magnet_shop AS
SELECT *
FROM shop
WHERE name LIKE 'Magnet';

ALTER VIEW magnet_shop SET (check_option = LOCAL);

INSERT INTO public.magnet_shop
(id, name, contact_email, location)
VALUES (18, '1', '1', '1');

SELECT *
FROM magnet_shop
ORDER BY id;

CREATE VIEW magnet_moscow_shop AS
SELECT *
FROM magnet_shop
WHERE location LIKE 'Kazan';

ALTER VIEW magnet_moscow_shop SET (check_option = CASCADED);

SELECT *
FROM magnet_moscow_shop
ORDER BY id;

INSERT INTO public.magnet_moscow_shop
(id, name, contact_email, location)
VALUES (19, '2', '2', '2');

CREATE VIEW magnet_moscow_shop_id_5 AS
SELECT *
FROM magnet_moscow_shop
WHERE id > 4;

SELECT *
FROM magnet_moscow_shop_id_5
ORDER BY id;

INSERT INTO public.magnet_moscow_shop_id_5
(id, name, contact_email, location)
VALUES (20, 'Magnet', '1', '1')

