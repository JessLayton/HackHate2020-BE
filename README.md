# DDPO Data Hub Backend

Backend code for the DDPO data collection/visualation project for [HackHate 2020](https://www.policecoders.org/home/hack-hate-2020/).

## Installation

Setup the virtual enviroment
```bash
python -m venv venv
```

Install the python dependencies 
```bash
pip install -r requirements.txt
```

Run the app
```bash
export FLASK_APP=dataColl

flask run
```

## Test
The app contains a test API call. Flask will by default be hosted on `http://localhost:5000/`. The API call is available at the route `/time`. You can view this in a broswer by going to `http://localhost:5000/time` or using curl:

```bash
curl http://localhost:5000/time
```