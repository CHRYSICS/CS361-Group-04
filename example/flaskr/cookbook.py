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


@bp.route("/add_recipe/<int:recipe_id>", methods=("GET",))
def save_recipe(recipe_id):
    """Save recipe to current user's recipe book."""
    error = None

    if g.user is None:
        error = "Must Be a User to Save to Recipe Book"
    if error is not None:
        flash(error, "error")
    else:
        db = get_db()

        db.execute(
            "INSERT INTO recipeBook_recipe (recipeBook_id, recipe_id) \
            VALUES ( (SELECT id FROM recipeBook WHERE author_id = ?), ?)", 
            (g.user["id"], recipe_id,)
        )
        db.commit()
        flash(error, "Added to recipe book!")
        return redirect(url_for("recipe.index"))

    return redirect(url_for("recipe.index"))


@bp.route("/<int:id>/delete", methods=("POST",))
@login_required
def delete(id):
    """Delete a recipe from cookbook.

    Ensures that the recipe exists and that the logged in user is the
    author of the recipe.
    """
    get_recipe(id)
    db = get_db()
    db.execute("DELETE FROM recipe WHERE id = ?", (id,))
    db.commit()
    return redirect(url_for("recipe.index"))
