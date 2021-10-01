#!/usr/bin/with-contenv sh

set -e

if [ -f $BASERVER_HOME/.pentaho_db_already_initialized ]; then
    echo "The instance of Pentaho BA Server configured!"
    exit 0
fi

# Generate postgres user's password
PASS=${PENTAHO_DB_USER_PWD:-$(pwgen -s 12 1)}
echo
echo "=================================================================================="
echo "=> Applying configuration found in directory $CONFIG_NAME"
echo "=================================================================================="
echo

if [ -f $BASERVER_HOME/other/config/$CONFIG_NAME/start_copy.sh ]; then
    echo "Starting copy of configuration files to appropriate locations in BA Server"
    sudo -u pentaho $BASERVER_HOME/other/config/${CONFIG_NAME}/start_copy.sh
fi

if [ ! "$PENTAHO_FQN" = "" ]; then
   
echo "=> Overriding server FQN to ${PENTAHO_FQN}"
sed -i 's#http://localhost:8080#'${PENTAHO_FQN}'#g' $BASERVER_HOME/pentaho-solutions/system/server.properties

fi; 

if [ ! "$PENTAHO_PORT" = "" ]; then
echo "=> Overriding internal server HTTP port to ${PENTAHO_PORT}"
sed -i 's#8080#'${PENTAHO_PORT}'#g' $BASERVER_HOME/tomcat/conf/server.xml
fi;

echo "Pentaho BA Server PostgreSQL database initialized successfully!"
sudo -u pentaho touch $BASERVER_HOME/.pentaho_db_already_initialized
