#!/bin/bash
python manage.py migrate

pip freeze >requirements.txt