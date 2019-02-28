#!/bin/bash

error=0

dir=${1}

if [[ -z ${dir} ]]
then
  echo "[*] $(date +'%H:%M:%S') usage: ${0} <dir to build>"
  exit 1
fi

cd ..

cwd=$( pwd )
# show build logs, set "-q" to hide output, empty to show it
debug="" 

if [[ -z ${dir} ]]
then
  continue
fi

dir_stripped=$( echo ${dir} | sed "s/\/$//g" )
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
  else
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [[ ${branch} == "master" ]]
    then
      echo "[*] $(date +'%H:%M:%S') master branch, pushing image to repository..."
      docker tag ${image_name} d47zm3/${image_name}
      docker push d47zm3/${image_name}
    fi
  fi
  cd ${cwd}
else
  echo "[*] $(date +'%H:%M:%S') starting build script inside ${dir_stripped}..."
  chmod +x ./build.sh
  ./build.sh > ${dir_stripped}.build.log
  if [[ ${?} -ne 0 ]]
  then
    error=1
    echo "[*] $(date +'%H:%M:%S') building custom image from ${dir_stripped} failed! log is shown below..."
    cat ${dir_stripped}.build.log
  fi
  cd ${cwd}
fi

if [[ ${error} -eq 1 ]]
then
  exit 1
fi
