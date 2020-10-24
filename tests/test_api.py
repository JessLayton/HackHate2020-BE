from dataColl.db import get_db
"""test_api.py - Test API endpoints"""


def test_getDDPOs_success(client):
    """Test successful use of getDDPOs endpoint."""
    response = client.get('/api/getDDPOs')
    json = response.get_json()
    assert json['status'] == 'success'
    assert json['data'] == [
        {'id': 1, 'name': 'Foo DDPO'},
        {'id': 2, 'name': 'Bar DDPO'},
        {'id': 3, 'name': 'Baz DDPO'}
    ]


def test_getDDPOs_error(client, app):
    """Test getDDPOs endpoint error handling."""
    # Drop table to induce error
    with app.test_request_context():
        db = get_db()
        db.execute('DROP TABLE Organisation;')
    response = client.get('/api/getDDPOs')
    json = response.get_json()
    assert json['status'] == 'error'
    assert len(json.keys()) == 2
    assert 'message' in json


def test_addDDPO_success(client):
    """Test successful use of addDDPO endpoint."""
    body = {
        "name": "Bing DDPO"
    }
    response = client.post('/api/addDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'success'
    assert json['data'] == {
        "id": 4,
        "name": "Bing DDPO"
    }


def test_addDDPO_fail_wrong_name_type(client):
    """Test passing non-strings as name attributes to addDDPO."""
    body = {
        "name": 3
    }
    response = client.post('/api/addDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json['data'] == {
        "name": "name must be a string"
    }


def test_addDDPO_error(client, app):
    """Test addDDPO endpoint error handling."""
    # Drop table to induce error
    with app.test_request_context():
        db = get_db()
        db.execute('DROP TABLE Organisation;')

    body = {
        "name": "Bing DDPO"
    }
    response = client.post('/api/addDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'error'
    assert len(json.keys()) == 2
    assert 'message' in json


def test_updateDDPO_success(client):
    """Test successful use of updateDDPOs endpoint."""
    body = {
        "id": 2,
        "name": "Bish DDPO"
    }
    response = client.put('/api/updateDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'success'
    assert json["data"] == {
        "id": 2,
        "name": "Bish DDPO"
    }


def test_updateDDPO_fail_wrong_id_type(client):
    """Test passing non-integers as id attributes to addDDPO."""
    body = {
        "id": "2",
        "name": "Bish DDPO"
    }
    response = client.put('/api/updateDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json["data"] == {
        "id": "id must be an integer",
        "name": "Bish DDPO"
    }


def test_updateDDPO_fail_wrong_name_type(client):
    """Test passing non-strings as name attributes to updateDDPO."""
    body = {
        "id": 1,
        "name": 2
    }
    response = client.put('/api/updateDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json["data"] == {
        "id": 1,
        "name": "name must be a string"
    }


def test_updateDDPO_fail_both_wrong_type(client):
    """Test passing attributes of wrong type to updateDDPO."""
    body = {
        "id": "1",
        "name": 2
    }
    response = client.put('/api/updateDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json["data"] == {
        "id": "id must be an integer",
        "name": "name must be a string"
    }


def test_updateDDPO_fail_nonexistent_ddpo(client):
    """Test passing id of nonexistent DDPO to updateDDPO."""
    body = {
        "id": 99,
        "name": "Foo DDPO"
    }
    response = client.put('/api/updateDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json["data"] == {
        "id": "id does not match an existing DDPO",
        "name": None
    }


def test_updateDDPO_fail_missing_body(client):
    """Test missing body from request to updateDDPO."""
    response = client.put('/api/updateDDPO')
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json["data"] == {
        "name": "name is required",
        "id": "id is required"
    }


def test_updateDDPO_fail_missing_id_and_name(client):
    """Test missing body from request to updateDDPO."""
    response = client.put('/api/updateDDPO', json={})
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json["data"] == {
        "name": "name is required",
        "id": "id is required"
    }


def test_updateDDPO_fail_missing_id(client):
    """Test missing id from request to updateDDPO."""
    response = client.put('/api/updateDDPO', json={"name": "Test DDPO"})
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json["data"] == {
        "name": "Test DDPO",
        "id": "id is required"
    }


def test_updateDDPO_fail_missing_name(client):
    """Test missing name from request to updateDDPO."""
    response = client.put('/api/updateDDPO', json={"id": 6})
    json = response.get_json()
    assert json['status'] == 'fail'
    assert json["data"] == {
        "name": "name is required",
        "id": 6
    }


def test_updateDDPO_error(client, app):
    """Test updateDDPO endpoint error handling."""
    # Drop table to induce error
    with app.test_request_context():
        db = get_db()
        db.execute('DROP TABLE Organisation;')

    body = {
        "id": 2,
        "name": "Bish DDPO"
    }
    response = client.put('/api/updateDDPO', json=body)
    json = response.get_json()
    assert json['status'] == 'error'
    assert len(json.keys()) == 2
    assert 'message' in json
