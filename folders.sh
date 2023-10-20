#!/bin/bash


mkdir "static"
mkdir "static/assets"
mkdir "static/assets/css"
mkdir "static/assets/fonts"
mkdir "static/assets/images"
mkdir "static/assets/js"
mkdir "templates"
mkdir "templates/layouts"
mkdir "templates/includes"
mkdir "templates/pages"


apps=$1

for app in "${apps[@]}"
do
  mkdir "templates/pages/$app"
done