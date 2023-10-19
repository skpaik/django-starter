#!/bin/bash

projectName="apple5"
apps=('product' 'category' 'order' 'cart')

mkdir $projectName
cd $projectName

. ../install_django.sh
. ../required_files.sh
. ../folders.sh $apps
. ../django_apps.sh $apps
. ../update_files.sh $projectName

code .
bash run.sh
