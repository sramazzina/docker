#!/usr/bin/with-contenv sh

set -e

if [ -f /.all_templates_processed ]; then
    echo "Pentaho BA Server containerized installation templates already changed!"
    exit 0
fi

# Generate password
PASS=${PENTAHO_DB_USER_PWD:-$(pwgen -s 12 1)}
echo
echo "=================================================================================="
echo "=> Modifying jcr_user, hibusr and pentaho_usr passwords to ${PASS}"
echo "=================================================================================="
echo

cd /opt/pentaho/biserver-ce

sed -i 's/@@DB_PWD@@/'${PASS}'/g' `find $BASERVER_HOME/data/${DB_TYPE} -name *.sql`
sed -i 's/@@DB_PWD@@/'${PASS}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name *.properties`
sed -i 's/@@DB_PWD@@/'${PASS}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name *.xml`
sed -i 's/@@DB_PWD@@/'${PASS}'/g' `find $BASERVER_HOME/tomcat/webapps -name *.xml`

DB_HOST=${PENTAHO_DB_PORT_5432_TCP_ADDR:-'localhost'}
echo "=> Modifying database host to ${DB_HOST}"

sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/data/${DB_TYPE} -name *.sql`
sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name *.properties`
sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name *.xml`
sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/tomcat/webapps -name *.xml`
sed -i 's/@@DB_HOST@@/'${DB_HOST}'/g' `find $BASERVER_HOME/utils -name init_pentaho_db.sh`


DB_PORT=${PENTAHO_DB_PORT_5432_TCP_PORT:-5432}
echo "=> Modifying database port to ${DB_PORT}"

sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/data/${DB_TYPE} -name *.sql`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name *.properties`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name *.xml`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/tomcat/webapps -name *.xml`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/utils -name init_pentaho_db.sh`


echo "Pentaho BA Server containerized installation templates processed successfully!"
touch /.all_templates_processed
