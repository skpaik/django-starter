#!/bin/bash
baseProjectName="app"

python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip
pip install Django
python -m django --version

django-admin startproject $baseProjectName .