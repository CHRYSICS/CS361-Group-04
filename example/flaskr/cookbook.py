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
from flaskr.recipe import get_recipe, get_recipe_ingredients
import time
import sqlite3

bp = Blueprint("cookbook", __name__, url_prefix="/cookbook")


@bp.route("/index", methods=("GET", "POST"))
@login_required
def index():
    """Shows all recipes in a user's recipe book, POST method filters recipes shown, ordered most recent first."""
    if g.user is None:
        error = "Must Be a User to Have a Recipe Book"
    
    db = get_db()

    sqlQuery = "SELECT * FROM recipe r JOIN recipeBook_recipe rbr ON \
            rbr.recipeBook_id = (SELECT id FROM recipeBook WHERE author_id= ? ) \
                JOIN recipe_cat rc ON r.category_id = rc.id "

    if request.method == "POST":
        sqlQuery += "WHERE " + \
            request.form["filter"] + " LIKE '%" + \
            request.form["search"] + "%' "

        if request.form["category"] != 'NULL':
            sqlQuery += "AND rc.name = '" + request.form["category"] + "' "

    sqlQuery += "ORDER BY created DESC"

    recipes = db.execute(sqlQuery, (g.user["id"],)).fetchall()
    return render_template("cookbook/index.html", recipes=recipes)

@bp.route("/add_recipe/<int:recipe_id>", methods=("GET",))
@login_required
def save_recipe(recipe_id):
    """Save recipe to current user's recipe book."""
    error = None

    if g.user is None:
        error = "Must Be a User to Save to Recipe Book"
    
    db = get_db()
    if (
        db.execute("SELECT * FROM recipeBook_recipe WHERE \
            recipeBook_id = (SELECT id FROM recipeBook WHERE author_id = ?)\
                     AND recipe_id = ?",
                   (g.user["id"],recipe_id)).fetchone()
        is not None
    ):
        error = f"This recipe is already saved to your Recipe Book."

    if error is not None:
        flash(error, "error")
    else:
        get_recipe(recipe_id)
        db.execute(
            "INSERT INTO recipeBook_recipe (recipeBook_id, recipe_id) \
            VALUES ( (SELECT id FROM recipeBook WHERE author_id = ?), ?)", 
            (g.user["id"], recipe_id,)
        )
        db.commit()
        error = "Added to recipe book!"
        flash(error, "info")
        return redirect(url_for("recipe.index"))

    return redirect(url_for("recipe.index"))


@bp.route("/delete_recipe/<int:recipe_id>", methods=("GET",))
@login_required
def delete(recipe_id):
    """Delete a recipe from the logged in user's cookbook.
    """
    error = None

    if g.user is None:
        error = "Must Be a User to Delete From Recipe Book"
    if error is not None:
        flash(error, "error")
    else:
        get_recipe(recipe_id)
        db = get_db()
        db.execute(
            "DELETE FROM recipeBook_recipe \
            WHERE recipeBook_id = \
            (SELECT id FROM recipeBook WHERE author_id = ?) AND recipe_id = ?)",
            (g.user["id"], recipe_id,)
        ).fetch_one()

        db.commit()
        flash(error, "Added to recipe book!")
        return redirect(url_for("recipe.index"))

    return redirect(url_for("recipe.index"))
