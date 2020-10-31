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


def insert_response(form_data):
    """
    Insert the relevant data from `form_data` into the Reponse
    table. 

    Return the Id of the created Response.
    """
    db = get_db()
    org_id_query = 'SELECT Id FROM Organisation WHERE Name = ?'
    org = query_db(org_id_query, (form_data['name_ddpo'],), one=True)
    if org is not None:
        org_id = org['Id']
    else:
        raise ValueError('Organisation does not exist')

    cur = db.execute(
        '''
        INSERT INTO Response (
            Year,
            Quarter,
            OrganisationId,
            CasesReferredToPolice,
            CasesNotReferredToPolice,
            HateCrimeReferrals,
            FreeTextResponse,
            CaseStudyEmotionalImpact,
            CaseStudyPositiveOutcome
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
        ''',
        (
            form_data['year'],
            form_data['quarter'],
            org_id,
            form_data['cases_reported'],
            form_data['cases_not_reported'],
            form_data['hate_crime_cases'],
            form_data['ddpo_short_paragraph'],
            form_data['casestudy_impact'],
            form_data['casestudy_outcome'],
        )
    )
    return cur.lastrowid


def insert_totals(response_id, form_data):
    """
    Insert totals from form data into the relevant tables.
    """
    # Map category tables to the form data
    KEY_TABLE = {
        'ethnicity': 'Ethnicity',
        'cases_not_police_report': 'NoReportReason',
        'cases_related_to': 'CaseRelatedCategory',
        'gender': 'Gender',
        'impairments': 'Impairment',
        'orientation': 'SexualOrientation',
        'referrals': 'ReferralType',
        'sex': 'Sex',
        'support_age': 'SupportAgeCategory',
        'support_provided': 'SupportType'
    }
    db = get_db()

    for key, category_table in KEY_TABLE.items():
        totals = form_data[key]
        total_table = category_table + 'Total'
        id_column = category_table + 'Id'
        for json_key, total in totals.items():
            query = f'''
            INSERT INTO {total_table} (ResponseId, {id_column}, Total)
            SELECT {response_id}, Id, {total}
            FROM {category_table}
            WHERE JSONKey = ?;
            '''
            db.execute(query, (json_key,))


def process_form(form_data: dict) -> tuple:
    """
    Insert form response data into the database.

    Return details of any errors that occur in the process.
    """
    # Insert into Response table
    try:
        response_id = insert_response(form_data)
    except ValueError as e:
        raise e

    # Insert into totals tables
    insert_totals(response_id, form_data)

    # Insert into ResponseBorough
    boroughs = form_data['boroughs_covered']
    borough_insert = '''
    INSERT INTO ResponseBorough (ResponseId, BoroughId)
    SELECT ?, Id
    FROM Borough
    WHERE Name = ?;
    '''

    db = get_db()
    db.executemany(borough_insert, ((response_id, b) for b in boroughs))
    db.commit()


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
