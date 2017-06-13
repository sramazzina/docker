#!/usr/bin/with-contenv sh

set -e

if [ -f $BASERVER_HOME/.pentaho_db_already_initialized ]; then
    echo "The instance of Pentaho BA Server PostgreSQL database is already initialized!"
    exit 0
fi

# Generate postgres user's password
PASS=${PENTAHO_DB_USER_PWD:-$(pwgen -s 12 1)}
echo
echo "=================================================================================="
echo "=> Modifying jcr_user, hibusr and pentaho_usr passwords to ${PASS}"
echo "=================================================================================="
echo

echo "postgres-db:5432:quartz:pentaho_user:${PASS}" >> /root/.pgpass

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

DB_PORT=${PENTAHO_DB_PORT:-5432}
echo "=> Modifying database port to ${DB_PORT}"

sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/data/${PENTAHO_DB_TYPE} -name '*.sql'`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name '*.properties'`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/pentaho-solutions/system -name '*.xml'`
sed -i 's/@@DB_PORT@@/'${DB_PORT}'/g' `find $BASERVER_HOME/tomcat/webapps -name '*.xml'`

DB_HOST=${PENTAHO_DB_ADDR:-'localhost'}
DB_PORT=${PENTAHO_DB_PORT:-5432}

echo "Referenced Postgres Host - Host: ${DB_HOST}, Port: ${DB_PORT}"

$BASERVER_HOME/utils/wait-for-postgres.sh $DB_HOST

psql -h $DB_HOST -p $DB_PORT -U postgres -f $BASERVER_HOME/data/postgresql/create_repository_postgresql.sql
psql -h $DB_HOST -p $DB_PORT -U postgres -f $BASERVER_HOME/data/postgresql/create_jcr_postgresql.sql
psql -h $DB_HOST -p $DB_PORT -U postgres -f $BASERVER_HOME/data/postgresql/create_quartz_postgresql.sql
psql -h $DB_HOST -p $DB_PORT -U pentaho_user quartz -f $BASERVER_HOME/data/postgresql/create_quartz_postgresql_tables.sql

echo "Pentaho BA Server PostgreSQL database initialized successfully!"
touch $BASERVER_HOME/.pentaho_db_already_initialized
