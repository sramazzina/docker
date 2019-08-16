FROM debian:9.9
MAINTAINER Sergio Ramazzina - sergio.ramazzina@serasoft.it

ENV S6_VER=v1.22.1.0

# Installed s6Overlay and leave it there if needed by any other subpackage
# For further informations about S6 and its configuration refer to
# - https://github.com/just-containers/s6-overlay
# - http://www.greg-gilbert.com/2017/05/basic-setup-for-s6-and-s6-overlay-in-docker/

COPY tools/start.sh /start.sh

RUN apt-get update && \
    apt-get install -y zip unzip curl pwgen && \ 
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_VER}/s6-overlay-amd64.tar.gz | tar xfz - -C / && \
    chmod +x /start.sh

ENTRYPOINT [ "/start.sh" ]

