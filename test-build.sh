#!/bin/bash

echo "[*] removing existing images..."
docker rmi -f $( docker images | grep security-tools | awk ' { print $3 } ' )

echo "[*] starting fresh build..."
./build-all.sh
