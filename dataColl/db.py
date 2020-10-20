"""db.py - Database helper functions."""
import sqlite3

import click
from flask import current_app, g
from flask.cli import with_appcontext


def get_db():
    """
    Return the database connection from the global object `g`. If no such
    connection exists, create it and store it in `g`.
    """
    if 'db' not in g:
        g.db = sqlite3.connect(
            current_app.config['DATABASE'],
            detect_types=sqlite3.PARSE_DECLTYPES
        )
        g.db.row_factory = sqlite3.Row

    return g.db


def close_db(e=None):
    """
    Close the database connection stored in `g`, if one exists.
    """
    db = g.pop('db', None)

    if db is not None:
        db.close()


def init_app(app):
    """
    Register database-related functions with the given app.
    """
    app.teardown_appcontext(close_db)
    app.cli.add_command(init_db_command)


def query_db(query, args=(), one=False):
    """
    Return the results of `query` with the arguments `args`.

    If `one` is False, return a generator which yields each row returned
    by the query in turn. If `one` is True, return only the first row.
    """
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv


def init_db():
    """
    Initialise the database by running the SQL contained in `schema.sql`.
    """
    db = get_db()

    with current_app.open_resource('schema.sql') as f:
        db.executescript(f.read().decode('utf8'))


@click.command('init-db')
@with_appcontext
def init_db_command():
    """Clear the existing data and create new tables."""
    init_db()
    click.echo('Initialized the database.')
