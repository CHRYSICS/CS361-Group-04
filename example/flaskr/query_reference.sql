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