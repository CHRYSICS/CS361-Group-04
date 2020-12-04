-- Initialize the database.
-- Drop any existing data and create empty tables.

DROP TABLE IF EXISTS "user";
DROP TABLE IF EXISTS ingredient_cat;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS recipe_cat;
DROP TABLE IF EXISTS recipe; 
DROP TABLE IF EXISTS recipe_ingredient; 
DROP TABLE IF EXISTS recipeBook; 
DROP TABLE IF EXISTS recipeBook_recipe; 


CREATE TABLE "user" (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL
);

-- Insert 'guest' user in order to use it for creating new recipes for users without an account
INSERT INTO user (username, password) VALUES ('guest', random());

CREATE TABLE ingredient_cat (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE ingredient (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  category_id INTEGER NOT NULL,
  r_nourishment REAL DEFAULT 0,
  r_value REAL DEFAULT 0,
  r_human_welfare REAL DEFAULT 0,
  r_animal_welfare REAL DEFAULT 0,
  r_resource_cons REAL DEFAULT 0,
  r_biodiversity REAL DEFAULT 0,
  r_global_warming REAL DEFAULT 0,
  FOREIGN KEY (category_id) REFERENCES ingredient_cat (id)
);

CREATE TABLE recipe_cat (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE recipe (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES recipe_cat (id),
  FOREIGN KEY (author_id) REFERENCES user (id)
);

CREATE TABLE recipe_ingredient (
  recipe_id INTEGER NOT NULL,
  ingredient_id INTEGER NOT NULL,
  amount REAL DEFAULT 0, 
  unit TEXT NOT NULL, 
  PRIMARY KEY(recipe_id, ingredient_id),
  FOREIGN KEY (recipe_id) REFERENCES recipe (id),
  FOREIGN KEY (ingredient_id) REFERENCES ingredient(id)
);

CREATE TABLE recipeBook (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (author_id) REFERENCES user (id)
);

CREATE TABLE recipeBook_recipe (
  recipeBook_id INTEGER NOT NULL,
  recipe_id INTEGER NOT NULL,
  PRIMARY KEY(recipeBook_id, recipe_id),
  FOREIGN KEY (recipeBook_id) REFERENCES recipeBook (id),
  FOREIGN KEY (recipe_id) REFERENCES recipe (id)
);

