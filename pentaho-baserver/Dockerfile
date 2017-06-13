
# Serasoft's docker image for Pentaho Business Analytics
#
# VERSION 2.0
#

FROM serasoft/openjdk-base:8u121
MAINTAINER Sergio Ramazzina, sergio.ramazzina@serasoft.it

# Build arguments
ARG BASERVER_REL

# Set correct environment variables.
ENV PENTAHO_HOME /usr/pentaho
ENV BASERVER_HOME ${PENTAHO_HOME}/pentaho-server
ENV TOMCAT_HOME ${BASERVER_HOME}/tomcat
ENV PLUGIN_SET marketplace,cdf,cda,cde,cgg

RUN apt-get update && \
    apt-get upgrade -f -y && \
    apt-get install -f -y wget zip sudo pwgen postgresql-client mysql-client && \
    useradd -m -d ${PENTAHO_HOME} pentaho

COPY ./dist/pentaho-server-${BASERVER_REL}.zip ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip

RUN unzip -q ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip -d ${PENTAHO_HOME} && \
    rm ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip && \
    rm ${BASERVER_HOME}/promptuser.sh && \
    # Disable daemon mode for Tomcat so that docker logs works properly
    sed -i -e 's/\(exec ".*"\) start/\1 run/' ${TOMCAT_HOME}/bin/startup.sh && \
    echo "postgres-db:5432:postgres:postgres:postgres" > /root/.pgpass && \
    chmod -Rf 600 /root/.pgpass

# Add all files needed to properly initialize the container
COPY utils ${BASERVER_HOME}/utils
COPY other ${BASERVER_HOME}/other

RUN chown -Rf pentaho:pentaho ${BASERVER_HOME}

ADD root /

EXPOSE 8080
