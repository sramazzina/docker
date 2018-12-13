FROM serasoft/debian-base:8.11
MAINTAINER Sergio Ramazzina - sergio.ramazzina@serasoft.it

# Default to UTF-8 file.encoding
ENV LANG=C.UTF-8 \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PATH=$JAVA_HOME/bin:$PATH

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list && \ 
    apt-get update && \
    apt-get install -y -t jessie-backports openjdk-8-jdk 

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
      echo '#!/bin/sh'; \ 
      echo 'set -e'; \ 
      echo; \
      echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
   } > /usr/local/bin/docker-java-home \
   && chmod +x /usr/local/bin/docker-java-home
