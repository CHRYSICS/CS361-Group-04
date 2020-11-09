-- Initialize the database.
-- Drop any existing data and create empty tables.

DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS post;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL
);

CREATE TABLE post (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (author_id) REFERENCES user (id)
);

DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS ingredient_cat;

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
