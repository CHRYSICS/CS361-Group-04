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
from werkzeug.security import check_password_hash
from werkzeug.security import generate_password_hash

bp = Blueprint("auth", __name__)


def login_required(view):
    """View decorator that redirects anonymous users to the login page."""

    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for("auth.accessError"))

        return view(**kwargs)

    return wrapped_view


@bp.before_app_request
def load_logged_in_user():
    """If a user id is stored in the session, load the user object from
    the database into ``g.user``."""
    user_id = session.get("user_id")

    if user_id is None:
        g.user = None
    else:
        g.user = (
            get_db().execute("SELECT * FROM user WHERE id = ?", (user_id,)).fetchone()
        )

@bp.route("/")
def arrival():
    """Arrival route that either renders portal for non-users or redirects to index"""
    if g.user is None:
        return render_template("auth/portal.html")
    else:
        return redirect(url_for("recipe.index"))


@bp.route("/register", methods=("GET", "POST"))
def register():
    """Register a new user.

    Validates that the username is not already taken. Hashes the
    password for security.
    """
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        db = get_db()
        error = None

        if not username:
            error = "Username is required."
        elif not password:
            error = "Password is required."
        elif (
            db.execute("SELECT id FROM user WHERE username = ?", (username,)).fetchone()
            is not None
        ):
            error = f"User {username} is already registered."

        if error is None:
            # the name is available, store it in the database and go to
            # the login page
            db.execute(
                "INSERT INTO user (username, password) VALUES (?, ?)",
                (username, generate_password_hash(password)),
            )
            # get the generated user id
            userId = db.execute(
                "SELECT id FROM user WHERE username = ?", 
                (username,),
            ).fetchone()['id']
            # create a default recipeBook for the new user
            db.execute(
                "INSERT INTO recipeBook (author_id, title, body)  \
                VALUES (?, ?, ?)", 
                (userId, f"{username}'s Recipe Book", "My favorite ethical recipes."),
            )
            db.commit()

            # create successful registration response object
            response = json.dumps({
                "category": "info",
                "message": "User account successfully registered!"
            })

            return redirect(url_for("auth.login", response=response))

        flash(error, "error")

    return render_template("auth/register.html")


@bp.route("/login", methods=("GET", "POST"))
def login():
    """Log in a registered user by adding the user id to the session."""
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        db = get_db()
        error = None
        user = db.execute(
            "SELECT * FROM user WHERE username = ?", (username,)
        ).fetchone()

        if user is None:
            error = "Incorrect username."
        elif not check_password_hash(user["password"], password):
            error = "Incorrect password."

        if error is None:
            # store the user id in a new session and return to the index
            session.clear()
            session["user_id"] = user["id"]
            return redirect(url_for("recipe.index"))

        flash(error, "error")

    if request.args:
        response = json.loads(request.args['response'])
        flash(response["message"], response["category"])

    return render_template("auth/login.html")


@bp.route("/logout")
def logout():
    """Clear the current session, including the stored user id."""
    session.clear()
    return redirect(url_for("portal"))

@bp.route("/guestRestricted")
def accessError():
    """Redirect Route for guest restriction on application"""
    return render_template("auth/accessError.html")
