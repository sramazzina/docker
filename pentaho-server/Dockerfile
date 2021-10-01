
# Serasoft's docker image for Pentaho Business Analytics
#
# VERSION 2.2
#

FROM serasoft/openjdk-base:v8
MAINTAINER Sergio Ramazzina, sergio.ramazzina@serasoft.it

# Build arguments
ARG BASERVER_REL

# Set correct environment variables.
ENV PENTAHO_HOME /usr/pentaho
ENV BASERVER_HOME ${PENTAHO_HOME}/pentaho-server
ENV TOMCAT_HOME ${BASERVER_HOME}/tomcat
# ENV PLUGIN_SET marketplace,cdf,cda,cde,cgg

RUN apt-get update && \
    apt-get install --no-install-recommends -f -y wget unzip pwgen sudo postgresql-client mysql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove && \
    useradd -m -d ${PENTAHO_HOME} pentaho

COPY ./dist/pentaho-server-ce-${BASERVER_REL}.zip ${PENTAHO_HOME}/pentaho-server-ce-${BASERVER_REL}.zip

RUN unzip -q ${PENTAHO_HOME}/pentaho-server-ce-${BASERVER_REL}.zip -d ${PENTAHO_HOME} && \
    rm ${PENTAHO_HOME}/pentaho-server-ce-${BASERVER_REL}.zip && \
    rm ${BASERVER_HOME}/promptuser.sh && \
    # Disable daemon mode for Tomcat so that docker logs works properly
    sed -i -e 's/\(exec ".*"\) start/\1 run/' ${TOMCAT_HOME}/bin/startup.sh 
    # && \
    # echo "postgres-db:5432:postgres:postgres:postgres" > /root/.pgpass && \
    # chmod -Rf 600 /root/.pgpass

# Add all files needed to properly initialize the container
COPY utils ${BASERVER_HOME}/utils
COPY other ${BASERVER_HOME}/other

RUN chown -Rf pentaho:pentaho ${BASERVER_HOME}

ADD root /

#EXPOSE 8080
