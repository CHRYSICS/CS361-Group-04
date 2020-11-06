"""
Run this script to populate the database with dummy data.
Make sure to initialize the database first with:
$ flask init_db 
Adapted from https://docs.python.org/3/library/sqlite3.html
"""
import sqlite3
from flask import current_app
from . db import get_db

# get database instance
db = get_db()
c = db.cursor
# insert some ingredient categories
c.execute("INSERT INTO ingredient_cat VALUES ('FAT', 'POTATO', 'SALT', 'SPICE', 'MILK')"

# insert some ingredients
# ingredient fields for reference: 
    #   name TEXT UNIQUE NOT NULL,
    #   category_id INTEGER NOT NULL,
    #   r_nourishment REAL DEFAULT 0,
    #   r_value REAL DEFAULT 0,
    #   r_human_welfare REAL DEFAULT 0,
    #   r_animal_welfare REAL DEFAULT 0,
    #   r_resource_cons REAL DEFAULT 0,
    #   r_biodiversity REAL DEFAULT 0,
    #   r_global_warming REAL DEFAULT 0,
c.execute("INSERT INTO ingredient VALUES ('butter-generic', 1, 3.0, 3.5, 3.0, 2.5, 2.5, 3.0, 2.0)")
c.execute("INSERT INTO ingredient VALUES ('butter-organic', 1, 3.0, 3.5, 3.0, 3.0, 3.0, 3.5, 2.0)")
c.execute("INSERT INTO ingredient VALUES ('butter-vegan', 1, 3.0, 3.5, 3.0, 3.0, 4.5, 3.5, 4.0)")

c.execute("INSERT INTO ingredient VALUES ('potatoes-generic', 2, 4.0, 4.0, 3.0, 3.0, 4.5, 3.5, 4.0)")
c.execute("INSERT INTO ingredient VALUES ('potatoes-organic', 2, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 4.0)")
c.execute("INSERT INTO ingredient VALUES ('potatoes-local', 2, 4.0, 4.0, 4.5, 4.5, 4.5, 4.5, 5.0)")

c.execute("INSERT INTO ingredient VALUES ('salt-generic', 3, 4.0, 4.0, 3.0, 3.0, 4.5, 3.5, 4.0)")
c.execute("INSERT INTO ingredient VALUES ('salt-imported', 3, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 3.0)")

c.execute("INSERT INTO ingredient VALUES ('pepper-generic', 4, 4.0, 4.0, 3.0, 3.0, 4.5, 3.5, 4.0)")
c.execute("INSERT INTO ingredient VALUES ('pepper-organic', 4, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 3.0)")

c.execute("INSERT INTO ingredient VALUES ('milk-generic', 5, 4.0, 4.0, 3.0, 3.0, 4.5, 3.5, 4.0)")
c.execute("INSERT INTO ingredient VALUES ('milk-organic', 5, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 3.0)")       
c.execute("INSERT INTO ingredient VALUES ('milk-soy', 5, 4.0, 4.0, 4.0, 4.0, 4.5, 3.5, 3.0)")       

# Save (commit) the changes
conn.commit()

# We can also close the connection if we are done with it.
# Just be sure any changes have been committed or they will be lost.
conn.close()
