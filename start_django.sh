#!/bin/bash

projectName="apple"
apps=('product' 'category' 'order' 'cart')

mkdir $projectName
cd $projectName

. ../install_django.sh
. ../required_files.sh
. ../folders.sh $apps
. ../django_apps.sh $apps
. ../update_files.sh $projectName
. ../migrate_django.sh

code .
bash start.sh
bash run.sh
