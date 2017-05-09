
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
ENV DB_TYPE postgresql

# =============================== Start Image Customization ===================
# Make sure base image is updatet then install needed linux tools
# Install latest postgresql version as pentaho metadata repository
# RUN echo deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main >> /etc/apt/sources.list.d/pgdg.list && \
#     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
RUN apt-get update && \
    apt-get upgrade -f -y && \
    apt-get install -f -y wget git zip pwgen postgresql && \
    useradd -m -d ${PENTAHO_HOME} pentaho

COPY ./dist/pentaho-server-${BASERVER_REL}.zip ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip

RUN unzip -q ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip -d ${PENTAHO_HOME} && \
    rm ${PENTAHO_HOME}/pentaho-server-${BASERVER_REL}.zip && \
    rm ${BASERVER_HOME}/promptuser.sh && \
    # Disable daemon mode for Tomcat so that docker logs works properly
    sed -i -e 's/\(exec ".*"\) start/\1 run/' ${TOMCAT_HOME}/bin/startup.sh && \
    # Set password to generated value
    chown -Rf pentaho:pentaho ${PENTAHO_HOME}

ADD root /

EXPOSE 8080
