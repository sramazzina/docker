#!/usr/bin/with-contenv sh

set -e

cp ./hibernate/hibernate-settings.xml $BASERVER_HOME/pentaho-solutions/system/hibernate/hibernate-settings.xml
cp ./hibernate/postgresql.hibernate.cfg.xml $BASERVER_HOME/pentaho-solutions/system/hibernate/postgresql.hibernate.cfg.xml
cp ./jackrabbit/repository.xml $BASERVER_HOME/pentaho-solutions/system/jackrabbit/repository.xml
cp ./META-INF/context.xml $BASERVER_HOME/tomcat/webapps/pentaho/META-INF/context.xml


