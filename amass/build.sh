#!/bin/bash

git clone https://github.com/OWASP/Amass temporary
cd temporary
docker build -t security-tools:amass . > amass.build.log
if [[ ${?} -ne 0 ]]
then
  echo "[ERROR] amass failed to build! log shown below!"
  cat amass.build.log
  exit 1
fi

