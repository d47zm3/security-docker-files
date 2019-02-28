#!/bin/bash

. ../_scripts_/.common.sh

docker run -i --rm security-tools:eyewitness | grep -iq "FortyNorth Security"

if [[ ${?} -eq 0 ]]
then
  decho_green "[ok] [eyewitness] test passed!"
  exit 0
else
  decho_red "[error] [eyewitness] test failed!"
  exit 1
fi
