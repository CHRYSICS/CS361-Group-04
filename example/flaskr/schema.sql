-- Initialize the database.
-- Drop any existing data and create empty tables.

DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS ingredientCat;

CREATE TABLE ingredient (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
  FOREIGN KEY (category_id) REFERENCES ingredientCat (id),
  rNourishment REAL DEFAULT 0,
  rValue REAL DEFAULT 0,
  rHumanWelfare REAL DEFAULT 0,
  rAnimalWelfare REAL DEFAULT 0,
  rResourceCons REAL DEFAULT 0,
  rBiodiversity REAL DEFAULT 0,
  rGlobalWarming REAL DEFAULT 0,
);

CREATE TABLE ingredientCat (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT UNIQUE NOT NULL,
);

