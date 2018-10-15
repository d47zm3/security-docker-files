#!/bin/sh

domain=${1}

> output

if [[ -z ${domain} ]]
then
  echo "crt.sh script needs domain name!"
  exit 1
fi
for id in $( curl -s "https://crt.sh/?q=${domain}" | grep ?id= | cut -d \" -f5 | cut -d '<' -f1 | cut -d '>' -f2  )
do
  curl -s https://crt.sh/?id=${id} | grep -oP '(DNS)(.*?)(<BR>)' | cut -d ":" -f2 | cut -d "<" -f1 | sort -u >> output
done

for line in $( cat output | sort -u )
do
  echo "[*] ${line}"
done

rm output

exit 0
