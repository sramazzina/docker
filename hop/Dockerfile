#
# Serasoft's docker image for Apache Hop
#
# VERSION	1.0
#

FROM serasoft/alpine-java:v8
MAINTAINER Project Hop Team + Serasoft

# Argument Branch name, used to download correct version
ARG HOP_REL

ENV BRANCH_NAME=$HOP_REL
# path to where the artefacts should be deployed to
ENV DEPLOYMENT_PATH=/opt/project-hop
# volume mount point
# parent directory in which the hop config artefacts live
# ENV HOP_HOME= ...
# specify the hop log level
ENV HOP_LOG_LEVEL=Basic
# path to hop workflow or pipeline e.g. ~/project/main.hwf
ENV HOP_FILE_PATH=
# file path to hop log file, e.g. ~/hop.err.log
ENV HOP_LOG_PATH=$DEPLOYMENT_PATH/hop.err.log
# path to hop config directory
# ENV /files/project= DISABLED for now 
# path to jdbc drivers
ENV HOP_SHARED_JDBC_DIRECTORY=
# name of the Hop project to use
ENV HOP_PROJECT_NAME=
# path to the home of the hop project. should start with `/files`.
ENV HOP_PROJECT_DIRECTORY=
# name of the project config file including file extension
ENV HOP_PROJECT_CONFIG_FILE_NAME=project-config.json
# environment to use with hop run
ENV HOP_ENVIRONMENT_NAME=
# comma separated list of paths to environment config files (including filename and file extension). paths should start with `/files`.
ENV HOP_ENVIRONMENT_CONFIG_FILE_NAME_PATHS=
# hop run configuration to use
ENV HOP_RUN_CONFIG=
# parameters that should be passed on to the hop-run command
# specify as comma separated list, e.g. PARAM_1=aaa,PARAM_2=bbb
ENV HOP_RUN_PARAMETERS=
# any JRE settings you want to pass on
# The “-XX:+AggressiveHeap” tells the container to use all memory assigned to the container. 
# this removed the need to calculate the necessary heap Xmx
ENV HOP_OPTIONS=-XX:+AggressiveHeap
# Path to hop 
ENV HOP_HOME=$DEPLOYMENT_PATH/hop

# Serasoft specific dirs and settings
ENV DATA_VOLUME ${DEPLOYMENT_PATH}/data-volume
ENV SCRIPT_VOLUME ${DEPLOYMENT_PATH}/etl-scripts
ENV LOG_VOLUME ${DEPLOYMENT_PATH}/etl-logs

# Define it_IT.
ENV LANGUAGE it_IT.UTF-8
ENV LANG it_IT.UTF-8
ENV LC_ALL it_IT.UTF-8
ENV LC_CTYPE it_IT.UTF-8
ENV LC_MESSAGES it_IT.UTF-8

# INSTALL REQUIRED PACKAGES AND ADJUST LOCALE
# procps: The package includes the programs ps, top, vmstat, w, kill, free, slabtop, and skill

RUN apk update \
  && apk add --no-cache bash curl procps \ 
  && rm -rf /var/cache/apk/* \
  && mkdir -p ${DEPLOYMENT_PATH} \
  && mkdir -p ${DATA_VOLUME} \
  && mkdir -p ${SCRIPT_VOLUME} \
  && mkdir -p ${LOG_VOLUME} \
  && adduser -D -s /bin/bash -h ${DEPLOYMENT_PATH} hop \
  && chown hop:hop ${DEPLOYMENT_PATH}
#  && sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
#  && locale-gen \
#  && update-locale LANG=${LANG} LC_ALL={LC_ALL}

# copy the hop package from the local resources folder to the container image directory
COPY --chown=hop:hop ./dist/hop-client-${HOP_REL}.zip ${DEPLOYMENT_PATH}

RUN unzip ${DEPLOYMENT_PATH}/hop-client-${HOP_REL}.zip -d ${DEPLOYMENT_PATH}  && \
    rm ${DEPLOYMENT_PATH}/hop-client-${HOP_REL}.zip && \
    ln -s ${DATA_VOLUME} /data-volume && \
    ln -s ${SCRIPT_VOLUME} /etl-scripts && \
    ln -s ${LOG_VOLUME} /etl-logs && \
    ln -s ${HOP_HOME} /hop && \
    chown hop:hop -Rf ${DEPLOYMENT_PATH} && \
    chown hop:hop ${DATA_VOLUME} && \
    chown hop:hop ${SCRIPT_VOLUME} && \
    chown hop:hop ${LOG_VOLUME}

EXPOSE 8080

# make volume available so that hop pipeline and workflow files can be provided easily
VOLUME ["/files"]
USER hop
ENV PATH=$PATH:${DEPLOYMENT_PATH}/hop
WORKDIR ${DEPLOYMENT_PATH}

# ENTRYPOINT ["/bin/bash", "${HOP_HOME}/run.sh"]