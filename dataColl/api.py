"""api.py - Define API endpoints"""
from flask import Blueprint, jsonify
from dataColl.db import query_db

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
