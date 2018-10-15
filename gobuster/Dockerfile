FROM golang:latest

LABEL maintainer="d47zm3@gmail.com"
LABEL image_name="security-tools:gobuster"

RUN git clone https://github.com/OJ/gobuster.git
RUN cd gobuster && go get github.com/OJ/gobuster && go build && cp gobuster ../bin/
