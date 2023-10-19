#!/bin/bash

appName="apple4"

mkdir $appName

cd $appName

python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip

pip install Django

python -m django --version

django-admin startproject "app" .

touch Dockerfile
touch docker-compose.yml
touch .env
touch .env.sample
touch README.md
touch .gitignore
touch requirements.txt
touch build.sh
touch run.sh

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

python manage.py startapp iphone

python manage.py migrate

pip freeze >requirements.txt

echo "" >>"run.sh"

printf "#!/bin/bash\npython manage.py runserver" >>"run.sh"
printf "#!/bin/bash\n" >>"build.sh"

code .
bash run.sh
