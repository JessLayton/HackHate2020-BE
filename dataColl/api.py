from flask import Blueprint, g, request 
from dataColl.db import get_db
import json

bp = Blueprint('api', __name__, url_prefix='/api')

@bp.route('/all', methods=['GET'])
def all():
    if request.method == 'GET':
        db = get_db()

        all_data_sql = db.execute(
        'SELECT * FROM MOCK_DATA'
        ).fetchall()

        json_data = json.dumps([dict(ix) for ix in all_data_sql])

        return json_data