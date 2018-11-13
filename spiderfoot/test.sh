#!/bin/bash

. ../_scripts_/.common.sh

docker run -itd --name spiderfoot-test -p 5001:5001 --rm security-tools:spiderfoot > /dev/null
sleep 10
curl -s http://localhost:5001/ | grep -iq spiderfoot
if [[ ${?} -eq 0 ]]
then
  decho_green "[ok] [spiderfoot] test passed!"
  docker stop spiderfoot-test &>/dev/null
  exit 0
else
  decho_red "[error] [spiderfoot] test failed!"
  docker stop spiderfoot-test &> /dev/null
  exit 1
fi
