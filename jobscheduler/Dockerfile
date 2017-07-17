
# Serasoft's docker image for JobScheduler SoS
#
# VERSION 2.0
#

FROM serasoft/openjdk-base:8u121
MAINTAINER Sergio Ramazzina, sergio.ramazzina@serasoft.it

# Build arguments
ENV BASE_SOS_REL 1.11
ENV MINOR_REL 2

# Set correct environment variables.
ENV SCHEDULER_HOME /opt/jobscheduler

RUN apt-get update && \
    apt-get upgrade -f -y && \
    apt-get install -f -y wget zip pwgen sudo postgresql-client && \
    wget https://downloads.sourceforge.net/project/jobscheduler/JobScheduler.${BASE_SOS_REL}/JobScheduler.${BASE_SOS_REL}.${MINOR_REL}/jobscheduler_linux-x64.${BASE_SOS_REL}.${MINOR_REL}.tar.gz -O /tmp/jobscheduler_linux-x64.${BASE_SOS_REL}.${MINOR_REL}.tar.gz && \
    cd /tmp && tar -xvzf jobscheduler_linux-x64.${BASE_SOS_REL}.${MINOR_REL}.tar.gz && rm ./jobscheduler_linux-x64.${BASE_SOS_REL}.${MINOR_REL}.tar.gz && \
    touch /root/.pgpass && \
    chmod -Rf 600 /root/.pgpass

COPY /other/jobscheduler_install.xml /tmp/other/jobscheduler_install.xml
COPY /other/wait-for-postgres.sh ${SCHEDULER_HOME}/wait-for-postgres.sh
COPY /other/pg_setup.sql ${SCHEDULER_HOME}/pg_setup.sql

ADD root /

EXPOSE 40444 48444 4444
