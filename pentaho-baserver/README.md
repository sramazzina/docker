# pentaho-baserver

This is a docker container for Pentaho BA Server

### Starting standalone

This way of starting Pentaho BA Server
* uses the internal HSQL DB to store Pentaho BA Server metadata instead of a more robust Enterprise database
* stores repository on filesystem

```
docker run -d -p 8080:8080 -e "IS_STANDALONE=Y" --name baserver serasoft/pentaho-baserver:7.1.0.0-12

```

Suggested for demo purposes containers' installations.

### Starting Pentaho BA Server by accessing a repository on an external DB

#### Sample of docker-compose file to run Pentaho BA Server with PostgreSQL

```
version: '2'

services:
  postgres-db:
    image: postgres:9.6
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_PASSWORD=postgres
  baserver:
    image: serasoft/pentaho-baserver:7.1.0.0-12
    ports:
      - "8080:8080"
    restart: always
    environment:
      - IS_STANDALONE=N
      - PENTAHO_DB_ADDR=postgres-db
      - PENTAHO_DB_TYPE=postgresql
    depends_on:
      - postgres-db

```

#### Run Pentaho BA Server by using as a repository DB an external Postgres database

```
docker-compose -f ./compose/postgresql/docker-compose.yml up -d
```

#### Sample of docker-compose file to run Pentaho BA Server with MySQL

```
version: '2'

services:
  mysql-db:
    image: mysql:5.7
    ports:
      - "3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=password
  baserver:
    image: serasoft/pentaho-baserver:7.1.0.0-12
    ports:
      - "8080:8080"
    restart: always
    environment:
      - IS_STANDALONE=N
      - PENTAHO_DB_ADDR=mysql-db
      - PENTAHO_DB_TYPE=mysql
    depends_on:
      - mysql-db

```

#### Run Pentaho BA Server by using as a repository DB an external MySQL database

```
docker-compose -f ./compose/mysql/docker-compose.yml up -d
```
TO DO with MySQL -> Upgrade MySQL driver
