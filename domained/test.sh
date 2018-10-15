#!/bin/bash

. ../_scripts_/.common.sh

docker run -i --rm security-tools:domained python /domained/domained.py -h | grep -qi "eyewitness"
if [[ ${?} -eq 0 ]]
then
  decho_green "[ok] [domained] test passed!"
  exit 0
else
  decho_red "[error] [domained] test failed!"
  exit 1
fi
