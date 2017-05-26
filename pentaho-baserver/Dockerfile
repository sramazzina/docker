
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

# Set default metadata DB to postgresql
ENV PENTAHO_DB_TYPE postgresql

RUN apt-get update && \
    apt-get upgrade -f -y && \
    apt-get install -f -y wget git zip sudo pwgen && \
    useradd -m -d ${PENTAHO_HOME} pentaho

COPY ./dist/pentaho-server-${BASERVER_REL}.zip ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip

RUN unzip -q ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip -d ${PENTAHO_HOME} && \
    rm ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip && \
    rm ${BASERVER_HOME}/promptuser.sh && \
    # Disable daemon mode for Tomcat so that docker logs works properly
    sed -i -e 's/\(exec ".*"\) start/\1 run/' ${TOMCAT_HOME}/bin/startup.sh

# Add all files needed to properly initialize the container
COPY utils ${BASERVER_HOME}/utils
COPY other ${BASERVER_HOME}/other

#COPY other/db/${PENTAHO_DB_TYPE}/create_jcr_${PENTAHO_DB_TYPE}.sql ${BASERVER_HOME}/data/${PENTAHO_DB_TYPE}/create_jcr_${PENTAHO_DB_TYPE}.sql
#COPY other/db/${PENTAHO_DB_TYPE}/create_quartz_${PENTAHO_DB_TYPE}.sql ${BASERVER_HOME}/data/${PENTAHO_DB_TYPE}/create_quartz_${PENTAHO_DB_TYPE}.sql
#COPY other/db/${PENTAHO_DB_TYPE}/create_repository_${PENTAHO_DB_TYPE}.sql ${BASERVER_HOME}/data/${PENTAHO_DB_TYPE}/create_repository_${PENTAHO_DB_TYPE}.sql
#COPY ./other/db/dummy_quartz_table.sql ${BASERVER_HOME}/data/postgresql/dummy_quartz_table.sql

#COPY other/pentaho/system/${PENTAHO_DB_TYPE}/applicationContext-spring-security-hibernate.properties ${BASERVER_HOME}/pentaho-solutions/system/applicationContext-spring-security-hibernate.properties
#COPY other/pentaho/system/${PENTAHO_DB_TYPE}/hibernate-settings.xml ${BASERVER_HOME}/pentaho-solutions/system/hibernate/hibernate-settings.xml
#COPY other/pentaho/system/${PENTAHO_DB_TYPE}/quartz.properties ${BASERVER_HOME}/pentaho-solutions/system/quartz/quartz.properties
#COPY other/pentaho/system/${PENTAHO_DB_TYPE}/repository.xml ${BASERVER_HOME}/pentaho-solutions/system/jackrabbit/repository.xml
#COPY other/pentaho/system/${PENTAHO_DB_TYPE}/postgresql.hibernate.cfg.xml ${BASERVER_HOME}/pentaho-solutions/system/hibernate/postgresql.hibernate.cfg.xml

#COPY other/tomcat/${PENTAHO_DB_TYPE}/context.xml ${BASERVER_HOME}/tomcat/webapps/pentaho/META-INF/context.xml
#COPY other/tomcat/web* ${BASERVER_HOME}/tomcat/webapps/pentaho/WEB-INF/

RUN chown -Rf pentaho:pentaho ${BASERVER_HOME}

ADD root /

EXPOSE 8080
