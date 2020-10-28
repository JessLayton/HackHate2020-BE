"""api.py - Define API endpoints"""
import sqlite3
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
    {
        "status": "success",
        "data": [
            {
                "id": 1,
                "name": "Foobar DDPO"
            }
        ]
    {
    ```
    """
    try:
        all_ddpos = query_db("SELECT * FROM Organisation;")
        return jsonify({
            "status": "success",
            "data": [{"id": row["Id"], "name": row["Name"]} for row in all_ddpos]
        })
    except sqlite3.Error as e:
        return jsonify({"status": "error", "message": e.args[0]})


@bp.route('/addDDPO', methods=['POST'])
def addDDPO():
    """
    Register a new DDPO.

    Example input
    --------------
    ```
    {
        "name": "Foobar DDPO"
    }
    ```

    Example output
    --------------
    ```
    {
        "status": "success",
        "data": {
            "id": 1,
            "name": "Foobar DDPO"
        }
    }
    ```
    """
    try:
        json = request.get_json()
        # Check if required fields exist
        if json is None or "name" not in json:
            return jsonify({"status": "fail", "data": {"name": "name is required"}})

        # Check for data type error
        if not isinstance(json['name'], str):
            # name must be string
            return jsonify({"status": "fail", "data": {"name": "name must be a string"}})

        # Do the insert
        query_db("INSERT INTO Organisation (Name) VAlUES (?);", (json["name"],))
        get_db().commit()

        # Get the data back out for returning
        query = "SELECT Id, Name FROM Organisation WHERE Name = ?"
        row = query_db(query, (json["name"],), one=True)
        return jsonify({
            "status": "success",
            "data": {"id": row["Id"], "name": row["Name"]}
        })
    except sqlite3.Error as e:
        return jsonify({"status": "error", "message": e.args[0]})
 

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
  

@bp.route('/updateDDPO', methods=['PUT'])
def updateDDPO():
    """
    Update an existing DDPO.

    Example input
    --------------
    ```
    {
        "id": 1,
        "name": "Flob DDPO"
    }
    ```

    Example output
    --------------
    ```
    {
        "status": "success",
        "data": {
            "id": 1,
            "name": "Flob DDPO"
        }
    }
    ```
    """
    try:
        json = request.get_json()
        # Check if required fields exist
        missing_error = False
        if json is None:
            missing_error = True
            data = {"name": "name is required", "id": "id is required"}
        else:
            data = {}
            if "name" not in json:
                missing_error = True
                data["name"] = "name is required"
            else:
                data["name"] = json["name"]
            if "id" not in json:
                missing_error = True
                data["id"] = "id is required"
            else:
                data["id"] = json["id"]
        if missing_error:
            return jsonify({"status": "fail", "data": data})

        # Check for data type errors
        type_error = False
        data = {'name': json['name'], 'id': json['id']}
        if not isinstance(json['name'], str):
            type_error = True
            data['name'] = 'name must be a string'
        if not isinstance(json['id'], int):
            type_error = True
            data['id'] = 'id must be an integer'
        if type_error:
            return jsonify({"status": "fail", "data": data})

        # Do the update - does nothing if DDPO does not exist
        query_db("UPDATE Organisation SET Name = ? WHERE Id = ?", (json["name"], json["id"]))
        get_db().commit()

        # Get the data back out for returning
        query = "SELECT Id, Name FROM Organisation WHERE Id = ?"
        updated_ddpo = query_db(query, (json["id"],), one=True)
        # Check if the DDPO to be updated actually exists
        if updated_ddpo is None:
            return jsonify({
                "status": "fail",
                "data": {"id": "id does not match an existing DDPO", "name": None}
            })

        return jsonify({
            "status": "success",
            "data": {"id": updated_ddpo["Id"], "name": updated_ddpo["Name"]}
        })
    except sqlite3.Error as e:
        return jsonify({"status": "error", "message": e.args[0]})


@bp.route('/deleteDDPO', methods=['DELETE'])
def deleteDDPO():
    """
    Delete an existing DDPO.

    Example input
    --------------
    ```
    {
        "id": 1,
    }
    ```

    Example output
    --------------
    ```
    {
        "status": "success",
        "data": null
    }
    ```
    """
    try:
        json = request.get_json()
        # Check if required fields exist
        if json is None or "id" not in json:
            return jsonify({"status": "fail", "data": {"id": "id is required"}})


        # Check for data type errors
        if not isinstance(json['id'], int):
            return jsonify({
                "status": "fail",
                "data": {
                    "id": "id must be an integer"
                }
            })

        # Check if the DDPO to be updated actually exists
        query = "SELECT Id, Name FROM Organisation WHERE Id = ?"
        ddpo = query_db(query, (json["id"],), one=True)
        if ddpo is None:
            return jsonify({
                "status": "fail",
                "data": {"id": "id does not match an existing DDPO"}
            })

        # Do the delete - does nothing if DDPO does not exist
        query_db("DELETE FROM Organisation WHERE Id = ?", (json["id"],))
        get_db().commit()

        return jsonify({
            "status": "success",
            "data": None
        })
    except sqlite3.Error as e:
        return jsonify({"status": "error", "message": e.args[0]})