#!/bin/bash

apps=('product' 'category' 'order' 'cart')

for app in "${apps[@]}"
do
  python manage.py startapp $app
done