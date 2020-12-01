-- Complex SQL queries to reference

-- Given an ingredient name, get all ingredients in the same category with a
-- higher average rating. Example using ingredient name = 'milk-generic'
DROP TABLE IF EXISTS table1;
CREATE TEMP TABLE table1 AS SELECT * FROM
(SELECT id, r_avg FROM (SELECT id, category_id, 
(r_nourishment + r_value + r_human_welfare + r_animal_welfare + r_resource_cons + r_biodiversity + r_global_warming)/7 as r_avg FROM ingredient)
WHERE category_id = (SELECT category_id FROM ingredient WHERE name = 'milk-generic'))
INNER JOIN ingredient USING(id);
SELECT * FROM table1 WHERE r_avg > (SELECT r_avg FROM table1 WHERE name = 'milk-generic');

-- Get recipe x recipe_ingredient x ingredient
SELECT * FROM (SELECT * FROM recipe r JOIN 
recipe_ingredient ri ON r.id = ri.recipe_id) 
JOIN ingredient i ON i.id = ingredient_id

-- Given a recipe id, get the amount, unit, and category of all ingredients
SELECT recipe_id, ingredient_id, amount, unit, name, category_id FROM recipe_ingredient ri 
JOIN ingredient i ON i.id = ingredient_id
WHERE recipe_id = 1

-- Get all recipes in a user's recipe book given a current user--
SELECT * FROM recipe r JOIN recipeBook_recipe rbr ON 
rbr.recipeBook_id = (SELECT id FROM recipeBook WHERE author_id = 2)