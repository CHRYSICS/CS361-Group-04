from flask import Blueprint
from flask import g
from flask import redirect
from flask import render_template
from flask import url_for

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


