BEGIN TRANSACTION;
INSERT INTO "ingredient_cat" ("id","name") VALUES (1,'Fat');
INSERT INTO "ingredient_cat" ("id","name") VALUES (2,'Potato');
INSERT INTO "ingredient_cat" ("id","name") VALUES (3,'Salt');
INSERT INTO "ingredient_cat" ("id","name") VALUES (4,'Spice');
INSERT INTO "ingredient_cat" ("id","name") VALUES (5,'Milk');
INSERT INTO "ingredient_cat" ("id","name") VALUES (6,'Sugar');
INSERT INTO "ingredient_cat" ("id","name") VALUES (7,'Egg');
INSERT INTO "ingredient_cat" ("id","name") VALUES (8,'Vanilla');
INSERT INTO "ingredient_cat" ("id","name") VALUES (9,'Leavener');
INSERT INTO "ingredient_cat" ("id","name") VALUES (10,'Chocolate');
INSERT INTO "ingredient_cat" ("id","name") VALUES (11,'Nuts');
INSERT INTO "ingredient_cat" ("id","name") VALUES (12,'Flour');
INSERT INTO "ingredient_cat" ("id","name") VALUES (13,'Farro');
INSERT INTO "ingredient_cat" ("id","name") VALUES (14,'Water');
INSERT INTO "ingredient_cat" ("id","name") VALUES (15,'Onion');
INSERT INTO "ingredient_cat" ("id","name") VALUES (16,'Garlic');
INSERT INTO "ingredient_cat" ("id","name") VALUES (17,'Tomato');
INSERT INTO "ingredient_cat" ("id","name") VALUES (18,'Herb');
INSERT INTO "ingredient_cat" ("id","name") VALUES (19,'Cheese');
INSERT INTO "ingredient_cat" ("id","name") VALUES (20,'Yeast');
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (1,'butter-generic',1,3.0,3.5,3.0,2.5,2.5,3.0,2.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (2,'butter-organic',1,3.0,3.5,3.0,3.0,3.0,3.5,2.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (3,'butter-vegan',1,3.0,3.5,3.0,3.0,4.5,3.5,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (4,'potatoes-generic',2,4.0,4.0,3.0,3.0,4.5,3.5,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (5,'potatoes-organic',2,4.0,4.0,4.0,4.0,4.5,3.5,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (6,'potatoes-local',2,4.0,4.0,4.5,4.5,4.5,4.5,5.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (7,'salt-generic',3,4.0,4.0,3.0,3.0,4.5,3.5,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (8,'salt-imported',3,4.0,4.0,4.0,4.0,4.5,3.5,3.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (9,'pepper-generic',4,4.0,4.0,3.0,3.0,4.5,3.5,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (10,'pepper-organic',4,4.0,4.0,4.0,4.0,4.5,3.5,3.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (11,'milk-generic',5,3.0,4.0,3.0,2.5,2.5,2.5,1.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (12,'milk-organic',5,4.0,4.0,4.0,4.0,4.5,3.5,2.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (13,'milk-soy',5,4.0,3.5,4.0,4.0,4.5,3.5,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (14,'sugar-granulated-generic',6,0.5,2.0,3.0,3.0,2.5,2.0,2.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (15,'sugar-light-brown-generic',6,0.5,3.0,2.5,3.0,2.5,2.0,2.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (16,'egg-whole-generic',7,4.0,4.0,3.0,2.0,2.5,2.5,2.5);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (17,'vanilla-extract-generic',8,1.0,2.0,3.0,3.0,2.0,2.0,2.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (18,'baking-soda',9,2.0,3.0,3.0,3.0,3.0,3.0,3.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (19,'chocolate-chips-semisweet-generic',10,2.0,2.0,3.0,3.0,2.0,2.5,2.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (20,'walnuts-generic',11,4.0,2.0,4.0,4.0,3.0,3.0,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (21,'flour-all-purpose-unbleached-generic',12,3.0,4.0,4.0,4.0,4.0,2.0,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (22,'farro-semi-pearled-generic',13,4.0,5.0,4.5,4.5,4.0,3.0,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (23,'onion-white-generic',15,4.0,5.0,4.0,5.0,5.0,4.5,4.5);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (24,'tomatoes-cherry-generic',17,4.5,4.5,4.0,4.0,4.0,3.5,3.5);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (25,'pepper-red-flakes-generic',4,4.0,4.0,5.0,5.0,5.0,4.5,4.5);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (26,'olive-oil-extra-virgin-generic',1,4.0,4.0,5.0,5.0,4.0,4.5,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (27,'basil-fresh-generic',18,5.0,4.0,5.0,4.5,4.0,4.0,4.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (28,'parmesan-grated-generic',19,3.5,3.0,4.0,2.5,3.0,2.5,2.5);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (29,'yeast-dry',20,4.0,5.0,5.0,5.0,5.0,5.0,4.5);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (30,'water-tap',14,5.0,5.0,4.5,4.5,3.5,4.0,5.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (31,'tomatoes-cherry-organic',17,5.0,'4..5',5.0,5.0,4.5,4.5,5.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (32,'cheese-vegan-substitute',19,3.5,3.5,4.5,5.0,4.5,4.0,4.5);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (33,'eggs-vegan-substitute',7,4.0,3.5,4.0,4.5,5.0,4.5,5.0);
INSERT INTO "ingredient" ("id","name","category_id","r_nourishment","r_value","r_human_welfare","r_animal_welfare","r_resource_cons","r_biodiversity","r_global_warming") VALUES (34,'flour-all-purpose-unbleached-organic',12,3.0,4.0,4.5,4.5,5.0,4.5,4.5);
INSERT INTO "recipe_cat" ("id","name") VALUES (1,'Breakfast');
INSERT INTO "recipe_cat" ("id","name") VALUES (2,'Lunch');
INSERT INTO "recipe_cat" ("id","name") VALUES (3,'Dinner');
INSERT INTO "recipe_cat" ("id","name") VALUES (4,'Side');
INSERT INTO "recipe_cat" ("id","name") VALUES (5,'Dessert');
INSERT INTO "recipe" ("id","author_id","category_id","created","title","body") VALUES (1,1,4,'2020-12-04 00:19:42','Potato Gratin','Grease an oven safe dish. Thinly slice and layer potatoes. 
        Season with salt and pepper. Add milk and remaining butter. 
        Bake at 425 deg F for 30 min.');
INSERT INTO "recipe" ("id","author_id","category_id","created","title","body") VALUES (2,1,2,'2020-12-04 00:21:10','Chocolate Chip Cookies','Adjust the oven rack to the top third of the oven and preheat to 300F (150C). Line three baking sheets with parchment paper.

Beat the sugars and butters together until smooth. Mix in the egg, vanilla, and baking soda.

Stir together the flour and salt, then mix them into the batter. Mix in the chocolate chips and nuts.

Scoop the cookie dough into 2-tablespoon (5cm) balls and place 8 balls, spaced 4 inches (10cm) apart, on each of the baking sheets.

Bake for 18 minutes, or until pale golden brown. Remove from the oven and cool on a wire rack.');
INSERT INTO "recipe" ("id","author_id","category_id","created","title","body") VALUES (3,1,3,'2020-12-04 01:47:36','One-Pan Farro, by Deb Perelman','Place water and farro in a medium saucepan to presoak. Adding each ingredient to the pot as you finish preparing it, cut onion in half again, and very thinly slice it into quarter-moons. Thinly slice garlic cloves as well. Halve or quarter tomatoes. Add salt, pepper flakes (to taste) and 1 tablespoon olive oil to pan, and set a timer for 30 minutes. Bring uncovered pan (no lid necessary) up to a boil, then reduce to a gentle simmer, stirring occasionally. When the timer rings, the farro should be perfectly cooked (tender but with a meaty chew), seasoned and the cooking water should be almost completely absorbed. If needed, though I’ve never found it necessary, cook it for 5 additional minutes, until farro is more tender.

Transfer to a wide serving bowl. If there’s enough leftover cooking liquid to be bothersome, simply use a slotted spoon to leave the amount you wish to behind. Drizzle farro lightly with additional olive oil, scatter with basil and parmesan.');
INSERT INTO "recipe" ("id","author_id","category_id","created","title","body") VALUES (4,1,1,'2020-12-04 01:50:13','No-Knead Bread','In a large bowl, mix flour, salt, and yeast. Pour in water and fold in until incorporated. Allow to rise, covered, for 9-12 hours. Preheat oven to 450 deg F, with cast iron pot and lid.  With well floured hands, shape dough into a ball. When pot reaches 450 deg, remove from oven. Drop dough into pot and cover with lid. Bake for 30 minutes with lid on, and an additional 15 minutes with lid off. Remove bread from pot, cool completely before slicing and serving. ');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (1,1,3.0,'Tbs');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (1,4,1.5,'lbs');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (1,7,3.0,'Tbs');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (1,9,3.0,'tsp');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (1,11,1.0,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,14,0.5,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,15,0.5,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,1,8.0,'Tbs');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,16,2,'whole');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,17,1.0,'tsp');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,21,1.25,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,7,0.25,'tsp');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,19,1.5,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (2,20,1.0,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,30,2.0,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,22,1.5,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,23,0.5,'whole');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,24,9.0,'oz');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,7,1.25,'tsp');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,25,0.5,'tsp');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,26,1.0,'Tbs');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,27,2.0,'oz');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (3,28,4.0,'oz');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (4,21,3.0,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (4,30,1.5,'c');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (4,29,0.5,'tsp');
INSERT INTO "recipe_ingredient" ("recipe_id","ingredient_id","amount","unit") VALUES (4,7,1.75,'tsp');
COMMIT;
