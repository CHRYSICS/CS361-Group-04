from flask import Blueprint
from flask import flash
from flask import g
from flask import redirect
from flask import render_template
from flask import request
from flask import url_for
from werkzeug.exceptions import abort

from flaskr.auth import login_required
from flaskr.db import get_db
from flaskr.ingredient import getAlternativesByRatingAvg
import time
import sqlite3

bp = Blueprint("recipe", __name__, url_prefix="/recipe")


@bp.route("/index", methods=("GET", "POST"))
def index():
    """Show all the recipes, most recent first."""
    db = get_db()

    # if a search query was done, list only recipes that match search and filter provided
    if request.method == "POST":
        searchQuery = "SELECT r.id, r.category_id, title, body, created, author_id, username FROM recipe r" \
                      " JOIN user u ON r.author_id = u.id JOIN recipe_cat rc ON r.category_id = rc.id" \
                      " WHERE " + request.form["filter"] + " LIKE '%" \
                      + request.form["search"] + "%' ORDER BY created DESC"

        # Need to modify the query to account for recipe category
        if request.form["filter"] == "category":
            searchQuery = "SELECT r.id, r.category_id, title, body, created, author_id, username FROM recipe r" \
                          " JOIN user u ON r.author_id = u.id JOIN recipe_cat rc ON r.category_id = rc.id" \
                          " WHERE rc.name LIKE '%" + request.form["search"] + "%' ORDER BY created DESC"

        recipes = db.execute(searchQuery).fetchall()

    # else list all recipes in database
    else:
        recipes = db.execute(
            "SELECT r.id, title, body, created, author_id, username"
            " FROM recipe r JOIN user u ON r.author_id = u.id"
            " ORDER BY created DESC"
        ).fetchall()

    return render_template("recipe/index.html", recipes=recipes)


@bp.route("/<int:id>")
def view_recipe(id):
    """View a recipe and its ingredients."""
    recipe = get_recipe(id)
    ingredients = get_recipe_ingredients(id)
    return render_template("recipe/view.html", recipe=recipe, ingredients=ingredients)


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
            "SELECT recipe_id, ingredient_id, amount, unit, name, category_id \
            r_nourishment, r_value, r_human_welfare, r_animal_welfare,   \
            r_resource_cons, r_biodiversity, r_global_warming\
            FROM recipe_ingredient ri \
            JOIN ingredient i ON i.id=ingredient_id \
            WHERE recipe_id= ?",
            (id,)
        )
    )
    return ingredients


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

    return render_template("recipe/create.html")


@bp.route("/<int:id>/update", methods=("GET", "POST"))
@login_required
def update(id):
    """Update a recipe if the current user is the author."""
    post = get_recipe(id)

    if request.method == "POST":
        title = request.form["title"]
        body = request.form["body"]
        error = None

        if not title:
            error = "Title is required."

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                "UPDATE recipe SET title = ?, body = ? WHERE id = ?", (title, body, id)
            )
            db.commit()
            return redirect(url_for("recipe.index"))

    return render_template("recipe/update.html", post=post)


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
