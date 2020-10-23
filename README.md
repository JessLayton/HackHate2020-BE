![](https://github.com/JessLayton/HackHate2020-BE/workflows/flask_test/badge.svg)

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

## Testing
The project used pyest as as it's testing framework. Github actions is configured to run these automatically. To run manually:
```
python3 -m pytest tests/
```
