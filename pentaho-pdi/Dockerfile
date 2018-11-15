#
# Serasoft's docker image for Pentaho Data Integration
#
# VERSION	1.2
#

FROM serasoft/openjdk-base:8u121
MAINTAINER Sergio Ramazzina, sergio.ramazzina@serasoft.it

# Build time argument to contain the PDI release we want to build
ARG PDI_REL

# Set correct environment variables.
ENV HOME /root
ENV PENTAHO_HOME /usr/pentaho
ENV PDI_HOME ${PENTAHO_HOME}/data-integration
ENV DATA_VOLUME /data-volume
ENV SCRIPT_VOLUME /etl_scripts
ENV LOG_VOLUME /etl_logs

ENV ETL_SCRIPTS_HOME ${SCRIPT_VOLUME}
ENV ETL_LOGS_HOME ${LOG_VOLUME}

# =============================== Start Image Customization ===================
# Make sure base image is updated then install needed linux tools
RUN apt-get update && \
    apt-get install -y zip pwgen sudo libwebkitgtk-1.0-0 git && \
    mkdir -p ${PENTAHO_HOME} && \
    mkdir -p ${DATA_VOLUME} && \
    mkdir -p ${SCRIPT_VOLUME} && \
    mkdir -p ${LOG_VOLUME} && \
    useradd -d ${PENTAHO_HOME} pentaho 
     

COPY ./dist/pdi-ce-${PDI_REL}.zip ${PENTAHO_HOME}

RUN unzip ${PENTAHO_HOME}/pdi-ce-${PDI_REL}.zip -d ${PENTAHO_HOME}  && \
    rm ${PENTAHO_HOME}/pdi-ce-${PDI_REL}.zip && \
#    sed "s/,pentaho-metaverse,pdi-dataservice,pdi-data-refinery//g" ${PDI_HOME}/system/karaf/etc/org.apache.karaf.features.cfg > ${PDI_HOME}/system/karaf/etc/org.apache.karaf.features.cfg.1 && \
    sed "s/,pdi-data-refinery//g" ${PDI_HOME}/system/karaf/etc/org.apache.karaf.features.cfg > ${PDI_HOME}/system/karaf/etc/org.apache.karaf.features.cfg.1 && \
    mv ${PDI_HOME}/system/karaf/etc/org.apache.karaf.features.cfg ${PDI_HOME}/system/karaf/etc/org.apache.karaf.features.cfg.ori && \
    mv ${PDI_HOME}/system/karaf/etc/org.apache.karaf.features.cfg.1 ${PDI_HOME}/system/karaf/etc/org.apache.karaf.features.cfg

# Add all files needed t properly initialize the container
COPY utils ${PDI_HOME}/utils
COPY templates ${PDI_HOME}/templates

# Set password to generated value
RUN chown -Rf pentaho:pentaho ${PENTAHO_HOME} ${DATA_VOLUME} ${LOG_VOLUME} ${SCRIPT_HOME}
ADD root /

EXPOSE 8080

