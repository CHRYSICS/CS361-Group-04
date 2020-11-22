import functools

from flask import Blueprint, json
from flask import flash
from flask import g
from flask import redirect
from flask import render_template
from flask import request
from flask import session
from flask import url_for
from flaskr.db import get_db

bp = Blueprint("ingredient", __name__, url_prefix="/ingredient")
RATINGS = [ 'r_nourishment',
            'r_value',
            'r_human_welfare',
            'r_animal_welfare',
            'r_resource_cons',
            'r_biodiversity',
            'r_global_warming',]

@bp.route("/<ingredientName>")
def getIngredient(ingredientName):
    """Retrieve an Ingredient by name
    Returns None if Ingredient not present
    """
    if request.method != "GET":
        abort(405)
    
    db = get_db()
    error = None
    
    if not ingredientName:
        error = "Ingredient name is required."
    else:
        ingredient = db.execute("SELECT * FROM ingredient WHERE name = ?", (ingredientName,)).fetchone()
    
    if ingredient is None:
        abort(404, f"Ingredient with name {ingredientName} doesn't exist.")

    return render_template("recipe/ingredient.html", ingredients = [ingredient])


@bp.route("/<ingredientName>/alt")
def getAlternatives(ingredientName):
    """ Retrieve a list of Ingredients that may be substituted for 
    ingredientName
    """
    if request.method != "GET":
        abort(405)

    db = get_db()
    error = None

    if not ingredientName:
        error = "Ingredient name is required."
    else:
        alts = db.execute(
            "SELECT * FROM ingredient WHERE category_id = \
            (SELECT category_id FROM ingredient WHERE name = ?)", (ingredientName,))

    if alts is None:
        abort(404, f"Ingredient with name {ingredientName} has no alternatives.")
    
    return render_template("recipe/ingredient.html", ingredients=alts)


@bp.route("/<ingredientName>/alt/<ratingName>")
def getAlternativesByRating(ingredientName, ratingName):
    """ Retrieve a list of Ingredients that may be subsituted for ingredientName 
    with a higher score on a particular ethical rating
    """
    if request.method != "GET":
        abort(405)

    db = get_db()
    error = None

    if not ingredientName:
        error = "Ingredient name is required."
    else:
        ingredient = db.execute("SELECT * FROM ingredient WHERE name = ?", (ingredientName,)).fetchone()
        equiv = db.execute(
            "SELECT * FROM ingredient WHERE category_id= \
            (SELECT category_id FROM ingredient WHERE name = ?)",  
            (ingredientName,))
        alts = [r for r in equiv if  r[ratingName] > ingredient[ratingName]]

    if alts is None:
        abort(
            404, f"Ingredient with name {ingredientName} has no alternatives.")

    return render_template("recipe/ingredient.html", ingredients=alts)


@bp.route("/<ingredientName>/alt/ravg")
def getAlternativesByRatingAvg(ingredientName):
    """ Retrieve a list of Ingredients that may be subsituted for ingredientName 
    with a higher average of all ratings
    """
    if request.method != "GET":
        abort(405)

    db = get_db()
    error = None

    if not ingredientName:
        error = "Ingredient name is required."
    else:
        db.execute("DROP TABLE IF EXISTS table1")
        db.execute("CREATE TEMP TABLE table1 AS SELECT * FROM \
            (SELECT id, r_avg FROM(SELECT id, category_id, \
                (r_nourishment + r_value + r_human_welfare + r_animal_welfare + \
                r_resource_cons + r_biodiversity + r_global_warming)/7 as r_avg \
                FROM ingredient) \
             WHERE category_id=(SELECT category_id \
                 FROM ingredient WHERE name=?)) \
            INNER JOIN ingredient USING(id)", (ingredientName,))

        alts = db.execute("SELECT * FROM table1 WHERE r_avg > \
                        (SELECT r_avg FROM table1 WHERE name=?)",
                        (ingredientName,))

    if alts is None:
        abort(
            404, f"Ingredient with name {ingredientName} has no alternatives.")

    return render_template("recipe/ingredient.html", ingredients=alts)

