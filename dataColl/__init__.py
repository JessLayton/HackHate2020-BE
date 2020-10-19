import os
from flask import Flask
from datetime import datetime



def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'dataColl.sqlite'),
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # a test route 
    @app.route('/time')
    def get_current_time():
        now = datetime.now()
        dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
        return {'time': dt_string}

    
    from . import db
    db.init_app(app)

    from . import api
    app.register_blueprint(api.bp)
    return app