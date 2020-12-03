import os

from flask import Flask


def create_app(test_config=None):
    """Create and configure an instance of the Flask application."""
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        # a default secret that should be overridden by instance config
        SECRET_KEY="dev",
        # store the database in the instance folder
        DATABASE=os.path.join(app.instance_path, "flaskr.sqlite"),
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile("config.py", silent=True)
    else:
        # load the test config if passed in
        app.config.update(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # register the database commands
    from flaskr import db

    db.init_app(app)

    # apply the blueprints to the app
    from flaskr import auth, ingredient, recipe, cookbook

    app.register_blueprint(auth.bp)
    app.register_blueprint(ingredient.bp)
    app.register_blueprint(recipe.bp)
    app.register_blueprint(cookbook.bp)

    # Before navigating to the content of this application,
    # direct user to portal.  This gives user the option 
    # to explore the application as either guest or user.
    app.add_url_rule("/", endpoint="auth")

    return app
