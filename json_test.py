import json
import sqlite3
import requests
from sqlite3 import OperationalError

with open("example.json") as f:
    form_data = json.load(f)

## Test POST API JSON
import requests
k = requests.post('http://localhost:5000/api/form', json=form_data)

def get_db2():
    db_file = "instance/dataColl.sqlite"
    db = sqlite3.connect(db_file, detect_types=sqlite3.PARSE_DECLTYPES)
    db.row_factory = sqlite3.Row
    return db

db = get_db2()

form = db.execute(
    'SELECT * FROM ethnicity'
)

for i in form:
    print(list(i))

def process_form(form_data: dict):
    
    top_level_fields = {}
    top_level_fields["start_date"] = form_data['time_period']['start']
    top_level_fields["end_date"] = form_data['time_period']['end']
    top_level_fields["name_ddpo"] = form_data['name_ddpo']
    top_level_fields["borough_covered"] = ', '.join([str(elem) for elem in form_data['borough_covered']])
    top_level_fields["ddpo_short_paragraph"] = form_data["ddpo_short_paragraph"]
    top_level_fields["casestudy_highlighting_emotional_impact"] = form_data["casestudy_highlighting_emotional_impact"]
    top_level_fields["casestudy_highlighting_positive_outcome"] = form_data["casestudy_highlighting_positive_outcome"]

    fields = top_level_fields.keys()
    question_marks = ", ".join("?" * len(fields))
    column_str = ", ".join([str(elem) for elem in fields])

    sql = f"INSERT into form_data ({column_str}) VALUES ({question_marks})"

    try:
        db = get_db2()
        db.execute(sql, ([top_level_fields[key] for key in fields]))
        db.commit()
        return None
    except Exception as e:
        error = str(e.__class__) + " : " + repr(e)
        return error
        

process_form(form_data)


def process_question(form_data: dict, question: str) -> tuple:

    #if question == "time_period":
    #    return None

    if not isinstance(form_data[question], dict):
        return None
    
    keys = form_data[question].keys()
    question_marks = ", ".join("?" * len(keys))
    keys_str = ", ".join([str(elem) for elem in form_data[question].keys()])

    sql = f"INSERT into {question} ({keys_str}) VALUES ({question_marks})"

    try:
        db = get_db2()
        db.execute(sql, ([form_data[question][key] for key in keys]))
        db.commit()
        return None
    except OperationalError as e:
        error = str(e.__class__) + " : " + repr(e)
        return error



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
    message = "Their was an error in storing the data. See data to find out more"


api_response =  {"status": status, "message": message, "data": errors}


json.dumps(api_response)