from flask import Blueprint
from flask import flash
from flask import g
from flask import redirect
from flask import render_template
from flask import request
from flask import url_for
from flask import send_from_directory

from werkzeug.exceptions import abort

from flaskr.auth import login_required
from flaskr.db import get_db
from flaskr.ingredient import getAlternativesByRatingAvg
from flaskr.ingredient import getAlternatives
import time
import sqlite3

bp = Blueprint("recipe", __name__, url_prefix="/recipe")


@bp.route("/index", methods=("GET", "POST"))
def index():
    """Shows all recipes, POST method filters recipes shown, ordered most recent first."""
    db = get_db()
    sqlQuery = "SELECT * FROM recipe r " \
                    "JOIN user u ON r.author_id = u.id JOIN recipe_cat rc ON r.category_id = rc.id "
    
    if request.method == "POST":
        sqlQuery += "WHERE " + request.form["filter"] + " LIKE '%" + request.form["search"] + "%' " 

        if request.form["category"] != 'NULL':
            sqlQuery += "AND rc.name = '" + request.form["category"] + "' "
    
    sqlQuery += "ORDER BY created DESC"

    recipes = db.execute(sqlQuery).fetchall()
    return render_template("recipe/index.html", recipes=recipes)


@bp.route("/<int:id>")
def view_recipe(id):
    """View a recipe and its ingredients."""
    recipe = get_recipe(id)
    ingredients = get_recipe_ingredients(id)
    return render_template("recipe/view.html", recipe=recipe, ingredients=ingredients)

@bp.route("/<int:id>/static/<path:path>")
def static_dir(id, path):
    return send_from_directory("static", path)


def get_recipe(id):
    recipe = (
        get_db()
            .execute(
            "SELECT * FROM recipe r WHERE r.id = ?",
            (id,),
        )
            .fetchone()
    )
    if recipe is None:
        abort(404, f"Recipe id {id} doesn't exist.")

    recipe = (get_db()
        .execute(
        "SELECT * FROM recipe r JOIN user u ON r.author_id = u.id \
                WHERE r.id = ?",
        (id,),
    )
    ).fetchone()

    return recipe

def get_recipe_ingredients(id):
    """Get a list of ingredients in a Recipe querying the database by recipe id."""
    recipe = get_recipe(id)
    ingredients = (
        get_db()
            .execute(
            "SELECT *\
            FROM recipe_ingredient ri \
            JOIN ingredient i ON i.id=ingredient_id \
            WHERE recipe_id= ?",
            (id,)
        )
    )
    return ingredients

def get_ingredients_data(id):
    """Get a list of ingredients in a Recipe querying the database by recipe id."""
    recipe = get_recipe(id)
    ingredients = (
        get_db()
            .execute(
            "SELECT * FROM ingredient WHERE id IN \
            (SELECT ingredient_id\
            FROM recipe_ingredient ri \
            JOIN ingredient i ON i.id=ingredient_id \
            WHERE recipe_id= ?)",
            (id,)
        )
    )
    return ingredients

def get_recipe_alts(id):
    """Get a list of ingredients in a Recipe querying the database by recipe id."""
    recipe = get_recipe(id)
    alts = (
        get_db()
            .execute(
            "SELECT * FROM ingredient WHERE category_id IN \
            (SELECT category_id \
            FROM recipe_ingredient ri \
            JOIN ingredient i ON i.id=ingredient_id \
            WHERE recipe_id= ?)",
            (id,)
        )
    )
    return alts

@bp.route("/create", methods=("GET", "POST"))
def create():
    """Create a new recipe for the current user."""
    if request.method == "POST":
        title = request.form["title"]
        body = request.form["body"]
        recipe_category = request.form["category"]
        error = None

        if not title:
            error = "Title is required."

        if not recipe_category:
            error = "Recipe category is required"

        if error is not None:
            flash(error)
        else:
            db = get_db()
            if g.user is None:
                db.execute(
                    "INSERT INTO recipe (author_id, category_id, title, body) VALUES (?, ?, ?, ?)",
                    (1, recipe_category, title, body),
                )
                db.commit()
            else:
                db.execute(
                    "INSERT INTO recipe (author_id, category_id, title, body) VALUES (?, ?, ?, ?)",
                    (g.user["id"], recipe_category, title, body),
                )
                db.commit()
            return redirect(url_for("recipe.index"))
    # method is a GET, return the create page with associated context
    db = get_db()
    categories = db.execute("SELECT DISTINCT id, name FROM recipe_cat")
    ingredients = db.execute("SELECT DISTINCT id, name FROM ingredient")

    return render_template("recipe/create.html", categories = categories, ingredients = ingredients)


@bp.route("/<int:id>/update", methods=("GET", "POST"))
def update(id):
    """Update a recipe if the current user is the author."""
    post = get_recipe(id)
    recipe_ingredients = get_recipe_ingredients(id)
    alts = get_recipe_alts(id)
    if request.method == "POST":
        title = request.form["title"]
        body = request.form["body"]
        error = None

        if not title:
            error = "Title is required."
        if g.user is None:
            error = "Must Be a User to Save to Recipe Book"
        if error is not None:
            flash(error, "error")
        else:
            db = get_db()
            db.execute(
                "UPDATE recipe SET title = ?, body = ? WHERE id = ?", (title, body, id)
            )
            db.commit()
            return redirect(url_for("recipe.index"))

    return render_template("recipe/update.html", post=post, alts = alts, recipe_ingredients = recipe_ingredients)


@bp.route("/<int:id>/delete", methods=("POST",))
@login_required
def delete(id):
    """Delete a recipe.

    Ensures that the recipe exists and that the logged in user is the
    author of the recipe.
    """
    get_recipe(id)
    db = get_db()
    db.execute("DELETE FROM recipe WHERE id = ?", (id,))
    db.commit()
    return redirect(url_for("recipe.index"))
