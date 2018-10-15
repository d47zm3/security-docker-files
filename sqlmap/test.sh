#!/bin/bash

. ../_scripts_/.common.sh

docker run -i security-tools:sqlmap /sqlmap/sqlmap.py -h | grep -q RISK
if [[ ${?} -eq 0 ]]
then
  decho_green "[ok] [sqlpmap] test passed!"
  exit 0
else
  decho_red "[error] [sqlmap] test failed!"
  exit 1
fi
