import pytest

from flaskr.db import get_db


def test_index(client, auth):
    response = client.get("recipe/index")
    assert b"Log In" in response.data
    assert b"Register" in response.data

    auth.login()
    response = client.get("recipe/index")
    assert b"test title" in response.data
    assert b"by test on 2018-01-01" in response.data
    assert b"test\nbody" in response.data


def test_login_required(client):
    response = client.post("recipe/1/delete")
    assert response.headers["Location"] == "http://localhost/guestRestricted"


def test_author_required(app, client, auth):
    # change the recipe author to another user
    with app.app_context():
        db = get_db()
        db.execute("UPDATE recipe SET author_id = 2 WHERE id = 1")
        db.commit()

    auth.login()
    # current user can't modify other user's recipe and is redirected
    assert client.post("recipe/2/delete").status_code == 302


def test_exists_required(client, auth):
    auth.login()
    assert client.post("recipe/3/delete").status_code == 404


def test_create(client, auth, app):
    auth.login()
    assert client.get("recipe/create").status_code == 200

    with app.app_context():
        db = get_db()
        count = db.execute("SELECT COUNT(id) FROM recipe").fetchone()[0]
        assert count == 2

# Waiting for recipe update to take it's final shape before we try to test against it
# def test_update(client, auth, app):
#     auth.login()
#     assert client.get("recipe/2/update").status_code == 200
#     client.post("recipe/2/update", data={"title": "updated", "body": ""})
#
#     with app.app_context():
#         db = get_db()
#         recipe = db.execute("SELECT * FROM recipe WHERE id = 2").fetchone()
#         assert recipe["title"] == "updated"


@pytest.mark.parametrize("path", ("recipe/create", "recipe/1/update"))
def test_create_update_validate(client, auth, path):
    auth.login()
    response = client.post(path, data={"title": "", "body": "", "category": "dessert"})
    assert b"Title is required." in response.data


def test_delete(client, auth, app):
    auth.login()
    response = client.post("recipe/1/delete")
    assert response.headers["Location"] == "http://localhost/recipe/index"

    with app.app_context():
        db = get_db()
        recipe = db.execute("SELECT * FROM recipe WHERE id = 1").fetchone()
        assert recipe is None
