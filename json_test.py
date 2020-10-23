import json

with open("example.json") as f:
    form_data = json.load(f)

## Test POST API JSON
import json
import requests

r = requests.post('http://localhost:5000/api/form', json=form_data)


start_date = form_data['time_period']['start']
end_date = form_data['time_period']['end']
name_ddpo = form_data['name_ddpo']
borough_covered_str = ', '.join([str(elem) for elem in form_data['borough_covered']])

import sqlite3

db_file = "instance/dataColl.sqlite"

db = sqlite3.connect(db_file, detect_types=sqlite3.PARSE_DECLTYPES)
db.row_factory = sqlite3.Row

db.execute('INSERT into form_data (start_date, end_date, name_ddpo, borough_covered) VALUES (?, ?, ?, ?)',
(start_date, end_date, name_ddpo, borough_covered_str))

db.commit()

form = db.execute(
    'SELECT * FROM form_data'
)

for i in form:
    print(list(i))

def process_form():
    start_date = form_data['time_period']['start']
    end_date = form_data['time_period']['end']
    name_ddpo = form_data['name_ddpo']
    borough_covered_str = ', '.join([str(elem) for elem in form_data['borough_covered']])
    