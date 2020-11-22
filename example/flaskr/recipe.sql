
-- Inserts dummy data into recipe_cat, recipe, and recipe_ingredient tables

INSERT INTO recipe_cat ('name') VALUES ('Breakfast'), ('Lunch'), ('Dinner'), ('Side'), ('Dessert');

INSERT INTO recipe ('author_id', 'category_id', 'title', 'body') 
    VALUES (1, 4, 'Potato Gratin', 
        'Grease an oven safe dish. Thinly slice and layer potatoes. 
        Season with salt and pepper. Add milk and remaining butter. 
        Bake at 425 deg F for 30 min.' );

INSERT INTO recipe_ingredient ('recipe_id', 'ingredient_id', 'amount', 'unit') 
    VALUES (1, 1, 3, 'Tbs'), (1, 4, 1.5, 'lbs'), (1, 7, 3, 'Tbs'), (1, 9, 3,'tsp'),
        (1, 11, 1, 'c');