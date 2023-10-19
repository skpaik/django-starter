#!/bin/bash

echo "" >>"run.sh"

printf "#!/bin/bash\npython manage.py runserver" >>"run.sh"
printf "#!/bin/bash\n" >>"build.sh"