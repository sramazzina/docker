FROM alpine:3.14
MAINTAINER Sergio Ramazzina - sergio.ramazzina@serasoft.it

ENV S6_VER=v2.2.0.3

# Installed s6Overlay and leave it there if needed by any other subpackage
# For further informations about S6 and its configuration refer to
# - https://github.com/just-containers/s6-overlay
# - http://www.greg-gilbert.com/2017/05/basic-setup-for-s6-and-s6-overlay-in-docker/

COPY tools/start.sh /start.sh

RUN apk update && \
    apk add --no-cache bash procps zip unzip curl pwgen && \ 
    rm -rf /var/cache/apk/* && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_VER}/s6-overlay-amd64.tar.gz | tar xfz - -C / && \
    chmod +x /start.sh

ENTRYPOINT [ "/start.sh" ]

