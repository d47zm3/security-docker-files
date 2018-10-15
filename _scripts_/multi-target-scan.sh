#!/bin/bash

for target in $( cat targets.txt )
do
  ./run-sec-scan.sh "${target}"
done
