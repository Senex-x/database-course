INSERT INTO public.department_product (id, shop_department_id, name, price, manufacture_date, storage_life) VALUES (1, 2, 'Milk', 2, '2021-10-04', 14);
INSERT INTO public.department_product (id, shop_department_id, name, price, manufacture_date, storage_life) VALUES (2, 3, 'Bread', 1, '2021-10-04', 3);
INSERT INTO public.department_product (id, shop_department_id, name, price, manufacture_date, storage_life) VALUES (3, 4, 'Water', 1, '2021-10-04', 180);

INSERT INTO public.department_product (id, shop_department_id, name, price, manufacture_date, storage_life) VALUES (1, 2, 'Milk', 2, '2021-10-04', 14);
INSERT INTO public.department_product (id, shop_department_id, name, price, manufacture_date, storage_life) VALUES (2, 3, 'Bread', 1, '2021-10-04', 3);
INSERT INTO public.department_product (id, shop_department_id, name, price, manufacture_date, storage_life) VALUES (3, 4, 'Water', 1, '2021-10-04', 180);

INSERT INTO public.product_discount (id, department_product_id, percentage) VALUES (1, 1, 30);
INSERT INTO public.product_discount (id, department_product_id, percentage) VALUES (2, 2, 60);

INSERT INTO public.product_discount (id, department_product_id, percentage) VALUES (1, 1, 30);
INSERT INTO public.product_discount (id, department_product_id, percentage) VALUES (2, 2, 60);

INSERT INTO public.shop (id, name, contact_email, location) VALUES (4, 'Ashan', 'dfbdfnh', 'Kazan');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (3, 'Eleven', 'cvbdd', 'Izhevsk');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (2, 'Five', 'wetwew', 'Moscow');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (6, 'FixPrice', 'gfjgyy', 'Kazan');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (1, 'Magnet', 'wettt@m.ru', 'Moscow');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (7, 'Magnet', 'kjashhkd@sdg.s', 'Moscow');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (8, 'Magnet', 'dhgfdh@d.ru', 'Kazan');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (9, 'Magnet', 'cxbb@mag.com', 'Izhevsk');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (10, 'Grocery', 'dhgfhd@mag.com', 'Moscow');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (11, 'Paul''s', 'wefef@mag.com', 'Moscow');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (12, 'Ashan', 'dhgfhd@wefwe.com', 'Salavat');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (13, 'FixPrice', 'jkjjj@mag.com', 'Izhevsk');
INSERT INTO public.shop (id, name, contact_email, location) VALUES (5, 'Magnet', '12344124', 'Kazan');

INSERT INTO public.shop_department (id, shop_id, name) VALUES (1, 1, 'Grocery');
INSERT INTO public.shop_department (id, shop_id, name) VALUES (2, 2, 'M');
INSERT INTO public.shop_department (id, shop_id, name) VALUES (3, 4, 'H');
INSERT INTO public.shop_department (id, shop_id, name) VALUES (4, 5, 'F');
INSERT INTO public.shop_department (id, shop_id, name) VALUES (5, 7, 'Y');
INSERT INTO public.shop_department (id, shop_id, name) VALUES (6, 2, 'E');

INSERT INTO public.supplier (id, name, contact_number, contact_email, location) VALUES (1, 'Default Production', '23878323', 'sdfjsd@dsf.com', 'Moscow');
INSERT INTO public.supplier (id, name, contact_number, contact_email, location) VALUES (3, 'Harbinger and Brick', '15541422', 'xbcvnm@vbbnn.uk', 'Moscow');
INSERT INTO public.supplier (id, name, contact_number, contact_email, location) VALUES (2, 'Son and Co.', '438534795', 'sdsjdhhh@sddvvv.us', 'Kazan');
INSERT INTO public.supplier (id, name, contact_number, contact_email, location) VALUES (4, 'Newcomer', '235235', 'dfgdfg@sdg.in', 'Voronezh');

INSERT INTO public.supplier_main_office (location, workers_amount, salary_expenses, rent_expenses) VALUES ('Moscow', 120, 450000, 1850000);
INSERT INTO public.supplier_main_office (location, workers_amount, salary_expenses, rent_expenses) VALUES ('Kazan', 50, 100000, 650000);
INSERT INTO public.supplier_main_office (location, workers_amount, salary_expenses, rent_expenses) VALUES ('Voronezh', null, null, 100000);

INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (1, 1, 1);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (2, 1, 2);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (3, 2, 4);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (4, 3, 4);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (5, 2, 5);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (6, 3, 4);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (7, 1, 5);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (8, 3, 7);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (9, 2, 8);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (10, 3, 3);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (11, 1, 9);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (12, 1, 2);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (13, 2, 11);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (14, 3, 12);
INSERT INTO public.supplier_shop_map (id, supplier_id, shop_id) VALUES (15, 1, 10);