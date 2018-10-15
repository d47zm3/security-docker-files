#!/bin/bash

. .common.sh

cd ..
cwd=$( pwd )
for dir in $( ls -d */ | egrep -v "_.*_" | tr '/' ' ')
do
  cd "${dir}"
  if [[ -e "test.sh" ]]
  then
    ./test.sh
    decho_green "[${dir}] test script found..."
    cd ${cwd}
  else
    decho_red "[${dir}] no test script found..."
    cd ${cwd}
  fi
done
