#!/bin/bash

cd ..
cwd=$( pwd )
# show build logs, set "-q" to hide output, empty to show it
debug="" 
for dir in $( ls -d */ )
do
  cd "${dir}"
  # if Dockerfile exists
  if [[ -e "Dockerfile" ]]
  then
    image_name=$( cat Dockerfile  | grep image_name | grep -o '".*"' | sed 's/"//g' )
    echo "[*] $(date +'%H:%M:%S') building ${image_name}..."
    docker build ${debug} -t ${image_name} -f Dockerfile .
    cd ${cwd}
  else
    echo "[*] $(date +'%H:%M:%S') starting build script..."
    cd ${cwd}
  fi
done
