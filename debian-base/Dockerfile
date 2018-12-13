FROM debian:8.11
MAINTAINER Sergio Ramazzina - sergio.ramazzina@serasoft.it

ENV S6_VER=v1.21.7.0

RUN apt-get update && \
    apt-get install -y curl pwgen && \ 
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_VER}/s6-overlay-amd64.tar.gz | tar xfz - -C /

ENTRYPOINT ["/init"]



