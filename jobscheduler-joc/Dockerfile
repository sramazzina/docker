
# Serasoft's docker image for JobScheduler SoS
#
# VERSION 2.0
#

FROM serasoft/openjdk-base:8u121
MAINTAINER Sergio Ramazzina, sergio.ramazzina@serasoft.it

# Build arguments
ENV BASE_SOS_REL 1.11
# Chosen 1.11.1 because 1.11.2 has a bug with PostgreSQL that will be solved in 1.11.3
ENV MINOR_REL 1

# Set correct environment variables.
ENV SCHEDULER_HOME /opt/jobscheduler/joc

RUN apt-get update && \
    apt-get upgrade -f -y && \
    apt-get install -f -y wget pwgen sudo && \
    wget https://downloads.sourceforge.net/project/jobscheduler/JobScheduler.${BASE_SOS_REL}/JobScheduler.${BASE_SOS_REL}.${MINOR_REL}/joc_linux.${BASE_SOS_REL}.${MINOR_REL}.tar.gz -O /tmp/joc_linux.${BASE_SOS_REL}.${MINOR_REL}.tar.gz && \
    cd /tmp && tar -xvzf joc_linux.${BASE_SOS_REL}.${MINOR_REL}.tar.gz && rm ./joc_linux.${BASE_SOS_REL}.${MINOR_REL}.tar.gz && \
    touch /root/.pgpass && \
    chmod -Rf 600 /root/.pgpass

COPY /other/joc_install.xml /tmp/other/joc_install.xml
COPY /other/wait-for-postgres.sh ${SCHEDULER_HOME}/wait-for-postgres.sh

ADD root /

EXPOSE 4446

ENTRYPOINT ["/init"]
