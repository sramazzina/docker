#
# Quartz seems to work best with the driver mm.mysql-2.0.7-bin.jar
#
# In your Quartz properties file, you'll need to set
# org.quartz.jobStore.driverDelegateClass = org.quartz.impl.jdbcjobstore.StdJDBCDelegate
#

CREATE DATABASE IF NOT EXISTS `quartz` DEFAULT CHARACTER SET latin1;

grant all on quartz.* to 'pentaho_user'@'%' identified by '@@DB_PWD@@';
