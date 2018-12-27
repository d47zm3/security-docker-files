#!/bin/bash

. ../_scripts_/.common.sh

docker run -i --rm security-tools:sublist3r python /opt/sublist3r/sublist3r.py -h | grep -q "bruteforce"
if [[ ${?} -eq 0 ]]
then
  decho_green "[ok] [sublist3r] test passed!"
  exit 0
else
  decho_red "[error] [sublist3r] test failed!"
  exit 1
fi
