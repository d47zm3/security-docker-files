#   For build:
#     docker build --rm -t htrace.sh -f Dockerfile .
#
#   For init:
#     docker run --rm -it --name htrace.sh htrace.sh -d http://nmap.org -h
#
# License:
#
#   htrace.sh, Copyright (C) 2018  Michał Żurawski
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see <http://www.gnu.org/licenses/>.
#
### END SCRIPT INFO

FROM debian:stretch

MAINTAINER trimstray "trimstray@gmail.com"
LABEL image_name="security-tools:htrace"

ENV GOROOT="/usr/lib/go"
ENV GOPATH="/opt/go"

# System tools.
RUN \
  apt-get update && \
  apt-get install -y ca-certificates dnsutils gnupg apt-utils unzip

RUN \
  apt-get install -y --reinstall procps

# htrace.sh tools.
RUN \
  apt-get update && \
  apt-get install -y git openssl curl bc wget alien

# For Mozilla-Observatory.
RUN \
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g observatory-cli

# For Ssllabs API.
RUN \
  apt-get install -y golang && \
  go get github.com/ssllabs/ssllabs-scan && \
  ln -s /opt/go/bin/ssllabs-scan /usr/bin/ssllabs-scan

# For mixed-content-scan.
RUN \
  apt-get install -y composer php-curl php-dom && \
  composer global require bramus/mixed-content-scan && \
  ln -s /root/.composer/vendor/bramus/mixed-content-scan/bin/mixed-content-scan \
  /usr/bin/mixed-content-scan

# For Nmap NSE Library.

RUN wget https://nmap.org/dist/nmap-7.70-1.x86_64.rpm
RUN alien nmap-7.70-1.x86_64.rpm
RUN dpkg -i nmap_7.70-2_amd64.deb

RUN \
  mkdir -p /opt/git && cd /opt/git && \
  git clone https://github.com/trimstray/htrace.sh.git && \
  cd htrace.sh && \
  bash setup.sh install

# Remove some clean tasks.
RUN \
  apt-get -y remove --purge git && \
  apt-get clean && apt-get autoclean && \
  apt-get -y autoremove --purge && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/htrace.sh"]
CMD ["--help"]
