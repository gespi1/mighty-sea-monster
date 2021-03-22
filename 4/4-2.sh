#/bin/bash 

docker ps -a  | grep Exited | sed 's+\".*\"++' | tr -s ' ' | cut -d ' ' -f 1,3-4 | grep -A10000 "7 weeks" | cut -d ' ' -f 1 | while read line; do echo "deleting ${line}"; docker rm  $line; done