BEGIN TRANSACTION;
DROP TABLE IF EXISTS "user";
DROP TABLE IF EXISTS ingredient_cat;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS recipe_cat;
DROP TABLE IF EXISTS recipe; 
DROP TABLE IF EXISTS recipe_ingredient; 
DROP TABLE IF EXISTS recipeBook; 
DROP TABLE IF EXISTS recipeBook_recipe; 

CREATE TABLE IF NOT EXISTS "user" (
	"id"	INTEGER,
	"username"	TEXT NOT NULL UNIQUE,
	"password"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ingredient_cat" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "ingredient" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	"category_id"	INTEGER NOT NULL,
	"r_nourishment"	REAL DEFAULT 0,
	"r_value"	REAL DEFAULT 0,
	"r_human_welfare"	REAL DEFAULT 0,
	"r_animal_welfare"	REAL DEFAULT 0,
	"r_resource_cons"	REAL DEFAULT 0,
	"r_biodiversity"	REAL DEFAULT 0,
	"r_global_warming"	REAL DEFAULT 0,
	FOREIGN KEY("category_id") REFERENCES "ingredient_cat"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "recipe_cat" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "recipe" (
	"id"	INTEGER,
	"author_id"	INTEGER NOT NULL,
	"category_id"	INTEGER NOT NULL,
	"created"	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"title"	TEXT NOT NULL,
	"body"	TEXT NOT NULL,
	FOREIGN KEY("author_id") REFERENCES "user"("id"),
	FOREIGN KEY("category_id") REFERENCES "recipe_cat"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "recipe_ingredient" (
	"recipe_id"	INTEGER NOT NULL,
	"ingredient_id"	INTEGER NOT NULL,
	"amount"	REAL DEFAULT 0,
	"unit"	TEXT NOT NULL,
	FOREIGN KEY("ingredient_id") REFERENCES "ingredient"("id"),
	FOREIGN KEY("recipe_id") REFERENCES "recipe"("id"),
	PRIMARY KEY("recipe_id","ingredient_id")
);
CREATE TABLE IF NOT EXISTS "recipeBook" (
	"id"	INTEGER,
	"author_id"	INTEGER NOT NULL,
	"created"	TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"title"	TEXT NOT NULL,
	"body"	TEXT NOT NULL,
	FOREIGN KEY("author_id") REFERENCES "user"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "recipeBook_recipe" (
	"recipeBook_id"	INTEGER NOT NULL,
	"recipe_id"	INTEGER NOT NULL,
	FOREIGN KEY("recipeBook_id") REFERENCES "recipeBook"("id"),
	FOREIGN KEY("recipe_id") REFERENCES "recipe"("id"),
	PRIMARY KEY("recipeBook_id","recipe_id")
);
INSERT INTO "user" VALUES (1,'guest','8615898112541952359');
INSERT INTO "ingredient_cat" VALUES (1,'Fat');
INSERT INTO "ingredient_cat" VALUES (2,'Potato');
INSERT INTO "ingredient_cat" VALUES (3,'Salt');
INSERT INTO "ingredient_cat" VALUES (4,'Spice');
INSERT INTO "ingredient_cat" VALUES (5,'Milk');
INSERT INTO "ingredient_cat" VALUES (6,'Sugar');
INSERT INTO "ingredient_cat" VALUES (7,'Egg');
INSERT INTO "ingredient_cat" VALUES (8,'Vanilla');
INSERT INTO "ingredient_cat" VALUES (9,'Leavener');
INSERT INTO "ingredient_cat" VALUES (10,'Chocolate');
INSERT INTO "ingredient_cat" VALUES (11,'Nuts');
INSERT INTO "ingredient_cat" VALUES (12,'Flour');
INSERT INTO "ingredient" VALUES (1,'butter-generic',1,3.0,3.5,3.0,2.5,2.5,3.0,2.0);
INSERT INTO "ingredient" VALUES (2,'butter-organic',1,3.0,3.5,3.0,3.0,3.0,3.5,2.0);
INSERT INTO "ingredient" VALUES (3,'butter-vegan',1,3.0,3.5,3.0,3.0,4.5,3.5,4.0);
INSERT INTO "ingredient" VALUES (4,'potatoes-generic',2,4.0,4.0,3.0,3.0,4.5,3.5,4.0);
INSERT INTO "ingredient" VALUES (5,'potatoes-organic',2,4.0,4.0,4.0,4.0,4.5,3.5,4.0);
INSERT INTO "ingredient" VALUES (6,'potatoes-local',2,4.0,4.0,4.5,4.5,4.5,4.5,5.0);
INSERT INTO "ingredient" VALUES (7,'salt-generic',3,4.0,4.0,3.0,3.0,4.5,3.5,4.0);
INSERT INTO "ingredient" VALUES (8,'salt-imported',3,4.0,4.0,4.0,4.0,4.5,3.5,3.0);
INSERT INTO "ingredient" VALUES (9,'pepper-generic',4,4.0,4.0,3.0,3.0,4.5,3.5,4.0);
INSERT INTO "ingredient" VALUES (10,'pepper-organic',4,4.0,4.0,4.0,4.0,4.5,3.5,3.0);
INSERT INTO "ingredient" VALUES (11,'milk-generic',5,3.0,4.0,3.0,2.5,2.5,2.5,1.0);
INSERT INTO "ingredient" VALUES (12,'milk-organic',5,4.0,4.0,4.0,4.0,4.5,3.5,2.0);
INSERT INTO "ingredient" VALUES (13,'milk-soy',5,4.0,3.5,4.0,4.0,4.5,3.5,4.0);
INSERT INTO "ingredient" VALUES (14,'sugar-granulated-generic',6,0.5,2.0,3.0,3.0,2.5,2.0,2.0);
INSERT INTO "ingredient" VALUES (15,'sugar-light-brown-generic',6,0.5,3.0,2.5,3.0,2.5,2.0,2.0);
INSERT INTO "ingredient" VALUES (16,'egg-whole-generic',7,4.0,4.0,3.0,2.0,2.5,2.5,2.5);
INSERT INTO "ingredient" VALUES (17,'vanilla-extract-generic',8,1.0,2.0,3.0,3.0,2.0,2.0,2.0);
INSERT INTO "ingredient" VALUES (18,'baking-soda',9,2.0,3.0,3.0,3.0,3.0,3.0,3.0);
INSERT INTO "ingredient" VALUES (19,'chocolate-chips-semisweet-generic',10,2.0,2.0,3.0,3.0,2.0,2.5,2.0);
INSERT INTO "ingredient" VALUES (20,'walnuts-generic',11,4.0,2.0,4.0,4.0,3.0,3.0,4.0);
INSERT INTO "ingredient" VALUES (21,'flour-all-purpose-unbleached-generic',12,3.0,4.0,4.0,4.0,4.0,2.0,4.0);
INSERT INTO "recipe_cat" VALUES (1,'Breakfast');
INSERT INTO "recipe_cat" VALUES (2,'Lunch');
INSERT INTO "recipe_cat" VALUES (3,'Dinner');
INSERT INTO "recipe_cat" VALUES (4,'Side');
INSERT INTO "recipe_cat" VALUES (5,'Dessert');
INSERT INTO "recipe" VALUES (1,1,4,'2020-12-04 00:19:42','Potato Gratin','Grease an oven safe dish. Thinly slice and layer potatoes. 
        Season with salt and pepper. Add milk and remaining butter. 
        Bake at 425 deg F for 30 min.');
INSERT INTO "recipe" VALUES (2,1,2,'2020-12-04 00:21:10','Chocolate Chip Cookies','Adjust the oven rack to the top third of the oven and preheat to 300F (150C). Line three baking sheets with parchment paper.

Beat the sugars and butters together until smooth. Mix in the egg, vanilla, and baking soda.

Stir together the flour and salt, then mix them into the batter. Mix in the chocolate chips and nuts.

Scoop the cookie dough into 2-tablespoon (5cm) balls and place 8 balls, spaced 4 inches (10cm) apart, on each of the baking sheets.

Bake for 18 minutes, or until pale golden brown. Remove from the oven and cool on a wire rack.');
INSERT INTO "recipe_ingredient" VALUES (1,1,3.0,'Tbs');
INSERT INTO "recipe_ingredient" VALUES (1,4,1.5,'lbs');
INSERT INTO "recipe_ingredient" VALUES (1,7,3.0,'Tbs');
INSERT INTO "recipe_ingredient" VALUES (1,9,3.0,'tsp');
INSERT INTO "recipe_ingredient" VALUES (1,11,1.0,'c');
INSERT INTO "recipe_ingredient" VALUES (2,14,0.5,'c');
INSERT INTO "recipe_ingredient" VALUES (2,15,0.5,'c');
INSERT INTO "recipe_ingredient" VALUES (2,1,8.0,'Tbs');
INSERT INTO "recipe_ingredient" VALUES (2,17,1.0,'tsp');
INSERT INTO "recipe_ingredient" VALUES (2,21,1.25,'c');
INSERT INTO "recipe_ingredient" VALUES (2,7,0.25,'tsp');
INSERT INTO "recipe_ingredient" VALUES (2,19,1.5,'c');
INSERT INTO "recipe_ingredient" VALUES (2,20,1.0,'c');
COMMIT;
