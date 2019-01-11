#!/bin/bash

ignore="maltego"

error=0

cd ..
cwd=$( pwd )
# show build logs, set "-q" to hide output, empty to show it
debug="" 
for dir in $( ls -d */ | grep -v ${ignore} )
do
  cd "${dir}"
  # if Dockerfile exists
  if [[ -e "Dockerfile" ]]
  then
    image_name=$( cat Dockerfile  | grep image_name | grep -o '".*"' | sed 's/"//g' )
    echo "[*] $(date +'%H:%M:%S') building ${image_name}..."
    docker build ${debug} -t ${image_name} --no-cache -f Dockerfile . > ${image_name}.build.log
    if [[ ${?} -ne 0 ]]
    then
      error=1
      echo "[*] $(date +'%H:%M:%S') building ${image_name} failed! log is shown below..."
      cat ${image_name}.build.log
    fi
    cd ${cwd}
  else
    echo "[*] $(date +'%H:%M:%S') starting build script..."
    chmod +x ./build.sh
    ./build.sh > ${dir}.build.log
    if [[ ${?} -ne 0 ]]
    then
      error=1
      echo "[*] $(date +'%H:%M:%S') building custom image from ${dir} failed! log is shown below..."
      cat ${dir}.build.log
    fi
    cd ${cwd}
  fi
done
