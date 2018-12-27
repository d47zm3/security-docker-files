FROM debian:latest

LABEL maintainer="d47zm3@gmail.com"
LABEL image_name="security-tools:sublist3r"


ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install python git python-pip
WORKDIR /opt
RUN git clone https://github.com/aboul3la/Sublist3r.git /opt/sublist3r
RUN cd /opt/sublist3r/ && pip install -r requirements.txt
