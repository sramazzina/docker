#!/usr/bin/with-contenv sh

set -e

if [ -f $BASERVER_HOME/.pentaho_db_already_initialized ]; then
    echo "The instance of Pentaho BA Server MySQL database is already initialized!"
    exit 0
fi

# Generate postgres user's password
PASS=${PENTAHO_DB_USER_PWD:-$(pwgen -s 12 1)}
echo
echo "=================================================================================="
echo "=> Modifying jcr_user, hibusr and pentaho_usr passwords to ${PASS}"
echo "=================================================================================="
echo

sed -i 's/@@DB_PWD@@/'${PASS}'/g' `find $BASERVER_HOME/data/${PENTAHO_DB_TYPE} -name '*.sql'`
sed -i 's/@@DB_PWD@@/'${PASS}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name '*.properties'`
sed -i 's/@@DB_PWD@@/'${PASS}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name '*.xml'`
sed -i 's/@@DB_PWD@@/'${PASS}'/g' `find $BASERVER_HOME/tomcat/webapps -name '*.xml'`

DB_HOST=${PENTAHO_DB_ADDR:-'localhost'}
echo "=> Modifying database host to ${DB_HOST}"

sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/data/${PENTAHO_DB_TYPE} -name '*.sql'`
sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name '*.properties'`
sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name '*.xml'`
sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/tomcat/webapps -name '*.xml'`

DB_PORT=${PENTAHO_DB_PORT:-3306}
echo "=> Modifying database port to ${DB_PORT}"

sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/data/${PENTAHO_DB_TYPE} -name '*.sql'`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name '*.properties'`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name '*.xml'`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/tomcat/webapps -name '*.xml'`

echo "Referenced MySQL Host - Host: ${DB_HOST}, Port: ${DB_PORT}"

$BASERVER_HOME/utils/wait-for-mysql.sh $DB_HOST $DB_PORT password

mysql -h $DB_HOST -uroot -ppassword < $BASERVER_HOME/data/mysql/create_repository_mysql.sql
mysql -h $DB_HOST -uroot -ppassword < $BASERVER_HOME/data/mysql/create_jcr_mysql.sql
mysql -h $DB_HOST -uroot -ppassword < $BASERVER_HOME/data/mysql/create_quartz_mysql.sql
mysql -h $DB_HOST -upentaho_user -p$PASS quartz < $BASERVER_HOME/data/mysql/create_quartz_mysql_tables.sql

echo "Pentaho BA Server PostgreSQL database initialized successfully!"
touch $BASERVER_HOME/.pentaho_db_already_initialized
