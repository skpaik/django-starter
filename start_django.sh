#!/bin/bash

appName="apple5"
mkdir $appName
cd $appName

. ../install_django.sh
. ../required_files.sh
. ../folders.sh
. ../django_apps.sh
. ../update_files.sh

code .
bash run.sh
