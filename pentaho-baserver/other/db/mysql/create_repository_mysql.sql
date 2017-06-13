CREATE DATABASE IF NOT EXISTS `hibernate` DEFAULT CHARACTER SET latin1;

USE hibernate;

GRANT ALL ON hibernate.* TO 'hibuser'@'%' identified by '@@DB_PWD@@'; 

commit;
