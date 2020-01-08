#
# Serasoft's docker image for Pentaho Data Integration
#
# VERSION	1.3
#

FROM serasoft/openjdk-base:v8
MAINTAINER Sergio Ramazzina, sergio.ramazzina@serasoft.it

# Build time argument to contain the PDI release we want to build
ARG PDI_REL

# Set correct environment variables.
ENV PENTAHO_HOME /usr/pentaho
ENV PDI_HOME ${PENTAHO_HOME}/data-integration
ENV DATA_VOLUME ${PENTAHO_HOME}/data-volume
ENV SCRIPT_VOLUME ${PENTAHO_HOME}/etl-scripts
ENV LOG_VOLUME ${PENTAHO_HOME}/etl-logs
ENV KETTLE_PROPERTIES_PATH /root/.kettle

ENV ETL_SCRIPTS_HOME ${SCRIPT_VOLUME}
ENV ETL_LOGS_HOME ${LOG_VOLUME}

# =============================== Start Image Customization ===================
# Make sure base image is updated then install needed linux tools
RUN apt-get update && \
    apt-get install --no-install-recommends -y zip unzip pwgen sudo libwebkitgtk-1.0-0 git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove && \
    mkdir -p ${PENTAHO_HOME} && \
    mkdir -p ${DATA_VOLUME} && \
    mkdir -p ${SCRIPT_VOLUME} && \
    mkdir -p ${LOG_VOLUME}# && \
    useradd -d ${PENTAHO_HOME} pentaho     

COPY ./dist/pdi-ce-${PDI_REL}.zip ${PENTAHO_HOME}

RUN unzip ${PENTAHO_HOME}/pdi-ce-${PDI_REL}.zip -d ${PENTAHO_HOME}  && \
    rm ${PENTAHO_HOME}/pdi-ce-${PDI_REL}.zip && \
    rm ${PDI_HOME}/lib/log4j-1.2.14.jar && \
    rm -Rf ${PDI_HOME}/plugins/pentaho-big-data-plugin && \
    mkdir -p ${KETTLE_PROPERTIES_PATH} && \
    ln -s ${DATA_VOLUME} /data-volume && \
    ln -s ${SCRIPT_VOLUME} /etl-scripts && \
    ln -s ${LOG_VOLUME} /etl-logs && \
    ln -s ${PDI_HOME} /pdi && \
# Add parameter to show path to steps in trasformation's log
    echo 'KETTLE_LOG_MARK_MAPPINGS=Y' >> ${KETTLE_PROPERTIES_PATH}/kettle.properties


# Add all files needed t properly initialize the container
COPY utils ${PDI_HOME}/utils
COPY templates ${PDI_HOME}/templates
COPY ./dist/lib/*.jar ${PDI_HOME}/lib/

# Set password to generated value
# RUN chown -Rf pentaho:pentaho ${PENTAHO_HOME}
ADD root /

EXPOSE 8080
