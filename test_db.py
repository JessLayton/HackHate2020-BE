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

db.execute('INSERT into form_data (start_date, end_date, name_ddpo, borough_covered) VALUES ("2020-01-01", "2020-01-02", "foo", "bar" )')
db.commit()

form = db.execute(
    'SELECT * FROM form_data'
)

for i in form:
    print(list(i))

