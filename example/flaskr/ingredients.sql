
-- Inserts dummy data into ingredient_cat and ingredient tables

INSERT INTO ingredient_cat ('name') VALUES ('FAT'), ('POTATO'), ('SALT'), ('SPICE'), ('MILK');

INSERT INTO ingredient VALUES (NULL,'butter-generic', 1, 3.0, 3.5, 3.0, 2.5, 2.5, 3.0, 2.0);
INSERT INTO ingredient VALUES (NULL, 'butter-organic', 1, 3.0, 3.5, 3.0, 3.0, 3.0, 3.5, 2.0);
INSERT INTO ingredient VALUES (NULL, 'butter-vegan', 1, 3.0, 3.5, 3.0, 3.0, 4.5, 3.5, 4.0);

INSERT INTO ingredient VALUES (NULL, 'potatoes-generic', 2, 4.0, 4.0, 3.0, 3.0, 4.5, 3.5, 4.0);
INSERT INTO ingredient VALUES (NULL, 'potatoes-organic', 2, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 4.0);
INSERT INTO ingredient VALUES (NULL, 'potatoes-local', 2, 4.0, 4.0, 4.5, 4.5, 4.5, 4.5, 5.0);

INSERT INTO ingredient VALUES (NULL, 'salt-generic', 3, 4.0, 4.0, 3.0, 3.0, 4.5, 3.5, 4.0);
INSERT INTO ingredient VALUES (NULL, 'salt-imported', 3, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 3.0);

INSERT INTO ingredient VALUES (NULL, 'pepper-generic', 4, 4.0, 4.0, 3.0, 3.0, 4.5, 3.5, 4.0);
INSERT INTO ingredient VALUES (NULL, 'pepper-organic', 4, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 3.0);

INSERT INTO ingredient VALUES (NULL, 'milk-generic', 5, 3.0, 4.0, 3.0, 2.5, 2.5, 2.5, 1.0);
INSERT INTO ingredient VALUES (NULL, 'milk-organic', 5, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 2.0);   
INSERT INTO ingredient VALUES (NULL, 'milk-soy', 5, 4.0, 3.5, 4.0, 4.0, 4.5, 3.5, 4.0);   