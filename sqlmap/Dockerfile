FROM python:2.7

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 0.9

RUN apt-get update && apt-get install -y git --no-install-recommends

RUN git clone https://github.com/sqlmapproject/sqlmap.git \
    && cd sqlmap
