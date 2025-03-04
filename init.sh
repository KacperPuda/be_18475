#!/bin/bash

MYSQL_HOST="db"
MYSQL_USER="root"
MYSQL_PASSWORD="student"
DATABASE_NAME="BE_184725"
SQL_FILE="/docker-entrypoint-initdb.d/sqldump.sql"
if mysql -h "$MYSQL_HOST" -P 3306 -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "use $DATABASE_NAME"; then
    mysql -h "$MYSQL_HOST" -P 3306 -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "DROP DATABASE $DATABASE_NAME";
fi
mysql -h "$MYSQL_HOST" -P 3306 -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "CREATE DATABASE $DATABASE_NAME";
mysql -h "$MYSQL_HOST" -P 3306 -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$DATABASE_NAME" < "$SQL_FILE";
systemctl restart memcached
exec apache2-foreground