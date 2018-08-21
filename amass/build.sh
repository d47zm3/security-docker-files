#!/bin/bash

git clone https://github.com/OWASP/Amass.git src
cd src
docker build -t security-tools:amass .
