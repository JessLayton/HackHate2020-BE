"""test_factory.py - Test app factory in dataColl"""
from dataColl import create_app


def test_config():
    """Test app factory config"""
    assert not create_app().testing
    assert create_app({'TESTING': True}).testing
