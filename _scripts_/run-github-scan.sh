#!/bin/bash

target=${1}

if [[ -z ${target} ]]
then
  echo "[error] you need to provide target username from github! usage: ${0} <github username>"
  exit 1
fi

if [[ -z "${GITROB_ACCESS_TOKEN}" ]]
then
  echo "[error] gitrob needs access token to work! provide it in environmental variables via GITROB_ACCESS_TOKEN!"
  exit 1
fi

reports_dir="./reports"

if [[ ! -d "${reports_dir}" ]]
then
  mkdir "${reports_dir}"
fi

docker_pre="docker run -i --rm"

./build-all.sh

echo "[*] running scans for ${target}"
echo "[*] start time: $( date +'%H:%M %d-%m-%y' )"

gitrob_logfile="${reports_dir}/${target}.gitrob.log"

# gitrob
${docker_pre} -e GITROB_ACCESS_TOKEN=${GITROB_ACCESS_TOKEN} security-tools:gitrob  gitrob ${target} &> ${gitrob_logfile} &
process_pid=$( ps -ef |  grep gitrob | grep docker | awk ' { print $2 } ' )

echo "[*] waiting for gitrob to finish to interrupt it..."
break=0
while [[ ${break} -eq 0 ]]
do
  grep -q "Press Ctrl+C to stop web server and exit." ${gitrob_logfile}
  if [[ ${?} -eq 0 ]]
  then
    kill -SIGINT ${process_pid}
    echo "[*] gitrob has finished!"
    break=1
  fi
  sleep 5
done 

echo "[*] gitrob result"
cat ${gitrob_logfile}

echo "[*] end time: $( date +'%H:%M %d-%m-%y' )"
