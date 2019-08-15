#
# Serasoft's docker image for Pentaho Data Integration
#
# VERSION	1.2
#

FROM serasoft/openjdk-base:v8
MAINTAINER Sergio Ramazzina, sergio.ramazzina@serasoft.it

# Build time argument to contain the PDI release we want to build
ARG PDI_REL

# Set correct environment variables.
ENV HOME /root
ENV PENTAHO_HOME /usr/pentaho
ENV PDI_HOME ${PENTAHO_HOME}/data-integration
ENV DATA_VOLUME ${PENTAHO_HOME}/data-volume
ENV SCRIPT_VOLUME ${PENTAHO_HOME}/etl-scripts
ENV LOG_VOLUME ${PENTAHO_HOME}/etl-logs
ENV KETTLE_PROPERTIES_PATH ${PENTAHO_HOME}/.kettle

ENV ETL_SCRIPTS_HOME ${SCRIPT_VOLUME}
ENV ETL_LOGS_HOME ${LOG_VOLUME}

# =============================== Start Image Customization ===================
# Make sure base image is updated then install needed linux tools
RUN apt-get update && \
    apt-get install --no-install-recommends -y zip unzip pwgen sudo libwebkitgtk-1.0-0 git && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p ${PENTAHO_HOME} && \
    mkdir -p ${DATA_VOLUME} && \
    mkdir -p ${SCRIPT_VOLUME} && \
    mkdir -p ${LOG_VOLUME}    && \
    useradd -d ${PENTAHO_HOME} pentaho     

COPY ./dist/pdi-ce-${PDI_REL}.zip ${PENTAHO_HOME}

RUN unzip ${PENTAHO_HOME}/pdi-ce-${PDI_REL}.zip -d ${PENTAHO_HOME}  && \
    rm ${PENTAHO_HOME}/pdi-ce-${PDI_REL}.zip && \
    rm ${PDI_HOME}/lib/log4j-1.2.14.jar && \
    # sed 's/"$DIR/sudo -u pentaho "$DIR/g' ${PDI_HOME}/kitchen.sh > ${PDI_HOME}/kitchen.new.sh && \
    # sed 's/"$DIR/sudo -u pentaho "$DIR/g' ${PDI_HOME}/pan.sh > ${PDI_HOME}/pan.new.sh && \
    # rm ${PDI_HOME}/kitchen.sh ${PDI_HOME}/pan.sh && \
    # mv ${PDI_HOME}/kitchen.new.sh ${PDI_HOME}/kitchen.sh && \
    # mv ${PDI_HOME}/pan.new.sh ${PDI_HOME}/pan.sh && \
    mkdir -p ${KETTLE_PROPERTIES_PATH} && \
# Add parameter to show path to steps in trasformation's log
    echo 'KETTLE_LOG_MARK_MAPPINGS=Y' >> ${KETTLE_PROPERTIES_PATH}/kettle.properties

# Add all files needed t properly initialize the container
COPY utils ${PDI_HOME}/utils
COPY templates ${PDI_HOME}/templates
COPY ./dist/lib/*.jar ${PDI_HOME}/lib/

# Set password to generated value
RUN chown -Rf pentaho:pentaho ${PENTAHO_HOME}
ADD root /

USER pentaho
# EXPOSE 8080
