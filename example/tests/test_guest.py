import pytest
from flask import g
from flask import session

from flaskr.db import get_db


def test_guest(client, auth):
    # test that viewing the page renders without template errors
    assert client.get("/").status_code == 200

    # test that logged in user is redirected successfully
    auth.login()
    assert client.get("/").status_code == 302


def test_accessError(client):
    # test that error page is rendered without issue when redirected to
    assert client.get("/guestRestricted").status_code == 200
