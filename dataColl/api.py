"""api.py - Define API endpoints"""
from flask import Blueprint, jsonify, request
from dataColl.db import query_db, get_db

bp = Blueprint('api', __name__, url_prefix='/api')

@bp.route('/getDDPOs', methods=['GET'])
def getDDPOs():
    """
    Return a JSON list of all registered DDPOs to the client.

    Example output
    --------------
    ```
    [
        {
            "id": 1,
            "name": "Foobar DDPO"
        }
    ]
    ```
    """
    all_ddpos = query_db("SELECT * FROM Organisation;")
    return jsonify([{"id": row["Id"], "name": row["Name"]} for row in all_ddpos])

@bp.route('form', methods=['POST'])
def form():
    form_data = request.get_json(force=True)

    start_date = form_data['time_period']['start']
    end_date = form_data['time_period']['end']
    name_ddpo = form_data['name_ddpo']
    borough_covered_str = ', '.join([str(elem) for elem in form_data['borough_covered']])

    db = get_db()
    db.execute('INSERT into form_data (start_date, end_date, name_ddpo, borough_covered) VALUES (?, ?, ?, ?)',
    (start_date, end_date, name_ddpo, borough_covered_str))
    db.commit()
    return("success")