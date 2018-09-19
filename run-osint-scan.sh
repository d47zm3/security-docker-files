#!/bin/bash

#target=${1}

docker_pre="docker run -it --rm"

./build-all.sh

echo "[*] starting osint tools for ${target} (domain name: ${domain_name})..."

# create empty file for spiderfoot
if [[ ! -e "$( pwd)/locals/spiderfoot.db" ]]
then
  touch "$( pwd)/locals/spiderfoot.db"
  chmod 777 "$( pwd)/locals/spiderfoot.db"
fi

# spiderfoot
echo "[*] access spiderfoot on $( hostname --all-ip-addresses ) (one of these addresses) and port 5001"
${docker_pre} -p 5001:5001 -v "$( pwd )/locals/spiderfoot.db:/home/spiderfoot/spiderfoot.db" security-tools:spiderfoot 
