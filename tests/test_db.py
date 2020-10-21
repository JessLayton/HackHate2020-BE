"""test_db.py - Test dataColl.db"""
import sqlite3

import pytest
from dataColl.db import get_db, query_db


def test_get_close_db(app):
    """Test db.get_db and the registered handlers."""
    with app.app_context():
        db = get_db()
        assert db is get_db()

    with pytest.raises(sqlite3.ProgrammingError) as e:
        db.execute('SELECT 1')

    assert 'closed' in str(e.value)

def test_init_db_command(runner, monkeypatch):
    """Test init_db"""
    class Recorder(object):
        called = False

    def fake_init_db():
        Recorder.called = True

    monkeypatch.setattr('dataColl.db.init_db', fake_init_db)
    result = runner.invoke(args=['init-db'])
    assert 'Initialized' in result.output
    assert Recorder.called


def test_query_db(app):
    """Test db.query_db"""
    with app.app_context():
        one_result = query_db('SELECT Name FROM Organisation WHERE Id = 1', one=True)
        assert one_result['Name'] == 'Foo DDPO'

        args_result = query_db('SELECT Name FROM Organisation WHERE Id IN (?, ?)', args=(1, 2))
        names = [row['Name'] for row in args_result]
        assert "Foo DDPO" in names
        assert "Bar DDPO" in names
