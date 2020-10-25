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

    errors = {}

    form_error = process_form(form_data)
    errors["form_error"] = form_error

    for question in form_data.keys():
        error_response = process_question(form_data=form_data, question=question)
        errors[question] = error_response

    error_bool = []
    for key in errors.keys():
        error_bool.append(errors[key] is None)

    if sum(error_bool) == len(error_bool):
        status = "success"
        message = "The recieved json was successfully stored"
    else:
        status = "error"
        message = f"Their was {len(error_bool) - sum(error_bool)} errors in storing the data. See data to find out more"

    api_response =  {"status": status, "message": message, "data": errors}
    return jsonify(api_response)

