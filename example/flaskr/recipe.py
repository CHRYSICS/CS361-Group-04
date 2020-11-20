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

bp = Blueprint("recipe", __name__,  url_prefix="/recipe")

class Recipe:
    def __init__(self, recipeRow, ingredientRows):
        self.recipeRow = recipeRow
        self.ingredientRows = ingredientRows


@bp.route("/index")
def index():
    """Show all the recipes, most recent first."""
    db = get_db()
    recipes = db.execute(
        "SELECT * FROM recipe r JOIN user u ON r.author_id = u.id \
         ORDER BY created DESC "
    ).fetchall()
    return render_template("recipe/index.html", recipes=recipes)


def get_recipe(id, check_author=True):
    """Create a Recipe by querying the database by recipe id. 

    Checks that the id exists and optionally that the current user is
    the author.

    :param id: id of recipe
    :param check_author: require the current user to be the author
    :return: the recipe and all its ingredients
    :raise 404: if a post with the given id doesn't exist
    :raise 403: if the current user isn't the author
    """
    recipe = (
        get_db()
        .execute(
            "SELECT * FROM recipe r WHERE p.id = ?",
            (id,),
        )
        .fetchone()
    )

    if recipe is None:
        abort(404, f"Post id {id} doesn't exist.")

    if check_author and recipe["author_id"] != g.user["id"]:
        abort(403)

    ingredients = (
        get_db()
        .execute(
            "SELECT recipe_id, ingredient_id, amount, unit, name, category_id \
            FROM recipe_ingredient ri \
            JOIN ingredient i ON i.id=ingredient_id \
            WHERE recipe_id= ?"
            (id,)
        )
    )

    return Recipe(recipe, ingredients)


@bp.route("/create")
@login_required
def create():
    """Create a new recipe for the current user."""
    if request.method != "POST":
        abort(403)



@bp.route("/<int:id>/update")
@login_required
def update(id):
    """Update a recipe if the current user is the author."""
    recipe = get_recipe(id)

    if request.method != "POST":
        abort(403)

    # title = request.form["title"]
    # body = request.form["body"]
    # error = None

    # if not title:
    #     error = "Title is required."

    # if error is not None:
    #     flash(error)
    # else:
    #     db = get_db()
    #     db.execute(
    #         "UPDATE post SET title = ?, body = ? WHERE id = ?", (
    #             title, body, id)
    #     )
    #     db.commit()
    #     return redirect(url_for("blog.index"))


@bp.route("/<int:id>/delete")
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
