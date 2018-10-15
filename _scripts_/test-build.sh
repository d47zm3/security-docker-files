#!/bin/bash

echo "[*] $(date +'%H:%M:%S') checking existing images..."
exist=$( docker images | grep -q security-tools | wc -l )

if [[ ${exist} -ne 0 ]]
then
  echo "[*] $(date +'%H:%M:%S') removing existing images..."
  docker rmi -f $( docker images | grep security-tools | awk ' { print $3 } ' )
fi

echo "[*] $(date +'%H:%M:%S') starting fresh build..."
./build-all.sh
