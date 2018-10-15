FROM alpine:latest

LABEL maintainer="d47zm3@gmail.com"
LABEL image_name="security-tools:crt.sh"

ADD crt.sh /
RUN apk update && apk del grep && apk add grep && apk add curl && chmod +x /crt.sh
