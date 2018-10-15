#!/bin/bash

. ../_scripts_/.common.sh

docker run -i --rm security-tools:gobuster gobuster -h 2>&1 | grep -iq "wordlist"
if [[ ${?} -eq 0 ]]
then
  decho_green "[ok] [gobuster] test passed!"
  exit 0
else
  decho_red "[error] [gobuster] test failed!"
  exit 1
fi
