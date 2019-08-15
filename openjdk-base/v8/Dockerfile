FROM serasoft/debian-base:9.9
MAINTAINER Sergio Ramazzina - sergio.ramazzina@serasoft.it

# Default to UTF-8 file.encoding
ENV LANG=C.UTF-8 \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH

RUN  apt-get update && \
     apt-get install --no-install-recommends -y openjdk-8-jdk-headless && \
    rm -rf /var/lib/apt/lists/*

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
      echo '#!/bin/sh'; \ 
      echo 'set -e'; \ 
      echo; \
     echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
  } > /usr/local/bin/docker-java-home \
  && chmod +x /usr/local/bin/docker-java-home
