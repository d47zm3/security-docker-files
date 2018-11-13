#!/bin/bash

. ../_scripts_/.common.sh

docker run -i --rm security-tools:crt.sh /crt.sh github.com | grep -iq "github.io"

if [[ ${?} -eq 0 ]]
then
  decho_green "[ok] [crt.sh] test passed!"
  exit 0
else
  decho_red "[error] [crt.sh] test failed!"
  exit 1
fi
