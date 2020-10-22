import sqlite3

db_file = "instance/dataColl.sqlite"

db = sqlite3.connect(db_file, detect_types=sqlite3.PARSE_DECLTYPES)
db.row_factory = sqlite3.Row

weights_sql = db.execute(
        'SELECT * FROM MOCK_DATA'
    ).fetchall()


test = []

for i in weights_sql:
    test.append(tuple(i))


## form data

form = db.execute(
    'SELECT * FROM form_data'
)