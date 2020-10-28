"""db.py - Database helper functions."""
import sqlite3
from sqlite3 import OperationalError

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


def process_form(form_data: dict) -> tuple:
    
    top_level_fields = {}
    top_level_fields["start_date"] = form_data['time_period']['start']
    top_level_fields["end_date"] = form_data['time_period']['end']
    top_level_fields["name_ddpo"] = form_data['name_ddpo']
    top_level_fields["borough_covered"] = ', '.join([str(elem) for elem in form_data['borough_covered']])
    top_level_fields["ddpo_short_paragraph"] = form_data["ddpo_short_paragraph"]
    top_level_fields["casestudy_highlighting_emotional_impact"] = form_data["casestudy_highlighting_emotional_impact"]
    top_level_fields["casestudy_highlighting_positive_outcome"] = form_data["casestudy_highlighting_positive_outcome"]

    fields = top_level_fields.keys()
    question_marks = ", ".join("?" * len(fields))
    column_str = ", ".join([str(elem) for elem in fields])

    sql = f"INSERT into form_data ({column_str}) VALUES ({question_marks})"

    try:
        db = get_db()
        db.execute(sql, ([top_level_fields[key] for key in fields]))
        db.commit()
        return None
    except Exception as e:
        error = str(e.__class__) + " : " + repr(e)
        return error
        

def process_question(form_data: dict, question: str) -> tuple:
    """

    """

    #if question == "time_period":
     #   return None
    if not isinstance(form_data[question], dict):
        return None
    
    keys = form_data[question].keys()
    question_marks = ", ".join("?" * len(keys))
    keys_str = ", ".join([str(elem) for elem in form_data[question].keys()])

    sql = f"INSERT into {question} ({keys_str}) VALUES ({question_marks})"

    try:
        db = get_db()
        db.execute(sql, ([form_data[question][key] for key in keys]))
        db.commit()
        return None
    except OperationalError as e:
        error = str(e.__class__) + " : " + repr(e)
        return error


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
