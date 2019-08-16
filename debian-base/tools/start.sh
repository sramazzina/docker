#!/bin/bash

DAEMON_MODE=${DAEMON:-"N"}

if [ "$DAEMON_MODE" == "Y" ]; then
    echo "Running as deamon - DAEMON: $DAEMON"
    /init
elif [ "$DAEMON_MODE" == "N" ]; then
    if [ -f /container-entrypoint.sh ]; then
        echo "Running given container-entrypoint.sh script..."
        /container-entrypoint.sh
    else 
        echo "Opening bash shell...."
        /bin/bash
    fi;
fi;    
