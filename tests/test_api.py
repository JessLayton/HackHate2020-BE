"""test_api.py - Test API endpoints"""
import pytest
from dataColl import api


def test_getDDPOs(client):
    """Test getDDPOs endpoint."""
    response = client.get('/api/getDDPOs')
    json = response.get_json()
    assert json == [
        {'id': 1, 'name': 'Foo DDPO'},
        {'id': 2, 'name': 'Bar DDPO'},
        {'id': 3, 'name': 'Baz DDPO'}
    ]

def test_form(client):
    pass