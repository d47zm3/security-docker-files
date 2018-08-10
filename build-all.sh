#!/bin/bash

cwd=$( pwd )
for dir in $( ls -d */ )
do
  cd ${dir}
  image_name=$( cat Dockerfile  | grep image_name | grep -o '".*"' | sed 's/"//g' )
  echo "[*] building ${image_name}..."
  docker build -q -t ${image_name} -f Dockerfile .
  cd ${cwd}
done
