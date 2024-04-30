#!/bin/bash

apps=$1

for app in "${apps[@]}"
do
  python manage.py startapp $app
done