#!/bin/bash

target=${1}

if [[ -z ${target} ]]
then
  echo "[error] you need to provide target! usage: ${0} <target>"
  exit 1
fi

domain_name=$( echo "${target}/" | grep -o "/\/.*\/" | sed -e "s/\///g")
reports_dir="./reports"

if [[ ! -d "${reports_dir}" ]]
then
  mkdir "${reports_dir}"
fi

docker_pre="docker run -it --rm"

./build-all.sh

echo "[*] running scans for ${target} (domain name: ${domain_name})..."
echo "[*] start time: $( date +'%H:%M %d-%m-%y' )"

nmap_logfile="${reports_dir}/${domain_name}.nmap.log"
nikto_logfile="${reports_dir}/${domain_name}.nikto.log"
htrace_logfile="${reports_dir}/${domain_name}.htrace.log"
owasp_logfile="${reports_dir}/${domain_name}.owasp.log"

# nmap
${docker_pre} security-tools:nmap nmap -A ${domain_name} &> ${nmap_logfile}

# nikto
${docker_pre} security-tools:nikto -host ${target} &> ${nikto_logfile}

# htrace
${docker_pre} security-tools:htrace -d ${target} --scan all --mixed-content --nse -s &> ${htrace_logfile}

# owasp zap proxy - no need to build image
docker run --rm -t owasp/zap2docker-weekly zap-baseline.py -t ${target} &> ${owasp_logfile}

echo "[*] end time: $( date +'%H:%M %d-%m-%y' )"

# arachni - this one takes lots of time, commented out for now
# mkdir -p $PWD/reports $PWD/artifacts;
# docker run  -v $PWD/reports:/arachni/reports ahannigan/docker-arachni bin/arachni ${target} --report-save-path=reports/domain.com.afr;
# docker run --name=arachni_report -v $PWD/reports:/arachni/reports ahannigan/docker-arachni bin/arachni_reporter reports/${domain_name}.afr --reporter=html:outfile=reports/${domain_name}-report.html.zip;
# docker cp arachni_report:/arachni/reports/${domain_name}-report.html.zip $PWD/artifacts;
# docker rm arachni_report;
