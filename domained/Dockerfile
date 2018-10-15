FROM debian:latest

LABEL maintainer="d47zm3@gmail.com"
LABEL image_name="security-tools:domained"

RUN apt update
RUN apt -y install python3 python3-dev python3-pip libldns-dev golang git
RUN git clone https://github.com/cakinney/domained.git && cd domained && pip3 install requests &&  pip3 install -r ./ext/requirements.txt && python3 domained.py --install && pip install requests dnspython configparser && pip3 install requests dnspython configparser
