#
# Serasoft's docker image for Pentaho Data Integration
#
# VERSION	1.2
#

FROM serasoft/openjdk-base:8u121
MAINTAINER Sergio Ramazzina, sergio.ramazzina@serasoft.it

# Set correct environment variables.
ENV HOME /root
ENV PENTAHO_HOME /usr/pentaho
ENV PDI_HOME ${PENTAHO_HOME}/data-integration
ENV BASE_REL 7.0
ENV REV 0.6-91

# =============================== Start Image Customization ===================
# Make sure base image is updated then install needed linux tools
RUN apt-get update && \
    apt-get install -y zip pwgen sudo libwebkitgtk-1.0-0 && \
    mkdir -p ${PENTAHO_HOME} && \
    useradd -d ${PENTAHO_HOME}  pentaho

COPY ./dist/pdi-ce-${BASE_REL}.${REV}.zip ${PENTAHO_HOME}

RUN unzip ${PENTAHO_HOME}/pdi-ce-${BASE_REL}.${REV}.zip -d ${PENTAHO_HOME}  && \
    rm ${PENTAHO_HOME}/pdi-ce-${BASE_REL}.${REV}.zip

# Add all files needed t properly initialize the container
COPY utils ${PDI_HOME}/utils
COPY templates ${PDI_HOME}/templates

# Set password to generated value
RUN chown -Rf pentaho:pentaho ${PENTAHO_HOME}
ADD root /

EXPOSE 8080

