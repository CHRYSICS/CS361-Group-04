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

bp = Blueprint("guest", __name__)

@bp.route("/")
def arrival():
    """Arrival route that either renders portal for non-users or redirects to index"""
    # No user logged, show user the portal to choose to continue as guest or login
    if g.user is None:
        return render_template("guest/portal.html")
    else:
    # User logged, instead redirect to main index page
        return redirect(url_for("blog.index"))

@bp.route("/guestRestricted")
def accessError():
    """Redirect Route for guest restriction on application"""
    return render_template("guest/accessError.html")