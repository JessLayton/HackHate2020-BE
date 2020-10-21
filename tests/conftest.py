"""conftest.py - Configure test fixtures"""
import os
import tempfile

import pytest
from dataColl import create_app
from dataColl.db import get_db, init_db

with open(os.path.join(os.path.dirname(__file__), 'data.sql'), 'rb') as f:
    _data_sql = f.read().decode('utf8')


@pytest.fixture
def app():
    """Test app"""
    db_fd, db_path = tempfile.mkstemp()

    application = create_app({
        'TESTING': True,
        'DATABASE': db_path,
    })

    with application.app_context():
        init_db()
        get_db().executescript(_data_sql)

    yield application

    os.close(db_fd)
    os.unlink(db_path)


@pytest.fixture
def client(app):
    """Test client"""
    return app.test_client()


@pytest.fixture
def runner(app):
    """Test runner"""
    return app.test_cli_runner()
