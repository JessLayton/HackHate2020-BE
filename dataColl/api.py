"""api.py - Define API endpoints"""
from flask import Blueprint, jsonify, request
from dataColl.db import query_db, get_db, process_form, process_question

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

    process_form(form_data)

    for question in form_data.keys():
        process_question(form_data=form_data, question=question)

    return("done")