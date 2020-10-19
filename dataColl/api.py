import json

from dataColl.db import query_db
from flask import Blueprint, g, request

bp = Blueprint('api', __name__, url_prefix='/api')

@bp.route('/all', methods=['GET'])
def all():
    if request.method == 'GET':
        all_data_sql = query_db('SELECT * FROM MOCK_DATA')

        json_data = json.dumps([dict(ix) for ix in all_data_sql])

        return json_data
