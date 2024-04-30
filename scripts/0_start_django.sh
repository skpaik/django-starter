#!/bin/bash

source ../.env

projectName=$PROJECT_NAME

IFS=',' read -ra apps <<< "$APP_LIST"

cd ..
# rm -rf .git
mkdir $projectName
cd $projectName

. ../scripts/1_install_django.sh
. ../scripts/2_required_files.sh
. ../scripts/3_folders.sh $apps
. ../scripts/4_django_apps.sh $apps
. ../scripts/5_update_docker_file_contents.sh $projectName
. ../scripts/6_update_sh_file_contents.sh $projectName
. ../scripts/7_update_misc_file_contents.sh $projectName
. ../scripts/8_git.sh $projectName

pip freeze >requirements.txt

code .

bash prepare.sh
bash migrate_db.sh

bash run.sh
