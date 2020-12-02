import pytest

from flaskr.db import get_db


def test_method_not_allowed(client):
    assert client.post("ingredient/butter-generic").status_code == 405


def test_ingredient_not_found(client):
    # test no ingredient found
    response = client.get("ingredient/test")
    assert response.status == "404 NOT FOUND"
    assert b"Ingredient with name test doesn't exist." in response.data


def test_get_ingedient(client, auth):
    response = client.get("ingredient/butter-generic")
    assert b"Log In" in response.data
    assert b"Register" in response.data

    auth.login()
    response = client.get("ingredient/butter-generic")
    assert b"butter-generic" in response.data
    assert b"Alternatives for" in response.data

    # test no ingredient name given
    assert client.get("ingredient/").status_code == 404
